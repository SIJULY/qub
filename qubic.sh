#!/bin/bash

# 修正程序路径（假设 apoolminer 在 /root 目录）
APOOL_DIR="/root"
LOG_FILE="$APOOL_DIR/qubic.log"

# 获取 Worker 名称
WORKER=$(curl -s https://api.ipify.org || echo "default_worker")
[ -n "$CUSTOM_WORKER" ] && WORKER=$CUSTOM_WORKER

# 检查进程是否存在
if pgrep -f "apoolminer.*apool.io" >/dev/null; then
    echo "ApoolMiner already running."
    exit 1
else
    cd "$APOOL_DIR" || exit 1
    nohup ./apoolminer --account CP_0codi1cvup --worker "$WORKER" --gpu-off --cpu-threads 8 --pool qubic1.hk.apool.io:3334 >> "$LOG_FILE" 2>&1 &
    echo "ApoolMiner started. Log: $LOG_FILE"
fi
