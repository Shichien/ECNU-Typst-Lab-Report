#import "colorbox.typ": *
#import "@preview/subpar:0.2.1" // 子图包
#import "@preview/tablex:0.0.6": tablex, hlinex
#import "@preview/tablem:0.1.0": tablem

// 页面全局设置
#set page(
  margin: (
    left: 15mm,
    right: 15mm,
    top: 15mm,
    bottom: 20mm,
  ),
)

// 字体设置 - 增加粗体显示
// https://csimide.github.io/cuti-docs/zh-CN/fakebold.html
#import "@preview/cuti:0.3.0": show-cn-fakebold
#show: show-cn-fakebold
#set text(
  size: 10pt,
  font: ("Times New Roman", "SimSun"),
  lang: "zh",
  region: "cn",
)

// 首行缩进
#show heading: it => box(width: 100%)[
  #set text(font: "Times New Roman")
  #set par(first-line-indent: 0em) // 取消标题首行缩进
  #if it.numbering != none {
    counter(heading).display("1.1.1")
  }
  #h(0.75em)
  #it.body
]

#set par(first-line-indent: 2em)
#let fakepar = context {
  let b = par(box())
  b
  v(-measure(b + b).height)
}

// 解决首行缩进所带来的代码块问题
// https://stormckey.github.io/PeiPei/typst
#show math.equation.where(block: true): it => it + fakepar
#show heading: it => it + fakepar // 标题后缩进
#show figure: it => it + fakepar // 图表后缩进
#show enum.item: it => it + fakepar
#show list.item: it => it + fakepar // 列表后缩进

// 页眉页脚设置
#import "@preview/chic-hdr:0.4.0": *
#show: chic.with(
  chic-header(center-side: smallcaps("华东师范大学软件工程学院实验报告")),
  chic-footer(
    left-side: strong("In Typst By " + link("github.com/Shichien", $scr(D)scr(e)scr(r)scr(a)scr(l)scr(i)scr(v)scr(e)$)),
    right-side: "第" + chic-page-number() + "页，共" + context [#counter(page).final().at(0)] + "页",
  ),
  // 获取总页数：https://github.com/typst/typst/discussions/2720
  chic-separator(on: "header", chic-styled-separator("bold-center")),
  chic-separator(on: "footer", chic-styled-separator("flower-end")),
  chic-offset(10pt),
)

// 代码块设置
// https://typst.app/universe/package/codly-languages
#import "@preview/codly:1.2.0": * // 代码高亮包
#import "@preview/codly-languages:0.1.6": *
#show: codly-init
#codly(languages: codly-languages) //设置语言图标

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
    // if you want change the number of number of displayed
    // section numbers, modify it this way:
    /*
    let count = counter(heading).get()
    let h1 = count.first()
    let h2 = count.at(1, default: 0)
    numbering("(1.1.1)", h1, h2, n)
    */
  },
)

// 目录设置
#show outline: set heading(numbering: none)
#show outline: set par(first-line-indent: 0em)
#show outline.entry.where(level: 1): it => {
  // 一级标题加粗
  text(font: ("Times New Roman", "SimSun"))[#strong[#it]]
}
#show outline.entry: it => {
  // 其余标题不变
  h(1em)
  text(font: ("Times New Roman", "SimSun"))[#it]
}
#set par(leading: 9pt) // 设置目录行的间距

// 本行设置仅会影响目录中序号的间距，而不影响正文中的序号间距
#set heading(numbering: "1.1.1   ")

// 超链接设置颜色和下划线
#show link: {
  underline.with(stroke: rgb("#0074d9"), offset: 2pt)
}
#show link: set text(blue)

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

#v(30pt)

#align(
  center,
  text(17pt)[
    华东师范大学软件工程学院实验报告
  ],
)

#v(17pt)

#table(
  columns: (1fr,) + 3 * (auto,),
  rows: 4,
  align: left + horizon,
  stroke: (x, y) => {
    (top: if y == 0 { 0.45pt + black })
    (bottom: if y == 2 { 0.45pt + black })
  },
  [课程名称：], [指导教师：], [], [],
  [姓名：], [学号：10235101], [], [实践编号：（）],
  [实践日期：2025/], [实践名称：], [#h(3.6cm)], [实践时间：2 学时],
)

// 不为目录编号
#heading(outlined: false, numbering: none, "目录")
#outline(title: none, indent: 2em, depth: 2)

// 正文部分 --------------------------------------

= 实验目的

本实验的目标是使得用户能够使用 `Typst` 来编写实验报告。

= 内容与设计思想

== 使用分栏模块

#columns(2)[
  === 使用引用

  在尾部添加 \<Head> 标签后，在任意位置即可使用 \@ 符号引用 @Head.

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

#figure(
  image("../icons/Head.jpg", width: 30%),
  caption: [
    使用标记文本（内容块）也可以为图片添加标题
  ],
) <Head>

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

#CrossLine

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

= 实验环境

#show table.cell.where(x: 0): set text(style: "italic") // 第一列表列斜体处理
#show table.cell.where(y: 0): set text(style: "normal", weight: "bold") // 第一行表头加粗处理

#align(right)[
  #table(
    columns: 2,
    stroke: (y: none), // 仅保留 Y 方向 描边
    align: horizon,
    [☒], [Close cabin door],
    [☐], [Start engines],
    table.hline(), // 在 X 轴方向添加一条描边
    [☐], [Radio tower],
    [☐], [Push back],
  )
]

#{
  set table(align: (x, _) => if x == 0 { left } else { right })
  show table.cell.where(x: 0): smallcaps
  table(
    columns: (auto, 1fr, 1fr, 1fr),
    // 1fr 可以提供满页的自动调整布局
    table.vline(x: 1, start: 1),
    table.header[Trainset][Top Speed][Length][Weight],
    [TGV Réseau], [320 km/h], [200m], [383t],
    [ICE 403], [330 km/h], [201m], [409t],
    [Shinkansen N700], [300 km/h], [405m], [700t],
  )
}

#align(center)[
  #set table(stroke: (_, y) => if y == 0 { (top: 1pt, bottom: 0.5pt) })
  #table(
    columns: 3,
    align: center + horizon,
    table.header[Technique][Advantage][Drawback],
    [Diegetic], [Immersive], [May be contrived],
    [Extradiegetic], [Breaks immersion], [Obtrusive],
    [Omitted], [Fosters engagement], [May fracture audience],
    table.hline(),
  )
]

#figure(
  caption: [Training regimen for Marathon],
  table(
    columns: 3,
    fill: (_, y) => if y == 0 { gray.lighten(75%) },
    table.header[Week][Distance (km)][Time (hh:mm:ss)],
    [1], [5], [00:30:00],
    [2], [7], [00:45:00],
    [3], [10], [01:00:00],
    [4], [12], [01:10:00],
    [5], [15], [01:25:00],
    [6], [18], [01:40:00],
    [7], [20], [01:50:00],
    [8], [22], [02:00:00],
    [...], [...], [...],
    table.footer[_Goal_][_42.195_][_02:45:00_],
  ),
)

#let ofi = [Office]
#let rem = [_Remote_]
#let lea = [*On leave*]

#table(
  columns: 6 * (1fr,),
  align: (x, y) => if x == 0 or y == 0 { left } else { center },
  stroke: (x, y) => (
    // Separate black cells with white strokes.
    left: if y == 0 and x > 0 { white } else { black },
    rest: black,
  ),
  fill: (_, y) => if y == 0 { black },

  table.header(
    [Team member],
    [Monday],
    [Tuesday],
    [Wednesday],
    [Thursday],
    [Friday],
  ),
  [Evelyn Archer],
  table.cell(colspan: 2, ofi),
  table.cell(colspan: 2, rem),
  ofi,
  [Lila Montgomery],
  table.cell(colspan: 5, lea),
  [Nolan Pearce],
  rem,
  table.cell(colspan: 2, ofi),
  rem,
  ofi,
)

#let rainbow_stroke = stroke(2pt + gradient.linear(..color.map.plasma))
#show table: it => block(stroke: rainbow_stroke, radius: 2em, clip: true, it)

#table(
  columns: (1fr,) * 5,
  rows: 3em,
  stroke: rainbow_stroke,
  align: (x, y) => {
    if (calc.odd(x + y)) {
      left + top
    } else {
      right + bottom
    }
  },
  [A], [B], [C], [D], [E],
  [F], [G], [H], [I], [J],
  [K], [L], [M], [N], [O],
  [P], [Q], [R], [S], [T],
  [U], [V], [W], [X], [Y],
  [Z],
)

= 实验过程与分析

#subpar.grid(
  figure(
    image("../assets/andromeda.jpg"),
    caption: [
      An image of the andromeda galaxy.
    ],
  ),
  <a>,
  figure(
    image("../assets/mountains.jpg"),
    caption: [
      A sunset illuminating the sky above a mountain range.
    ],
  ),
  <b>,
  columns: (1fr, 1fr),
  // columns: (1fr, 1fr),
  caption: [A figure composed of two sub figures.],
  label: <full>,
)

Above in @full, we see a figure which is composed of two other figures, namely @a and @b.

= 实验结果

= 附录

参考文献无需添加标题，直接使用 `#bibliography("ref.bib")` 即可引用。

== 项目架构

- chapters/
  - chapter_1.typ
  - chapter_2.typ
- main.typ 👁 #text(gray)[← document entry point]
- template.typ


#bibliography("../ref.bib")

