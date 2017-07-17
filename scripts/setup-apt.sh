function apt-install {
    for pkg in $@; do
        echo -e "[APT-GET] Installing package $pkg..."
        apt-get install -yq $pkg
    done
}


function apt-install-if-needed {
    for pkg in $@; do
        if package-not-installed $pkg; then
            apt-install $pkg
        fi
    done
}


function package-not-installed {
    test -z "$(dpkg -s $1 2> /dev/null | grep Status)"
}

apt-get -y update
apt-get -y upgrade
apt-get -y dist-upgrade
