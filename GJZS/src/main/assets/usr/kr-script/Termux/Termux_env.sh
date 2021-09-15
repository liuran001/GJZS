#!/data/data/com.termux/files/usr/bin/bash

#环境变量 任何终端均可调用termux命令
export LD_PRELOAD=/data/data/com.termux/files/usr/lib/libtermux-exec.so
export LD_LIBRARY_PATH=/data/data/com.termux/files/usr/lib
export PATH=/data/data/com.termux/files/usr/bin:/data/data/com.termux/files/usr/bin/applets:/system/bin:/system/xbin:/sbin:/sbin/bin
export _=/data/data/com.termux/files/usr/bin/env
export HOME=/data/data/com.termux/files/home
export TMPDIR=/data/data/com.termux/files/usr/tmp

export SHELL=/data/data/com.termux/files/usr/bin/bash
export BASH=/data/data/com.termux/files/usr/bin/bash
export HISTFILE=/data/data/com.termux/files/home/.bash_history

[[ -f "$1" ]] && $BASH "$1"
