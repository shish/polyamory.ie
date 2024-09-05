---
title: Polycule
tags:
- polycule form
---
The collection of people who are dating each other, so named because the graph can end up looking like a molecule


{% graphviz %}
digraph {
    A [label="Alice"]
    B [label="Bob"]
    C [label="Charlie"]
    D [label="Dave"]
    E [label="Steve"]
    F [label="Katie"]
    G [label="Kris"]
    H [label="Eve"]
    I [label="Tom"]
    J [label="Jules"]
    L [label="Staple"]
    M [label="Hank"]
    N [label="Nigel"]
  A -> F
  D -> E
  B -> C
  H -> I
  A -> B -> C -> D -> E -> F -> A
  F -> G
  D -> H -> I -> J -> C
  H -> L -> M -> N
}
{% endgraphviz %}
