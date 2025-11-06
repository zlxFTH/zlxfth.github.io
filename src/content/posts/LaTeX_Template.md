---
title: LaTeX Template
published: 2025-02-10
description: '每次新开一个作业都会摸半天，我是效率低下的狗。'
image: ''
tags: ['Template']
category: 'THU'
draft: false 
lang: ''
---

## Assignment

```latex
\documentclass[12 pt]{article}
\usepackage{amsfonts, amssymb, amsmath, graphicx, physics, algpseudocode, fontspec}
\setmainfont{PingFang SC}
\usepackage{xeCJK}        % 中文支持
\setCJKmainfont{PingFang SC}

\oddsidemargin=-0.5cm                 	
\setlength{\textwidth}{6.5in}         	
\addtolength{\voffset}{-20pt}        		
\addtolength{\headsep}{25pt}           	
\setlength{\parindent}{0pt}

\usepackage[ruled,vlined,linesnumbered]{algorithm2e}
\DontPrintSemicolon

\pagestyle{myheadings}                           
\markright{Lixi Zhang\hfill Homework 3\hfill Algorithm Design \hfill}

\newcommand{\eqn}[0]{\begin{array}{rcl}}
\newcommand{\eqnend}[0]{\end{array} }

\newcommand{\qed}[0]{$\square$}

% 插入一个图片
% \includegraphics[width=\linewidth]{1.jpeg}

\begin{document}

\end{document}
```

