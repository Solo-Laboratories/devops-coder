#!/bin/bash

if [ ! -f $HOME/.vnc/passwd ] ; then
    if  [ -z "$PASSWORD" ] ; then
        PASSWORD=`pwgen -c -n -1 12`
        echo -e "PASSWORD = $PASSWORD" > $HOME/password.txt
        echo "Generated password: " && cat $HOME/password.txt
    fi

    echo "$USER:$PASSWORD" | chpasswd

    # Set up vncserver
    su $USER -c "mkdir $HOME/.vnc && echo '$PASSWORD' | vncpasswd -f > $HOME/.vnc/passwd && chmod 600 $HOME/.vnc/passwd && touch $HOME/.Xresources"
    chown -R $USER:$USER $HOME

    if [ ! -z "$SUDO" ]; then
        case "$SUDO" in
            [yY]|[yY][eE][sS])
                adduser $USER sudo
        esac
    fi
else
    VNC_PID=`find $HOME/.vnc -name '*.pid'`
    if [ ! -z "$VNC_PID" ] ; then
        vncserver -kill :1
        rm -rf /tmp/.X1*
    fi
fi

/usr/bin/supervisord -n