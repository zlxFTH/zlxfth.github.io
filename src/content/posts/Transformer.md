---
title: 感受一下 Transformer
published: 2026-01-01
description: ''
image: ''
tags: []
category: 'AI'
draft: false 
lang: ''
---

## 前言

## 概览

## Tokenization

Seq2Seq，输入是一段文字序列，进 Transformer 之前要先加工成统一的格式，向量。

```

```

中文：把一个字或者这个字的 UTF-8 序列切成一个 Token。

## Word Embedding

变成 Token ID 序列之后还要转换成向量序列。

这一步叫 Word Embedding（词嵌入）。

记 Token ID 数量为 $V$。

显然不能建立维度数量 = Token ID 数量的空间（每个 Token 对应维取 1，其他全 0），维度爆炸，而且不能在空间中体现出语意关系。

但是可以从这个空间出发，进行映射操作，
