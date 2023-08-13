USERS=$(w)
function users_check {
    echo "###############################################"
    echo
    echo -e "01. Current Logged In Users"
    echo
    USERS=$(w)
    echo
	echo "###############################################"
    echo
    echo -e "02. List User Names"
    echo
    cut -d: -f1 /etc/passwd
    echo
	echo -e "03. Check for Null Passwords"
    echo
    users="$(cut -d: -f 1 /etc/passwd)"
    for x in $users
    do
    passwd -S $x |grep "NP"
    done
	echo "###############################################"
    echo
    echo -e "04. Password Policies"
    echo
    cat /etc/pam.d/common-password
    echo
}
