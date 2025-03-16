
#import "colorbox.typ": *
#import "@preview/mitex:0.2.5": *
#import "@preview/subpar:0.2.1" // 子图包
#import "@preview/numbly:0.1.0": numbly

// ———————————————————————————————————————————————
// 页面全局设置
#set page(fill: white)
// 解决源代码跳转的问题
// "这个修复和这个 BUG 一样让人无法理解"
// 来自 @OrangeX4 的解决方案

#set page(
  margin: (
    left: 15mm,
    right: 15mm,
    top: 15mm,
    bottom: 20mm,
  ),
  header: [#align(center)[华东师范大学软件工程学院实验报告] #v(-0.2cm)] + line(length: 100%),
  footer: line(length: 100%)
    + context {
      if counter(page).at(here()).first() == 0 { return }
      let page-number = counter(page).at(here()).first()
      [
        #if calc.odd(page-number) {
          align(left)[ #h(-2em) _In Typst By_ #link("github.com/Shichien", $scr(D)scr(e)scr(r)scr(a)scr(l)scr(i)scr(v)scr(e)$)]
          v(-2em)
          align(right)[#counter(page).display("第 1 页，共 1 页", both: true)] // 奇数页靠右
        } else {
          align(left)[ #h(-2em) #counter(page).display("第 1 页，共 1 页", both: true)] // 偶数页靠左
          v(-2em)
          align(right)[_In Typst By_ #link("github.com/Shichien", $scr(D)scr(e)scr(r)scr(a)scr(l)scr(i)scr(v)scr(e)$)]
        }
      ]
    },
)

// ———————————————————————————————————————————————
// 段落设置
#set par(
  first-line-indent: (amount: 2em, all: true), // 全部首行缩进
  // first-line-indent: 2em,
  leading: 1em, // 行间距
  spacing: 1.2em, // 段间距
  hanging-indent: 0em, //除首行外的缩进
)

#set list(
  tight: true, // 使用段落缩进
  marker: ([•], [--], [>]),
  indent: 1em,
  body-indent: 0.8em,
)

#set enum(
  tight: true, // 使用段落缩进
  numbering: "1.1.",
  indent: 1em,
  body-indent: 0.5em,
  full: true,
)

// Fixed (Typst 0.13 # Par(indent: (amount: 2em, all: true))))
// 解决某些环境后首行缩进不显示的问题
// // https://stormckey.github.io/PeiPei/typst
// 使用 fakepar 方案将图表、列表等环境后的首行缩进问题解决
// #let fakepar = context {
//   let b = par(box())
//   b
//   v(-measure(b + b).height)
// }

// #show math.equation.where(block: true): it => it + fakepar
// #show figure: it => it + fakepar // 图表后缩进
// #show enum.item: it => it + fakepar
// #show list.item: it => it + fakepar // 列表后缩进

// 处理二级标题与上一段的间距
// #show heading.where(level: 2): it => {
//   v(0.5em)
//   it
// }

// ———————————————————————————————————————————————
// 字体设置 - 增加粗体显示
// https://csimide.github.io/cuti-docs/zh-CN/fakebold.html
#import "@preview/cuti:0.3.0": show-cn-fakebold
#show: show-cn-fakebold
// 中英文使用不同的字体
// Typst: 0.13.0 改进：https://typst-doc-cn.github.io/guide/FAQ/lang-fonts.html
#set text(
  size: 10pt,
  font: (
    (name: "Times New Roman"),
    "SimSun",
  ),
  lang: "zh",
  region: "cn",
)

// ———————————————————————————————————————————————
// 标题设置
// 标题标号与标题内容之间使用 0.75em 间距
#show heading: it => box(width: 100%)[
  #set text(font: "Times New Roman")
  #if it.numbering != none {
    counter(heading).display("1.1.1")
  }
  #h(0.75em) #it.body
]

// ———————————————————————————————————————————————
// 代码块设置
// https://typst.app/universe/package/codly-languages
#import "@preview/codly:1.2.0": * // 代码高亮包
#import "@preview/codly-languages:0.1.6": *
#show: codly-init
#codly(languages: codly-languages) //设置语言图标

// ———————————————————————————————————————————————
// 数学公式部分
// 重置每个章节的公式计数器
#show heading.where(level: 1): it => {
  counter(math.equation).update(0)
  it
}

// 让数学公式的显示以 (1.1) 来表现
#set math.equation(
  numbering: n => {
    numbering("(1.1)", counter(heading).get().first(), n)
  },
)

// ———————————————————————————————————————————————
// 目录设置，设置目录不标号
#show outline: set heading(numbering: none)

// 一级目录加粗，二级目录加入 1em indent
#show outline.entry.where(level: 1): it => {
  set block(above: 1.35em)
  text(font: ("Times New Roman", "SimSun"))[#strong[#it]]
}
#show outline.entry.where(level: 2): it => {
  set block(above: 1em)
  it
}

// 本行设置仅会影响目录中序号的间距，而不影响正文中的序号间距
#set heading(numbering: "1.1.1   ")

// ———————————————————————————————————————————————
// 超链接设置颜色和下划线
#show link: {
  underline.with(stroke: rgb("#0074d9"), offset: 2pt)
}
#show link: set text(blue)

// ———————————————————————————————————————————————
// 图标设置
#let icon(path) = box(
  baseline: 0.125em,
  height: 0.8em,
  width: 1.0em,
  align(center + horizon, image(path)),
)

#let faGithub = icon("../icons/fa-github.svg")
#let faLinux = icon("../icons/fa-linux.svg")
#let faWindows = icon("../icons/fa-windows.svg")

// 使用 Show 规则对指定的内容进行修改分析
#show "Deralive": name => box[
  #box(
    image(
      "../icons/Head.jpg",
      height: 0.8em,
    ),
  ) #name
]

#show "Github": githubUrl => box[
  #box(faGithub) #githubUrl
]

#show "Linux": name => box[
  #box(faLinux) #name
]

#show "Windows": name => box[
  #box(faWindows) #name
]

// 导言区结束，正文开始 ——————————————————————

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

  使用 Cite 来引用参考文献 @taylor2022ai @brown2018data.

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

#align(center, image("../icons/image.png", width: 30%))

#figure(
  image("../icons/image.png", width: 30%),
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

== 多种短块样式

#bibliography("../ref.bib")
