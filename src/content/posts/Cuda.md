---
title: Cuda
published: 2026-10-20
description: ''
image: ''
tags: []
category: ''
draft: false 
lang: ''
---

## 环境

9600x + 32GB + 5060 8GB

![](./Cuda/Environment-1.png)

![](./Cuda/Environment-2.png)

## 

cuda

nvcc



Grid（网格） -> Block（线程块） -> Thread（线程）

Thread 是一个干活的人，Block 是一个干活小组，组内可以协作（？），Grid 是整个团队

`__global__`

`__device__`

```
gridDim.x: 
blockDim.x: 
```