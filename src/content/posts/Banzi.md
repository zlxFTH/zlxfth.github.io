---
title: Banzi
published: 2018-02-06
description: '没整理好。'
image: ''
tags: []
category: 'Misc'
draft: false 
lang: ''
---

## Misc

+ 缺省源

```cpp
#include <bits/stdc++.h>
using namespace std;

#define ALL(s) s.begin(), s.end()
#define SZ(s) int(s.size())
#define pb push_back

using LL = long long;
using ULL = unsigned long long;

void Cas() {
    
}

int main() {
    cin.tie(0)->sync_with_stdio(0);
    int t = 1;
    cin >> t;
    while (t--) {
        Cas();
    }
    return 0;
}
```

+ Test

```sh
#!/bin/bash
shopt -s nullglob # 没有匹配到任何文件时，让它返回空
ulimit -s 1024000
g++ $1.cpp -o $1 -std=c++20 -O2 -fsanitize=address,undefined || exit
for f in "$2"/*.in; do
    x=${f%.in}
    \time -f "$x: %es %MKB" ./$1 < $x.in > $1.out
    diff -Zq $1.out $x.ans
done
```

+ 随机数

```cpp
ULL seed = chrono::steady_clock::now().time_since_epoch().count();
mt19937_64 rnd(seed);
```

+ 保留小数

```cpp
cout << fixed << setprecision(2);
cout.unsetf(ios::fixed);
```

+ Matrix

```cpp
template <class T> struct Mat {
    int n, m;
    vector<T> a;
    Mat(int n = 0, int m = 0, T v = {}) : n(n), m(m), a(n * m, v) {}
    T& operator()(int i, int j) { return a[i * m + j]; }
};

using M = Mat<LL>;
M mul(M a, M b) {
    M c(a.n, b.m);
    for (int i = 0; i < a.n; i++) {
        for (int j = 0; j < b.m; j++) {
            for (int k = 0; k < a.m; k++) {
                c(i, j) = max(c(i, j), a(i, k) + b(k, j));
            }
        }
    }
    return c;
}
```

## Graph

+ Dijkstra

```cpp
struct Node {
    int u;
    LL d;
    bool operator<(const Node& o) const {
        return d > o.d;
    }
};
priority_queue<Node> q;
vector<LL> D(n, INF);
D[0] = 0;
q.push({0, 0});
while (SZ(q)) {
    auto [u, d] = q.top();
    q.pop();
    if (d != D[u]) continue;
    for (auto [v, w] : G[u]) {
        if (D[v] > d + w) {
            D[v] = d + w;
            q.push({v, D[v]});
        }
    }
}
```

+ 



## Data Structure

## String

## Math





> Barrett

适用于 int 范围内的模数，已经特判了 $P = 1$ 的情况，不用做其它任何处理。

```cpp
struct Mod {
    ULL m, p;
    void init(ULL _p) { p = _p; m = (I(1) << 64) / p; }
    ULL operator()(ULL x) {
        return p == 1 ? 0 : x - (I(x) * m >> 64) * p;
    }
} mod;
```

> 多固定模数

使用 `template<int P>` 即可，模数会在编译期优化。

> 不定模数

内置 Barrett。

注意访问 static 要用 `::`。

```cpp
template <class T> T qp(T a, LL b) {
    T c = 1;
    for (; b; b >>= 1, a *= a) if (b & 1) c *= a;
    return c;
}
template <class M>
struct Z {
    static LL mod(ULL x) {
        LL tmp = M::p == 1 ? 0 : x - (I(x) * M::m >> 64) * M::p;
        if (tmp >= M::p) tmp -= M::p;
        return tmp;
    }
    LL v;
    Z(LL x = 0) : v(x >= 0 ? mod(x) : M::p - mod(-x)) {}
    Z operator-() const { return -v; }
    Z &operator+=(Z b) { return v = mod(v + b.v), *this; }
    Z &operator-=(Z b) { return v = mod(v + M::p - b.v), *this; }
    Z &operator*=(Z b) { return v = mod(v * b.v), *this; }
    Z &operator/=(Z b) { return *this *= qp(b, M::p - 2); }
    friend Z operator+(Z a, Z b) { return a += b; }
    friend Z operator-(Z a, Z b) { return a -= b; }
    friend Z operator*(Z a, Z b) { return a *= b; }
    friend Z operator/(Z a, Z b) { return a /= b; }
    friend ostream &operator<<(ostream &os, Z a) { return os << a.v; }
};
struct Z1 {
    inline static ULL p = 0, m = 0;
    static void init(ULL _p) {
        p = _p;
        m = (I(1) << 64) / p;
    }
};
using Mint = Z<Z1>;
```

## bit

```cpp
template <class T>
struct BIT {
    int n;
    vector<T> a;
    BIT(int n = 0) : n(n), a(n + 1) {}
    void mdf(int p, T v) {
        for (int i = p + 1; i <= n; i += i & -i) a[i] += v;
    }
    T qry(int p) {
        T r{};
        for (int i = p; i > 0; i -= i & -i) r += a[i];
        return r;
    }
    T sum(int l, int r) { return qry(r) - qry(l); }
};
```



## geo

```cpp
using ld = double;
using point = complex<ld>;

const ld eps = 1e-8;

ld dot(point a, point b) {return (conj(a) * b).real();}
ld cross(point a, point b) {return (conj(a) * b).imag();}
ld dist(point a, point b) {return abs(a - b);}

bool on_line(point p, point a, point b) {
    return abs(cross(p - a, p - b)) <= eps;
}
bool on_seg(point p, point a, point b) {
    return on_line(p, a, b) && dot(p - a, p - b) <= eps;
}
pair<int, point> inter(point a, point b, point c, point d) {
    point u = b - a, v = d - c, w = a - c;
    if (abs(cross(u, v)) <= eps) return {0, {}};
    return {1, a + u * (cross(v, w) / cross(u, v))};
}
pair<int, point> inter_seg(point a, point b, point c, point d) {
    auto [op, o] = inter(a, b, c, d);
    return {op && on_seg(o, a, b) && on_seg(o, c, d), o};
}
```

## run

## pai

