---
title: GPU + Cuda + 
published: 2026-10-20
description: ''
image: ''
tags: []
category: 'AI Infra'
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

## SM

Streaming Multiprocessor（流式多处理器），是 GPU 内部集成调度、计算和片上存储资源的硬件模块。

SM 是 GPU 的模块化设计，设计一块 GPU 时复用 SM 的设计，提高 SM 数量，可以直接提高算力。

## Warp

Warp（线程束），硬件意义上的划分最小单位，按照 `threadIdx` $32$ 个连续 Thread 一组自动划分，Thread 来自同一个 Block，所以一个 Block 的最后一个 Warp 可能会有 lane 不参与执行。

为什么要设计 Warp？干一样的活，均摊发射指令的时间成本。

### Warp Scheduler

一个 Warp Scheduler 每个 cycle 会选择一个已经就绪的 Warp 选择一个发射执行指令。现代架构一个 SM 通常有多个 WS（通常 4 个），这种设计可以避免在一个 Warp 上面等待，也可以同时启动多个已就绪 Warp。

WS 在 Warp 间切换是零开销的（zero-overhead context switch），是说切换不需要像 CPU 那样保存/恢复。

```
Warp A 发射内存读取指令 → 等待数据返回（~400 cycles）
Warp Scheduler 切换到 Warp B → 执行计算指令
切换到 Warp C → 执行计算指令
...
Warp A 数据就绪 → 重新调度执行
```

## SIMT & SIMD

Single Instruction, Multiple Threads

Single Instruction, Multiple Data

