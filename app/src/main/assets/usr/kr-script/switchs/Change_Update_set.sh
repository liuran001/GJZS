if [[ -f ~/offline || -f ~/offline2 ]]; then
        if [[ -f ~/offline2 ]]; then
            echo '! 您必须关闭离线模式后才可开启此功能'
            exit 1
        fi
    rm ~/offline
else
    touch ~/offline
fi