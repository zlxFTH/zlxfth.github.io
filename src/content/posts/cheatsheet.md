---
title: 备忘
published: 2025-02-10
description: ''
image: ''
tags: ['']
category: 'Misc'
draft: false 
lang: ''
---

```sh
# 链接
ssh -p port root@ip
# 懒得输入密码了
ssh-copy-id -i ~/.ssh/id_ed25519.pub -p 2222 root@1.2.3.4
```

```
# .ssh/config
Host MyServer
    HostName ip
    Port 1234
    User root
    RemoteForward 7897 127.0.0.1:7897 # 转发代理
```
