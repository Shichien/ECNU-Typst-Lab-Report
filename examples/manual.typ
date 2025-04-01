#import "../src/colorbox.typ": *
#import "../src/preamble.typ": *
#show: template.with(header: "华东师范大学软件工程学院实验报告", author: "张梓卫")

#v(30pt) <front-matter>

#align(
  center,
  text(17pt)[
    华东师范大学软件工程学院实验报告
  ],
)

#v(17pt)

#table(
  columns: (1fr,) + 3 * (auto,),
  rows: 3,
  align: left + horizon,
  stroke: (x, y) => {
    (top: if y == 0 { 0.45pt + black })
    (bottom: if y == 3 { 0.45pt + black })
  },
  [课程名称：], [年级：], [#h(2.1cm)], [上机实践成绩：],
  [指导教师：], [姓名：], [], [],
  [上机实践名称：], [学号：3141592653], [], [上机实践日期：2025/03/11],
  [上机实践编号：（1）], [组号：], [], [上机实践时间：2学时],
)

#outline(
  title: [#h(-1em)目录],
  indent: 2em,
  depth: 2,
)

// 正文部分 --------------------------------------

= 实验目的

本实验的目标是使得用户能够使用 `Typst` 来编写实验报告。

= 内容与设计思想

== 使用分栏模块

#columns(2)[
  === 使用引用

  在尾部添加 \<Head> 标签后，在任意位置即可使用 \@ 符号引用。

  === 添加参考文献

  使用 Cite 来引用参考文献.

  === 添加超链接

  #link("https://github.com")[https://github.com]

  === 样式语法糖

  将内容块作为参数传递（这是语法糖，实际上还是会被转化为参数传递）

  #colbreak()

  === 添加数学公式

  行内公式 $"Message" = rho_水 g h$，不要加空格，长文本用引号括起来。

  行间公式在两边加上空格：

  $ f(x) = sum_(i=0)^x, f(x) = sum_{i=0}^{x-epsilon} (Q_i - lambda) / 2 $

  $ vec := vec(a_1, a_2, a_3) $

  $ a arrow.stroked b, a arrow.squiggly b $
]

#pagebreak()

=== 添加图片

#align(center, image("../icons/header.jpg", width: 30%))

#figure(
  image("../icons/header.jpg", width: 30%),
  caption: [这是一张图片],
)

=== 添加代码块

使用 Markdown 语法即可撰写漂亮的代码块：

```rust
fn main() {
    println!("Hello, world!");
}
```

== 分割线

- The Art of Typst By Deralive.
  + Windows 11 24H2.
  + Linux Ubuntu 22.04.
- 使用 `-` 来构建无序列表

// #CrossLine

== 多种短块样式

This is #highlight(fill: i_blue.C)[highlighted in blue]. This is #highlight(fill: i_yellow.C)[highlighted in yellow]. This is #highlight(fill: i_green.C)[highlighted in green]. This is #highlight(fill: i_red.C)[highlighted in red].

This is #amazed("Stars For You", color: purple).

#brainstorming[
  This is a brainstorming.
]

#question[
  This is a question.
]

#task[
  This is a task.
]

#definition[
  #h(2em) 若需要首行缩进，在前面添加 `#h(2em)` 即可。

  素数是一个数，它大于 1，且只能被 1 和它本身整除。
]

#let solution = rect.with(fill: luma(240), stroke: (left: 0.25em))

#solution[
  *Solution:* "Maxwell Equation Set"
  $ a_(n+1)x^n = 2... $
]

== Color Box

实验结果已封装为多个 Colorbox 样式，开箱即用。

#bluebox(title: "麦克斯韦方程组", footer: "这是麦克斯韦方程")[
  麦克斯韦方程组是描述电磁场的四个基本方程。
  $
    integral.cont_(diff S) arrow(B) dot.op d arrow(l) = mu_0 (integral_S arrow(J) dot.op d arrow(A) + d / (d t) integral_S arrow(E) dot.op d arrow(A))
  $
  其中，$(integral.cont_(diff S) arrow(B) dot.op d arrow(l))$ 是沿闭合曲线的磁场线积分。
]

#greenbox(title: "麦克斯韦方程组", footer: "Maxwell")[
  麦克斯韦方程组是描述电磁场的四个基本方程。
  $
    integral.cont_(diff S) arrow(B) dot.op d arrow(l) = mu_0 (integral_S arrow(J) dot.op d arrow(A) + d / (d t) integral_S arrow(E) dot.op d arrow(A))
  $
  其中，$(integral.cont_(diff S) arrow(B) dot.op d arrow(l))$ 是沿闭合曲线的磁场线积分。
]

#redbox(title: "麦克斯韦方程组", footer: "Maxwell")[
  麦克斯韦方程组是描述电磁场的四个基本方程。
  $
    integral.cont_(diff S) arrow(B) dot.op d arrow(l) = mu_0 (integral_S arrow(J) dot.op d arrow(A) + d / (d t) integral_S arrow(E) dot.op d arrow(A))
  $
  其中，$(integral.cont_(diff S) arrow(B) dot.op d arrow(l))$ 是沿闭合曲线的磁场线积分。
]

#h_redbox(title: "此 Box 不含脚注")[Warning]

#redwhitebox(title: "麦克斯韦方程组", footer: "Maxwell")[
  麦克斯韦方程组是描述电磁场的四个基本方程。
  $
    integral.cont_(diff S) arrow(B) dot.op d arrow(l) = mu_0 (integral_S arrow(J) dot.op d arrow(A) + d / (d t) integral_S arrow(E) dot.op d arrow(A))
  $
]

#lightredbox(title: "This is Maxwell Equation Set", footer: "This is a sample footer for red box")[
  麦克斯韦方程组是描述电磁场的四个基本方程。
  $
    integral.cont_(diff S) arrow(B) dot.op d arrow(l) = mu_0 (integral_S arrow(J) dot.op d arrow(A) + d / (d t) integral_S arrow(E) dot.op d arrow(A))
  $
]

#blackbox(
  title: "Divergence theorem",
  footer: "In the case of $n=3$, $V$ represents a volume in three-dimensional space, and $diff V = S$ its surface",
)[
  麦克斯韦方程组是描述电磁场的四个基本方程。
  $
    integral.cont_(diff S) arrow(B) dot.op d arrow(l) = mu_0 (integral_S arrow(J) dot.op d arrow(A) + d / (d t) integral_S arrow(E) dot.op d arrow(A))
  $
]

#dotblackbox(title: "Maxwell's Equations", footer: "This is a sample footer.")[
  麦克斯韦方程组是描述电磁场的四个基本方程。
  $
    integral.cont_(diff S) arrow(B) dot.op d arrow(l) = mu_0 (integral_S arrow(J) dot.op d arrow(A) + d / (d t) integral_S arrow(E) dot.op d arrow(A))
  $
]

#stickybox(
  rotation: 0deg, // 倾斜角
  width: 18cm,
)[
  麦克斯韦方程组是描述电磁场的四个基本方程。
  $
    integral.cont_(diff S) arrow(B) dot.op d arrow(l) = mu_0 (integral_S arrow(J) dot.op d arrow(A) + d / (d t) integral_S arrow(E) dot.op d arrow(A))
  $
  其中，$(integral.cont_(diff S) arrow(B) dot.op d arrow(l))$ 是沿闭合曲线的磁场线积分。
]

#lemma[引理][麦克斯韦方程组][More args..][
  麦克斯韦方程组是描述电磁场的四个基本方程。
  $
    integral.cont_(diff S) arrow(B) dot.op d arrow(l) = mu_0 (integral_S arrow(J) dot.op d arrow(A) + d / (d t) integral_S arrow(E) dot.op d arrow(A))
  $
  其中，$(integral.cont_(diff S) arrow(B) dot.op d arrow(l))$ 是沿闭合曲线的磁场线积分。
]

#important(style: styles.hint)[麦克斯韦方程组][Maxwell][
  麦克斯韦方程组是描述电磁场的四个基本方程。
  $
    integral.cont_(diff S) arrow(B) dot.op d arrow(l) = mu_0 (integral_S arrow(J) dot.op d arrow(A) + d / (d t) integral_S arrow(E) dot.op d arrow(A))
  $
  其中，$(integral.cont_(diff S) arrow(B) dot.op d arrow(l))$ 是沿闭合曲线的磁场线积分。
]

#theorem[定理][麦克斯韦方程组][Maxwell][
  麦克斯韦方程组是描述电磁场的四个基本方程。
  $
    integral.cont_(diff S) arrow(B) dot.op d arrow(l) = mu_0 (integral_S arrow(J) dot.op d arrow(A) + d / (d t) integral_S arrow(E) dot.op d arrow(A))
  $
  其中，$(integral.cont_(diff S) arrow(B) dot.op d arrow(l))$ 是沿闭合曲线的磁场线积分。
]

#showybox(
  title: "父级容器",
  frame: (
    border-color: blue.darken(30%),
    title-color: blue.darken(30%),
    body-color: blue.lighten(80%),
  ),
  "父级容器第一个子模块",
  columns(2)[
    #showybox(
      title-style: (boxed-style: (:)),
      title: "子 Showybox I",
    )[这里是第一个 Showybox.]
    #colbreak()
    #showybox(
      title-style: (boxed-style: (:)),
      title: "子 Showybox II",
    )[这里是第二个 Showybox.]
  ],
)[可以传入脚注][继续传入脚注]
