---
title: 2024 ICPC EC Nanjing Regional
published: 2025-11-06
description: '🦘'
image: ''
tags: [ICPC]
category: 'CP'
draft: true 
lang: ''
---

## A. Hey, Have You Seen My Kangaroo?

$n\times m$ 带障碍矩阵，每个空位有个袋鼠，每次操作整体移动袋鼠，长度为 $k$ 的循环操作队列给定，问最多只有 $i$ 个格子有袋鼠的最小时间。($n\times m\le 2\times 10^5, k\le 200$)

两个袋鼠一旦走到一起之后就一定在一起了。

考虑每一轮之后的位置，连边是个内向基环树，也就是说通过这棵基环树可以知道每个袋鼠是在哪一轮和别人发生合并的。

枚举每一轮，把会在这一轮发生合并的袋鼠全部拿出来模拟，这样就是 $O(nmk)$ 的。

## B. Birthday Gift

012 序列，将 2 改成 0/1，每次删相邻两个 0/1，求最短序列长度。($n\le 5\times 10^5$)

翻转奇数位就变成删相邻 01 或 10，考虑成 +1/-1，答案是 sum 的绝对值。

## C. Topology

外向树，编号比子节点编号小，对每个 $i$ 求出拓扑序 $p_i = i$ 的方案数。($n\le 5000$)

## D. 
