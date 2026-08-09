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

bashrc/zshrc：

```zsh
# 配置 wsl 走 win clash verge 代理
proxy() {
  export http_proxy="http://127.0.0.1:7897"
  export https_proxy="http://127.0.0.1:7897"
  export all_proxy="socks5://127.0.0.1:7897"

  export HTTP_PROXY="$http_proxy"
  export HTTPS_PROXY="$https_proxy"
  export ALL_PROXY="$all_proxy"

  echo "终端代理已开启"
}
unproxy() {
  unset http_proxy https_proxy all_proxy
  unset HTTP_PROXY HTTPS_PROXY ALL_PROXY

  echo "终端代理已关闭"
}
proxy
```

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

## WSL: 打开文件和文件夹

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

用默认应用打开当前目录的文件

```sh
open a.txt
```

现在功能类似 Mac 的 open，这样就可以指哪里打哪里了。

唯一的问题是 open 打开文件后面不能使用相对路径，但是可以打开子目录文件夹，应该会有更好的解决方案。好像有个东西叫 wslu，有空来研究这个。

## WSL: 终端

懒人套装

+ Zsh

```sh
sudo apt install -y zsh
chsh -s $(which zsh)
echo $SHELL
```

+ Oh My Zsh 

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

autosuggestions

```sh
git clone https://github.com/zsh-users/zsh-autosuggestions \
${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

syntax-highlighting

```sh
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

修改 zshrc

```zsh
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)
```

+ Starship 

```sh
curl -sS https://starship.rs/install.sh | sh
```

修改 zshrc

```zsh
eval "$(starship init zsh)"
```

主题

```sh
starship preset catppuccin-powerline -o ~/.config/starship.toml
```

+ zoxide

```sh
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
```

修改 zshrc

```zsh
eval "$(zoxide init zsh)"
```

+ Windows Terminal 主题

```json
{
  "name": "Catppuccin Mocha",
  "black": "#45475a",
  "red": "#f38ba8",
  "green": "#a6e3a1",
  "yellow": "#f9e2af",
  "blue": "#89b4fa",
  "purple": "#f5c2e7",
  "cyan": "#94e2d5",
  "white": "#bac2de",
  "brightBlack": "#585b70",
  "brightRed": "#f38ba8",
  "brightGreen": "#a6e3a1",
  "brightYellow": "#f9e2af",
  "brightBlue": "#89b4fa",
  "brightPurple": "#f5c2e7",
  "brightCyan": "#94e2d5",
  "brightWhite": "#a6adc8",
  "background": "#1e1e2e",
  "foreground": "#cdd6f4",
  "selectionBackground": "#585b70",
  "cursorColor": "#f5e0dc"
}
```

+ 常用快捷键
  + `ctrl + u`：清空当前输入命令。
  + `ctrl + a`：跳转开头。
  + `ctrl + e`：跳转结尾。
  + `ctrl + ←/→`：跳转单词。
  + `ctrl + w`：删除这个单词光标前的部分。
  + `ctrl + k`：删除光标后的所有。
  + `ctrl + l`：清屏。

+ 把 Windows Terminal 的声音关了，烦求的很。
