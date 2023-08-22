import psutil
import platform
import cpuinfo
import socket
import uuid
import re
import os
import subprocess
import json
import distro



def get_size(bytes, suffix="B"):
    """
    Scale bytes to its proper format
    e.g:
        1253656 => '1.20MB'
        1253656678 => '1.17GB'
    """
    factor = 1024
    for unit in ["", "K", "M", "G", "T", "P"]:
        if bytes < factor:
            return f"{bytes:.2f}{unit}{suffix}"
        bytes /= factor

def get_disks_info():
    hdd = psutil.disk_partitions()
    data = []
    for each in hdd:
        device = each.device
        path = each.mountpoint
        fstype = each.fstype

        drive = psutil.disk_usage(path)
        total = drive.total
        total = total / 1000000000
        used = drive.used
        used = used / 1000000000
        free = drive.free
        free = free / 1000000000
        percent = drive.percent
        drives = {
            "device": device,
            "path": path,
            "fstype": fstype,
            "total": float("{0: .2f}".format(total)),
            "used": float("{0: .2f}".format(used)),
            "free": float("{0: .2f}".format(free)),
            "percent": percent
        }
        data.append(drives)
    return data

def get_core_information():
    data = []
    for i, percentage in enumerate(psutil.cpu_percent(percpu=True, interval=1)):
        core_number =  "Core " + str(i)
        core_load = str(percentage) + "%"
        cores = {
            core_number: core_load
        }
        data.append(cores)
    return data

def get_interfaces():
    if_addrs = psutil.net_if_addrs()
    data = []
    for interface_name, interface_addresses in if_addrs.items():
        for address in interface_addresses:
            interfaces_name_key = "Interface"
            interfaces_name_value = interface_name
            if str(address.family) == 'AddressFamily.AF_INET':
                interfaces_inet_address_key = "AF_INET IP Address"
                interfaces_inet_address_value = address.address
            elif str(address.family) == 'AddressFamily.AF_PACKET':
                interfaces_packet_address_key = "AF_PACKET IP Address"
                interfaces_packet_address_value = address.address
            interfaces_netmask_key = "Netmask"
            interfaces_netmask_value = address.netmask
            interfaces_broadcast_key = "Broadcast IP:"
            interfaces_broadcast_value = address.broadcast
        interfaces = {
            interfaces_name_key: interfaces_name_value,
            interfaces_inet_address_key: interfaces_inet_address_value,
            interfaces_packet_address_key: interfaces_packet_address_value,
            interfaces_netmask_key: interfaces_netmask_value,
            interfaces_broadcast_key: interfaces_broadcast_value
        }
        data.append(interfaces)
    return data

def system_information():
    exit_code = subprocess.call(["which", "lvm2"])
    if exit_code != 0:
        LVM_INFO = "N/A"
        PVS_INFO = "N/A"
        VGS_INFO = "N/A"
        LVS_INFO = "N/A"
    else:
        LVM_INFO = "Available"
        PVS_INFO = os.system("pvs")
        VGS_INFO = os.system("vgs")
        LVS_INFO = os.system("lvs")
    if (os.path.isfile ("/sys/devices/virtual/dmi/id/product_name")) == True:
        VIRTUALIZATION_INFO = os.system("cat /sys/devices/virtual/dmi/id/product_name")
    else:
        VIRTUALIZATION_INFO = "N/A"
    if (os.path.isfile ("cat /proc/mdstat")) == True:
        RAID = os.system("cat /proc/mdstat")
    else:
        RAID = "N/A"
    uname = platform.uname()
    svmem = psutil.virtual_memory()
    swap = psutil.swap_memory()
    disk_io = psutil.disk_io_counters()
    disks_info = get_disks_info()
    cores_info = get_core_information()
    net_io = psutil.net_io_counters()
    info = {
        "cluster": {
            'System': {
                'Node Name': uname.node,
                'OS': distro.name(pretty=True),
                'Kernel': platform.platform(),
                'Virtualization': VIRTUALIZATION_INFO,
            },
            'Processor': {
                'Processor': cpuinfo.get_cpu_info()['brand_raw'],
                'Architecture': platform.machine(),
                'Physical cores': psutil.cpu_count(logical=False),
                'Total cores': psutil.cpu_count(logical=True),
                'Load Average': os.getloadavg(),
                'Total CPU Usage': psutil.cpu_percent(),
                'Cores': cores_info
            },
            'RAM': {
                'Total RAM': get_size(svmem.total),
                'Available RAM': get_size(svmem.available),
                'Used RAM': get_size(svmem.used),
                'Total SWAP': get_size(swap.total),
                'Free SWAP': get_size(swap.free),
                'Used SWAP': get_size(swap.used),
            },
            'Disks': {
                'LVM': LVM_INFO,
                'PVS': PVS_INFO,
                'VGS': VGS_INFO,
                'LVS': LVS_INFO,
                'RAID': RAID,
                'Total read': get_size(disk_io.read_bytes),
                'Total write': get_size(disk_io.write_bytes),
                'Disks': disks_info
                
            },
            'Network': {
                'Ip-Address': socket.gethostbyname(socket.gethostname()),
                'Mac-Address': ':'.join(re.findall('..', '%012x' % uuid.getnode())),
                'Total Bytes Sent': get_size(net_io.bytes_sent),
                'Total Bytes Received': get_size(net_io.bytes_recv),
                'Interfaces': get_interfaces()
            }
        }
    }

    return (json.dumps(info))


if __name__ == "__main__":
    print(system_information())