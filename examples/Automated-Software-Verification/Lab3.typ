#import "../../src/colorbox.typ": *
#import "../../src/preamble.typ": *
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
    (bottom: if y == 2 { 0.45pt + black })
  },
  [课程名称：自动化软件验证基础], [年级：大二], [#h(2.5cm)], [],
  [指导教师：李建文], [姓名：张梓卫], [], [],
  [报告主题：子集构造 #h(0.1em) —— NFA 确定化], [学号：10235101526], [], [实践日期：2025/04/01],
)

// 正文部分 --------------------------------------

= 将 @figure 中的 NFA 确定化

#columns(2)[
  #figure(image("images/Lab3/img-20250401185505.png", height: 17em), caption: "未确定化的 NFA") <figure>

  #colbreak()

  按照 NFA 的状态转换图，可得 DFA 状态转换矩阵。

  #show table.cell: it => {
    if it.y == 0 {
      strong(it)
    } else {
      it
    }
  }

  #align(center)[
    #figure(
      table(
        columns: 3,
        stroke: none,
        // align: (x, y) => if y == 0 { center } else if x == 0 { left } else { left },
        table.hline(),
        table.header([*$I$*], [*$I_0$*], [*$I_1$*]),
        table.hline(stroke: 0.5pt),
        [$S$], [${V,Q}$], [{Q,U}],
        [${V,Q}$], [${Z,V}$], [${Q,U}$],
        [${Q,U}$], [${V}$], [${Q,U,Z}$],
        [${Z,V}$], [${Z}$], [${Z}$],
        [${V}$], [${Z}$], [$emptyset$],
        [${Q,U,Z}$], [${V,Z}$], [${Q,U,Z}$],
        [${Z}$], [{Z}], [{Z}],
        table.hline(),
      ),
      caption: "状态转换矩阵",
    ) <table>
  ]
]

由 @table 中的 NFA 状态转换矩阵可画出 DFA 的状态转换图。
我们将 $I$ 中出现的所有状态，即：$ {S,{V,Q},{Q,U},{Z,V},{V},{Q,U,Z},{Z}} $

分别列为字母： $ {A,B,C,D,E,F,G} $

故画出的 NFA 确定化后的状态转换图，如下所示（使用 LateX 中 Tikz 宏包绘制，导出为 SVG 后传入 Typst 中）

#figure(image("images/Lab3/img-20250401185547.png", height: 18em), caption: "确定化的 DFA") <figure2>


由于 Z 是终态结点，所以在 @figure2 中含有 Z 的所有 I 集合都要用双圈来表示。

