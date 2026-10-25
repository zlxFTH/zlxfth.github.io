#!/bin/sh
set -eu

cd -- "$(dirname -- "$0")"

printf '\n[1/3] 构建 Blog\n'
npm run build

printf '\n[2/3] 保存改动\n'
git add .
if git diff --cached --quiet; then
    printf '没有新的改动，继续推送已有提交。\n'
else
    git commit -m "update my blog"
fi

printf '\n[3/3] 推送到 GitHub\n'
# 当前网络下通过 Clash 的 SOCKS 代理连接 GitHub SSH 22 端口。
# 只影响本次推送，不修改全局 SSH 配置；GIT_SSH_COMMAND 可覆盖此设置。
git -c core.sshCommand='ssh -o HostName=github.com -p 22 -o ConnectTimeout=15 -o ConnectionAttempts=1 -o StrictHostKeyChecking=yes -o "ProxyCommand=nc -X 5 -x 127.0.0.1:7897 %h %p"' push
