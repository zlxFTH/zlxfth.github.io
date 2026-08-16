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

## QuickLook

Link：[官网](https://quicklook.cc/)

把 macOS Finder 的空格预览搬过来的开源软件。

装了 Office / PDF / PS / CAD 预览插件。

问题：感觉有点慢。

## Listary

<www.listary.net>，双击 ctrl 启动搜索应用和文件。

有空过来氪个 pro 版，挺干净的。

## 关闭快速启动

控制面板电源选项那里。

## 减少内存占用

+ 进 services.msc 把 SysMain 杀掉。

## 加速窗口动画

注册表：`HKEY_CURRENT_USER\Control Panel\Desktop`。找到 `MenuShowDelay`，值从 $400$ 改成 $100$。重启电脑。

在保留动画的同时显著减少卡顿，这个对于外接 60Hz 显示器优化及其明显。

## 字体

<https://font.subf.dev/zh-cn/download/>，Maple Mono（编辑器）Maple Mono NF（带图标，控制器）Maple Mono NF CN（带图标，中日字符）

## WSL: Network

老方法是在 `bashrc/zshrc` 设置 http/https 的 proxy，但是没有办法在 Codex Windows App 里面使用代理。

进 WSL 设置把 Net 改成 Mirrored 模式。

打开 `C:\Users\你的用户名\.wslconfig`，修改

```
[wsl2]
networkingMode=Mirrored
dnsTunneling=true
autoProxy=true
```

## WSL: Git

HTTP/HTTPS 已经在 WSL: Network 里面设置。

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
export STARSHIP_LOG=error
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

## WSL: Yazi

TUI 文件管理器

```sh
curl -LO https://github.com/sxyazi/yazi/releases/latest/download/yazi-x86_64-unknown-linux-musl.zip
unzip yazi-x86_64-unknown-linux-musl.zip
sudo mv yazi-x86_64-unknown-linux-musl/yazi /usr/local/bin/
sudo mv yazi-x86_64-unknown-linux-musl/ya /usr/local/bin/
```

编辑 zshrc，退出 TUI 自动走到当前目录

```bash
function yz() {
  local tmp="$(mktemp -t yazi-cwd.XXXXXX)"
  yazi "$@" --cwd-file="$tmp"

  if [ -f "$tmp" ]; then
    local cwd="$(cat "$tmp")"
    if [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
      cd "$cwd"
    fi
  fi

  rm -f "$tmp"
}
```

+ `hjkl` 控制方向。

+ `q` 退出。
+ `d` 删除文件到回收站 `~/.local/share/Trash `
+ `r` 重命名。

## WSL: Vim



## WSL: 解压缩

```sh
sudo apt install zip unzip
```

使用：

```sh
zip archive.zip file.txt
zip archive.zip a.txt b.txt c.txt
zip -r archive.zip folder/
unzip archive.zip
unzip archive.zip -d target/
unzip -l archive.zip
```

## WSL: Python

+ uv

```sh
curl -LsSf https://astral.sh/uv/install.sh | sh
```

```sh
uv python list # 查看可用 Python
uv python install 3.12
uv init
uv python pin 3.12
uv venv
source .venv/bin/activate
```

## WSL: Rust



## WSL: Node.js

+ nvm

注意检查 curl 的链接最新版本。

```sh
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

nvm -v
```

+ nodejs/npm

```sh
nvm install --lts

nvm use --lts
nvm alias default 'lts/*'

node -v
npm -v
```

+ pnpm

```sh
corepack enable

corepack prepare pnpm@latest --activate

pnpm -v
```

+ npm 换源

```sh
npm config set registry https://registry.npmmirror.com
npm config get registry
```

恢复：

```sh
npm config set registry https://registry.npmjs.org
```

+ pnpm 换源

```sh
pnpm config set registry https://registry.npmmirror.com
pnpm config get registry
```

恢复：

```sh
pnpm config set registry https://registry.npmjs.org
```

## ChatGPT/Codex

+ 桌面版

微软应用商店安装 ChatGPT。参考 WSL: Network 章节，WSL 采用 Mirrored 模式走了 Clash 代理能正常使用 Codex TUI，但是 Codex Windows App 把工作环境切换到 WSL 之后一直  request timed out，问题是：Desktop 启动的 WSL app-server 里，大写 `HTTP_PROXY/HTTPS_PROXY` 是空值。这个空值在它当前的网络请求链里覆盖/干扰了有效的小写代理变量。简单来说就是大小写代理变量问题，大写没设置。

解决方案：在 Windows 用户环境变量中设置大写代理。在 PowerShell 中，分别运行两个：

```powershell
[Environment]::SetEnvironmentVariable(
  "HTTP_PROXY",
  "http://127.0.0.1:7897",
  "User"
)
[Environment]::SetEnvironmentVariable(
  "HTTPS_PROXY",
  "http://127.0.0.1:7897",
  "User"
)
```

+ TUI 版本（WSL: Codex）

## TradingView

## 同花顺

A 股人工下单交易。

## STranslate

划词翻译工具，目前用的默认微软翻译+金山词霸。

设置 Ctrl + Win + Alt + Shift + F 为划词翻译。

其他快捷键全部关了。

## AutoHotkey

注意是 V2 版本的。快捷键管理。

每个映射都是用 `.ahk` 保存的。

开机启动需要把脚本快捷方式拖到 `C:\Users\Nalumi\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup` 里面。

+ 映射 CapsLock + F -> Ctrl + Win + Alt + Shift + F，用于划词翻译。

```
#Requires AutoHotkey v2.0

; 禁用 CapsLock 原本的单按逻辑，避免误触大写切换
SetCapsLockState "AlwaysOff"

; 将 CapsLock + F 映射为 Ctrl + Win + Shift + Alt + F
CapsLock & f::Send "^!+#f"

; 如果你仍想通过 Shift + CapsLock 来切换大小写，可以取消下面这行的注释：
; +CapsLock::SetCapsLockState GetKeyState("CapsLock", "T") ? "AlwaysOff" : "AlwaysOn"
```

