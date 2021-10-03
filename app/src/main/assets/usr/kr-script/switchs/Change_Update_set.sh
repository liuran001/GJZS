if [[ -f ~/offline || -f ~/offline2 ]]; then
    [[ -f ~/offline2 ]] && exit 1
    rm ~/offline
    [[ -f $ShellScript/APP_Version.sh ]] && rm $ShellScript/APP_Version.sh
else
    touch ~/offline
fi