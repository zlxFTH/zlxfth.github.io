---
title: Transformer Infra Lab 实现记录
published: 2026-10-21
description: ''
image: ''
tags: []
category: ''
draft: false 
lang: ''
---

## CS336 Assignment 1

文件树

```
- cs336-a1
	- cs336_basics
		- train_bpe.py        # 从原始文本学出词表合并规则
  - tests
  	- adapters.py         # 自己写的代码和官方测试的接口
```



测试

```sh
cd cs336-a1 && uv run pytest tests/test_train_bpe.py -q
```

train_bpe

## 杂项 Takeaway

基础太差了，顺路记录一些学到的杂项东西。

### 01

目录下面放个 `__init__.py`，这个目录就可以当成 python 里面的包用，目录下的 `.py` 就是这个包的子模块。

例如这个仓库就可以直接

```py
from cs336_basics.train_bpe import train_bpe
```

