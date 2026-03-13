#import "../_Template/src/colorbox.typ": *
#import "../_Template/src/preamble.typ": *
#import "@preview/cetz:0.4.2"
#show: template.with(header: "华东师范大学软件工程学院课程作业", author: "张梓卫")

#v(30pt) <front-matter>

#align(
  center,
  text(17pt)[
    华东师范大学软件工程学院课程作业
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
  [课程名称：算法设计与分析], [年级：大三], [#h(2.5cm)], [],
  [指导教师：彭超], [姓名：张梓卫], [], [],
  [作业主题：（9）], [学号：10235101526], [], [完成日期：2025/12/16],
)

= 23.1-3

#question[
  Show that if an edge $(u, v)$ is contained in some minimum spanning tree, then it is a light edge crossing some cut of the graph.

  证明：如果一条边 $(u, v)$ 包含在某棵最小生成树中，那么它是跨越该图某个切割的一条 Light 边。
]

#answer[
  设 $T$ 是一棵包含边 $(u, v)$ 的最小生成树。
  设 $T_0$ 和 $T_1$ 是从 $T$ 中移除边 $(u, v)$ 后得到的两棵树。令 $V_0$ 和 $V_1$ 分别为 $T_0$ 和 $T_1$ 的顶点集合。
  考虑切割 $(V_0, V_1)$，显然边 $(u, v)$ 跨越了这个切割。

  我们使用反证法：假设 $(u, v)$ 不是跨越该切割的轻边。
  这意味着存在另一条跨越该切割的边 $(x, y)$，满足 $w(x, y) < w(u, v)$。
  如果我们把边 $(x, y)$ 加回到 #mi(`$T_0 \cup T_1$`) 中，我们将重新连接这两个连通分量，从而构造出一棵新的生成树 $T'$。
  此时，$T'$ 的总权重为：
  $ w(T') = w(T) - w(u, v) + w(x, y) $
  由于 $w(x, y) < w(u, v)$，则 $w(T') < w(T)$。
  这与 $T$ 是最小生成树的前提相矛盾。

  因此，假设不成立，$(u, v)$ 必须是跨越该切割的权重最小的边（即 Light 边）。
]

= 23.1-4

#question[
  Give a simple example of a connected graph such that the set of edges #mi(`$\{(u, v) : \text{there exists a cut } (S, V - S) \text{ such that } (u, v) \text{ is a light edge crossing } (S, V - S)\}$`) does not form a minimum spanning tree.

  给出一个连通图的简单反例，使得所有作为某个切割的轻边的边 $(u, v)$ 组成的集合，无法构成最小生成树。
]

#answer[
  #grid(
    columns: (1fr, auto),
    gutter: 2em,
    align: (left + horizon, center + horizon),
    [
      考虑一个简单的成环图（三角形），且每个顶点的权重相等（均为 1）：

      - 对于 Cut $(\{1\}, \{2, 3\})$，边 $(1, 2)$ 和 $(1, 3)$ 都是跨越切割的边，且权重均为最小值 1，因此它们都是 **Light Edge**。
      - 对于 Cut $(\{2\}, \{1, 3\})$，边 $(2, 1)$ 和 $(2, 3)$ 都是 Light Edge。
      - 对于 Cut $(\{3\}, \{1, 2\})$，边 $(3, 1)$ 和 $(3, 2)$ 都是 Light Edge。

      集合包含了 3 条成环的边，显然不能构成最小生成树。
    ],

    // --- 右栏：CeTZ 画图 ---
    cetz.canvas(length: 1.5cm, {
      import cetz.draw: *

      // 定义节点样式
      let n-style = (stroke: 1pt, fill: white, radius: 0.3)

      // 1. 绘制边 (先画边，这样边会在节点下面)
      // 这里的坐标是根据等边三角形计算的大致位置
      line((0, 1.7), (-1, 0), name: "e12")
      line((-1, 0), (1, 0), name: "e23")
      line((1, 0), (0, 1.7), name: "e31")

      // 2. 绘制边的权重标签 (加个白色背景遮挡线条)
      content("e12", box(fill: white, inset: 2pt)[1])
      content("e23", box(fill: white, inset: 2pt)[1])
      content("e31", box(fill: white, inset: 2pt)[1])

      // 3. 绘制节点圆圈
      circle((0, 1.7), ..n-style, name: "n1")
      circle((-1, 0), ..n-style, name: "n2")
      circle((1, 0), ..n-style, name: "n3")

      // 4. 绘制节点数字
      content("n1", [*1*])
      content("n2", [*2*])
      content("n3", [*3*])
    }),
  )
]

#pagebreak()

= 23.2-4

#question[
  Suppose that all edge weights in a graph are integers in the range from 1 to $|V|$. How fast can you make Kruskal’s algorithm run? What if the edge weights are integers in the range from 1 to $W$ for some constant $W$?

  假设图中所有边的权重都是 $1$ 到 $|V|$ 之间的整数。Kruskal 算法的运行速度能有多快？如果边权是 $1$ 到某个常数 $W$ 之间的整数呢？
]

#answer[
  标准的 Kruskal 算法运行时间为 $O(E \lg E)$，先把图中所有的边，按权重从小到大排好序。再按顺序拿出每一条边。如果这条边连接的两个点还不在同一个集合里，就选这条边，把两个点连起来。

  查询集合的操作是用并查集，这一步非常快，时间复杂度看作是线性的，排序显然成为了瓶颈。

  1. 如果边权在 $1$ 到 $|V|$ 之间：
    普通的排序需要两两比较，而当知道边权的取值范围时，直接使用计数排序即可。时间复杂度为 $O(E + |V|)$（要准备 K 个桶来装 E 条边）。
    对于连通图，通常有 #mi(`$E \ge |V| - 1$`)，因此排序时间可视为 $O(E)$。
    排序完成后，算法执行并查集，总操作时间为 #mi(`$O(E \alpha(V))$`)。

  2. 如果边权在 $1$ 到常数 $W$ 之间：
    同样使用计数排序，时间复杂度为 $O(E + W)$。由于 $W$ 是常数，排序时间仍为 $O(E)$。
    后续处理每一条边以判断是否连接两个不相交集合的操作，其时间复杂度依然是 #mi(`$O(E \alpha(V))$`)，且这部分操作与边权的具体大小无关。
    因此，总运行时间依然是 #mi(`$O(E \alpha(V))$`)。
]
