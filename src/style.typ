
// 页面基础设置
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

// 书法字体设计，仅能传入一个字母
// https://sitandr.github.io/typst-examples-book/book/snippets/math/calligraphic.html
#let scr(it) = math.class(
  "normal",
  box({
    show math.equation: set text(stylistic-set: 1)
    $cal(it)$
  }),
)

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

#let amazed(term, color: blue) = {
  text(color, box[✨ #term ✨])
}

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
// 在表格后添加目录
#show outline: set heading(numbering: none)
#show outline: set par(first-line-indent: 0em)
// 一级标题加粗
#show outline.entry.where(level: 1): it => {
  text(font: ("Times New Roman", "SimSun"))[#strong[#it]]
}
// 其余标题不变
#show outline.entry: it => {
  h(1em)
  text(font: ("Times New Roman", "SimSun"))[#it]
}
// 设置目录行的间距
#set par(leading: 9pt)

// 本行设置仅会影响目录中序号的间距，而不影响正文中的序号间距
#set heading(numbering: "1.1.1   ")
#show heading: it => box(width: 100%)[
  #set text(font: "Times New Roman")
  #set par(first-line-indent: 0em) // 取消标题首行缩进
  #if it.numbering != none {
    counter(heading).display("1.1.1")
  }
  #h(0.75em)
  #it.body
]

// 超链接设置颜色和下划线
#show link: {
  underline.with(stroke: rgb("#0074d9"), offset: 2pt)
}
#show link: set text(blue)

#import "@preview/frame-it:1.0.0": *

// You have to define the kinds of frames you need
#let (theorem, lemma, definition, important) = make-frames(
  // This identifies the counter used for all theorems in this definition
  "counter-id",
  theorem: ("Theorem",),
  // You can provide a color or leave it out and it will be generated
  lemma: ("Lemma", gray),
  // For each frame kind, you have to provide its supplement title to be displayed
  definition: ("Definition",),
  // You can add as many as you want
  important: ("Important", blue.lighten(25%)),
)

// TableX / TableM
#import "@preview/tablex:0.0.6": tablex, hlinex
#import "@preview/tablem:0.1.0": tablem

// 分割线
#let CrossLine = [
  \ \
  #h(1fr)
  $
    #line(
  start:(0em,-.15em),
  end:(12em,-.15em),
  stroke: (
    cap: "round",
    paint:gradient.linear(white,black,white)
  )
  )
  #move(dx:.5em,dy:0em,"🙠")
    #text(15pt)[🙣]
    #h(0.4em)
    #move(dy:-0.25em,text(12pt)[✢])
    #h(0.4em)
    #text(15pt)[🙡]
    #move(dx:-.5em,dy:0em,"🙢")
    #line(
      start:(0em,-.15em),
      end:(12em,-.15em),
      stroke: (
        cap: "round",
        paint:gradient.linear(white,black,white)
      )
    )
  $
  #h(1fr)
  \ \
];

// 导言区结束，正文开始 ——————————————————————
