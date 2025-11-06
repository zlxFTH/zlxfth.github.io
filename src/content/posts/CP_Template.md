---
title: CP Template
published: 2025-11-05
description: 'ICPC 武汉吃了没有类欧板子的亏。'
image: ''
tags: [Template]
category: 'CP'
draft: true
lang: ''
---

## 数论

### 扩欧几里得 | Extended Euclidean Algorithm

### 类欧几里得 | Generalized Euclidean Algorithm

$O(\log \min\{V, n\})$ 计算：
$$
f(a, b, c, n) = \sum_{i = 0}^n\lfloor\frac{ai + b}{c}\rfloor
$$
首先 $a, b$ 对 $c$ 取模，加上贡献。
$$
m = \left\lfloor \frac{an+b}{c} \right\rfloor
$$

$$
\sum_{i=0}^n\left\lfloor \frac{ai+b}{c} \right\rfloor
=\sum_{i=0}^n\sum_{j=0}^{m-1}\left[j<\left\lfloor \frac{ai+b}{c} \right\rfloor\right].
$$

$$
\begin{aligned}
&j<\left\lfloor \frac{ai+b}{c} \right\rfloor = \left\lceil \frac{ai+b+1}{c} \right\rceil-1\\
&\iff j + 1 < \left\lceil \frac{ai+b+1}{c} \right\rceil
\iff j+1< \frac{ai+b+1}{c} \\
&\iff \dfrac{cj+c-b-1}{a} < i
\iff \left\lfloor\dfrac{cj+c-b-1}{a}\right\rfloor < i.
\end{aligned}
$$

$$
\begin{aligned}
f(a,b,c,n)&=\sum_{j=0}^{m-1}
\sum_{i=0}^n\left[i>\left\lfloor\frac{cj+c-b-1}{a}\right\rfloor \right]\\
&=\sum_{j=0}^{m-1}\left(n-\left\lfloor\frac{cj+c-b-1}{a}\right\rfloor\right)\\
&=nm-f\left(c,c-b-1,a,m-1\right).
\end{aligned}
$$

中途特判 $m = 0$ 复杂度和 $n$ 取 $\min$。

```cpp

```

进阶版：
$$
f(a, b, c, n, k_1, k_2) = \sum_{i = 0}^{n} i ^ {k_1} {\left \lfloor \frac{ai + b}{c} \right \rfloor} ^ {k_2}
$$

```cpp

```

### 万欧几里得 | Universal Euclidean Algorithm
