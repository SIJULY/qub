#!/bin/bash

WORKER=$(curl -s https://api.ipify.org)

if [ -n "$CUSTOM_WORKER" ]; then
    WORKER=$CUSTOM_WORKER
fi

cd /root || exit 1  # 确保切换到正确的目录

if pgrep -f 'apoolminer.*apool.io' > /dev/null; then
    echo "ApoolMiner already running."
    exit 1
else
    chmod +x /root/apoolminer  # 确保矿机可执行
    nohup /root/apoolminer --account CP_0codi1cvup --worker "$WORKER" --gpu-off --pool qubic1.hk.apool.io:3334 >> /root/qubic.log 2>&1 &
    echo "ApoolMiner started."
fi
