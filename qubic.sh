#!/bin/bash

WORKER=$(curl -s https://api.ipify.org || echo "default_worker")

if [ -n "$CUSTOM_WORKER" ]; then
    WORKER=$CUSTOM_WORKER
fi

# 修复进程检查逻辑
if pgrep -f "apoolminer.*apool.io" >/dev/null; then
    echo "ApoolMiner already running."
    exit 1
else
    # 确保进入正确目录
    cd /root/apoolminer_linux_v2.8.1 || exit 1
    # 赋予可执行权限（仅需一次）
    chmod +x apoolminer
    # 启动并记录日志
    nohup ./apoolminer --account CP_0codi1cvup --worker "$WORKER" --gpu-off --pool qubic1.hk.apool.io:3334 >> qubic.log 2>&1 &
    echo "ApoolMiner started. Check logs: /root/apoolminer_linux_v2.8.1/qubic.log"
fi
