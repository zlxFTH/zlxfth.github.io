---
title: Windows+WSL 调教备忘录
published: 2026-07-25
description: 'Mac 转 Win+WSL 了。'
image: ''
tags: []
category: 'Misc'
draft: false
lang: ''
---

一些小的设置就不记录了，基本上就是用不顺手马上就在设置里调一下，用一段时间自然就好了。

## QuickLook

Link：[官网](https://quicklook.cc/)

把 macOS Finder 的空格预览搬过来的开源软件。

装了 Office / PDF / PS / CAD 预览插件。

问题：感觉有点慢。

## 加速窗口动画

注册表：`HKEY_CURRENT_USER\Control Panel\Desktop`。找到 `MenuShowDelay`，值从 $400$ 改成 $100$。重启电脑。

在保留动画的同时显著减少卡顿，这个对于外接 60Hz 显示器优化及其明显。

## 字体

<https://font.subf.dev/zh-cn/download/>，Maple Mono（编辑器）Maple Mono NF（带图标，控制器）Maple Mono NF CN（带图标，中日字符）

## WSL: Network

进 WSL 设置把 Net 改成 Mirrored 模式。

## WSL: git

**设置 HTTP/HTTPS 代理**

```sh
git config --global http.proxy http://127.0.0.1:7897
git config --global https.proxy http://127.0.0.1:7897
```

**取消 HTTP/HTTPS 代理**

```sh
git config --global --unset http.proxy
git config --global --unset https.proxy
```

**设置 SSH 代理**

+ 打开 `~/.ssh/config`
+ 写入

```
Host github.com
  User git
  # 使用 connect-proxy 转发（推荐，WSL2 兼容性最好）
  ProxyCommand nc -X 5 -x 127.0.0.1:7897 %h %p
```

+ 设置

```sh
chmod 600 ~/.ssh/config
```

+ 测试

```sh
ssh -T git@github.com
```

## WSL: 编译工具

```sh
sudo apt-get install -y build-essential
make --version
```

## WSL: 打开文件管理器

```sh
sudo cp /mnt/c/Windows/explorer.exe /usr/local/bin/open
```

打开 explorer

```sh
open
```

打开 explorer 当前目录

```sh
open .
```

类似 Mac 的 open 那样，这样就可以指哪里打哪里了。

好像有个东西叫 wslu，有空来研究这个工具。
