#import "colorbox.typ": *
#import "@preview/mitex:0.2.5": *
#import "@preview/subpar:0.2.1": *
#import "@preview/subpar:0.2.1": grid as subfigure
#import "@preview/numbly:0.1.0": numbly
#import "@preview/cuti:0.3.0": show-cn-fakebold
#import "@preview/codly:1.2.0": * // 代码高亮包
#import "@preview/codly-languages:0.1.6": *

// 解决 CJK 换行问题
#let han-or-punct = "[-\p{sc=Hani}。．，、：；！‼？⁇⸺——……⋯⋯～–—·・‧/／「」『』“”‘’（）《》〈〉【】〖〗〔〕［］｛｝＿﹏●•]"

#let icon(path) = box(
  baseline: 0.125em,
  height: 0.8em,
  width: 1.0em,
  align(center + horizon, image(path)),
)

#let faGithub = icon("../icons/fa-github.svg")
#let faLinux = icon("../icons/fa-linux.svg")
#let faWindows = icon("../icons/fa-windows.svg")

#let template(header: "", author: "", title: "", body) = {
  set document(author: author, title: title, date: auto)
  set par(
    first-line-indent: (amount: 2em, all: true), // 全部首行缩进
    leading: 1em, // 行间距
    spacing: 1.2em, // 段间距
    hanging-indent: 0em, // 除首行外的缩进
  )

  set list(
    tight: true, // 使用段落缩进
    marker: ([•], [--], [>]),
    indent: 1em,
    body-indent: 0.8em,
  )

  set enum(
    tight: true, // 使用段落缩进
    numbering: "1.1.",
    indent: 1em,
    body-indent: 0.5em,
    full: true,
  )

  set text(
    size: 10pt,
    font: ("Times New Roman", "SimSun"),
    lang: "zh",
    region: "cn",
  )

  // 本行设置仅会影响目录中序号的间距，而不影响正文中的序号间距
  set heading(numbering: "1.1.1   ")

  // 标题标号与标题内容之间使用 0.75em 间距
  show heading: it => box(width: 100%)[
    #set text(font: "Times New Roman")
    #if it.numbering != none {
      counter(heading).display("1.1.1")
    }
    #h(0.75em) #it.body
  ]

  // 重置每个章节的公式计数器
  show heading.where(level: 1): it => {
    counter(math.equation).update(0)
    it
  }

  // 让数学公式的显示以 (1.1) 来表现
  set math.equation(
    numbering: n => {
      numbering("(1.1)", counter(heading).get().first(), n)
    },
  )

  show outline: set heading(numbering: none)
  // 一级目录加粗，二级目录加入 1em indent
  show outline.entry.where(level: 1): it => {
    set block(above: 1.35em)
    text(font: ("Times New Roman", "SimSun"))[#strong[#it]]
  }
  show outline.entry.where(level: 2): it => {
    set block(above: 1em)
    it
  }

  // 字体设置 - 增加粗体显示
  // https://csimide.github.io/cuti-docs/zh-CN/fakebold.html
  show: show-cn-fakebold
  show regex(han-or-punct + " " + han-or-punct): it => {
    let (a, _, b) = it.text.clusters()
    a + b
  }

  show: codly-init
  codly(languages: codly-languages) // 设置语言图标
  show raw: it => {
    set text(font: ("JetBrainsMono NF", "SimSun"))
    it
  }

  show link: {
    underline.with(stroke: rgb("#0074d9"), offset: 2pt)
  }
  show link: set text(blue)

  set page(
    margin: (
      left: 15mm,
      right: 15mm,
      top: 15mm,
      bottom: 20mm,
    ),
    fill: white, // 解决源代码跳转问题
    header: [#align(center)[#header] #v(-0.2cm)] + line(length: 100%),
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
  body

  show "Deralive": name => box[
    #box(
      image(
        "../icons/Head.jpg",
        height: 0.8em,
      ),
    ) #name
  ]

  show "Github": githubUrl => box[
    #box(faGithub) #githubUrl
  ]

  show "Linux": name => box[
    #box(faLinux) #name
  ]

  show "Windows": name => box[
    #box(faWindows) #name
  ]
}
