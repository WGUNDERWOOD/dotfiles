# ~/.bash_profile

echo "bash_profile" &

# run .bashrc
[[ -f $HOME/.bashrc ]] && . $HOME/.bashrc &

if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
    echo "started x" &

    # start x
    exec startx

fi
