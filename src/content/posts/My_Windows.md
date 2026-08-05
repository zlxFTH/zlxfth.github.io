---
title: Windows 11 调教记录
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
