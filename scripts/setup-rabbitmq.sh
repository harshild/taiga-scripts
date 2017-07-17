# rabbitmq.sh

function rabbit-create-user-if-needed {
    username=$1
    password=$2
    $(rabbitmqctl list_users | grep -q "$username") || rabbitmqctl add_user $username $password
}

function rabbit-create-vhost-if-needed {
    vhost=$1
    $(rabbitmqctl list_vhosts | grep -q "$vhost") || rabbitmqctl add_vhost $vhost
}

function rabbit-set-permissions {
    username=$1
    vhost=$2
    configure=$3
    write=$4
    read=$5
    rabbitmqctl set_permissions -p $vhost $username "$configure" "$write" "$read"
}

function rabbit-activate-plugin {
    plugin=$1
    if ! grep -q "$plugin" /etc/rabbitmq/enabled_plugins; then
        rabbitmq-plugins enable "$plugin"
        /etc/init.d/rabbitmq-server stop
        rabbitmqctl stop
        /etc/init.d/rabbitmq-server start
    fi
}


if [ ! -e ~/.setup/rabbitmq ]; then
    touch ~/.setup/rabbitmq

    apt-install-if-needed rabbitmq-server
fi
