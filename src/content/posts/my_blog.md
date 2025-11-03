---
title: 博客备忘
published: 2024-12-06
description: '换了新的域名和新的博客，为了有纪念意义一点，本文发布日期设置于 CTT 结束的最后一天。'
image: ''
tags: []
category: 'DevOps'
draft: false 
lang: ''
---

从 Hexo+NexT 换到了 Astro+Fuwari，偶然间看到一个 Furry CPer 在用这个主题后立刻喜欢上了。之前在本地搭起来了，最终在 251103 成功传到了 Github Pages 上。

与 Hexo 不同的是，Astro 是直接把整个博客源码全部传到 Github 仓库上，通过 Github Action 远程构建 Github Pages。我感觉这样挺好的，至少不会因为源码丢了无法再更新博客了。

然后 Astro 有几个优点，一是本地修改自动刷新预览，二是不用配置 LaTeX，三是图片能和 markdown 文件放在一起，这样本地 Typora 也能看了！

不过我现在不是很了解 Astro 和 Fuwari 主题的项目架构，以后慢慢摸索着魔改吧。

## 创建主题

<https://github.com/saicaca/fuwari>

## 配置 Github Action

<https://docs.astro.build/zh-cn/guides/deploy/>

记得在仓库里面设置 Github Action 的权限。

## 本地上传脚本

```sh
npm run build || exit
git add . || exit
git commit -m "update my blog" || exit
git push origin master || exit
```

