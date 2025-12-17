#import "colorbox.typ": *
#import "@preview/mitex:0.2.6": *
#import "@preview/subpar:0.2.2": *
#import "@preview/subpar:0.2.2": grid as subfigure
#import "@preview/numbly:0.1.0": numbly
#import "@preview/cuti:0.4.0": show-cn-fakebold
#import "@preview/codly:1.3.0": * // 代码高亮包
#import "@preview/codly-languages:0.1.6": *
#import "@preview/cjk-unbreak:0.2.1": remove-cjk-break-space // 解决 CJK 换行问题

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
  show: show-cn-fakebold

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

  set heading(numbering: "1.1.1  ")

  show heading: it => box(width: 100%)[
    #set text(font: ("Times New Roman", "Source Han Serif SC", "SimSun"))
    #if it.numbering != none {
      text(size: 1.1em)[
        #counter(heading).display("1.1.1")
      ]
    }
    #h(0.5em) #text(weight: "extrabold")[#it.body]
  ]

  show heading.where(level: 1): it => {
    counter(math.equation).update(0)
    it
  }

  set math.equation(
    numbering: n => {
      numbering("(1.1)", counter(heading).get().first(), n)
    },
  )

  show outline: set heading(numbering: none)
  show outline.entry.where(level: 1): it => {
    set block(above: 1.1em)
    text(
      font: ("Times New Roman", "Source Han Serif SC", "SimSun"),
    )[
      #text(weight: "extrabold", size: 1.1em)[#it]
    ]
  }
  show outline.entry.where(level: 2): it => {
    set block(above: 1.1em)
    it
  }

  show: remove-cjk-break-space

  show: codly-init
  codly(languages: codly-languages) //设置语言图标
  show raw: it => {
    set text(font: ("JetBrains Mono NL", "SimSun"))
    it
  }

  show link: {
    underline.with(stroke: rgb("#0074d9"), offset: 2pt)
  }
  show link: set text(blue)


  show "Github": githubUrl => box[
    #box(faGithub) #githubUrl
  ]

  show "Linux": name => box[
    #box(faLinux) #name
  ]

  show "Windows": name => box[
    #box(faWindows) #name
  ]

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
            align(
              left,
            )[ #h(-2em) _In Typst By_ #link("github.com/Shichien", scr("Deralive"))]
            v(-2em)
            align(right)[#counter(page).display("第 1 页，共 1 页", both: true)] // 奇数页靠右
          } else {
            align(left)[ #h(-2em) #counter(page).display("第 1 页，共 1 页", both: true)] // 偶数页靠左
            v(-2em)
            align(right)[_In Typst By_ #link("github.com/Shichien", scr("Deralive"))]
          }
        ]
      },
  )
  body
}
