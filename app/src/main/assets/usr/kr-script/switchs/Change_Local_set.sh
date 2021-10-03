if [[ -f ~/offline2 ]]; then
    rm ~/offline2
else
    touch ~/offline2
    rm -f $Load
    cp -f $Load.bak $Load
fi