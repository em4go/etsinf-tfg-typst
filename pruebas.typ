#let in-outline = state("in-outline", false)
#let large = 14.4pt
#let huge = 24.88pt
#set heading(numbering: "1.1.")

#show outline: it => align(center, it)
#show outline.entry: set block(spacing: 3pt)

#let listfigurename = "Índice de figuras"
#let listtablename = "Índice de tablas"
#let listalgorithmname = "Índice de algoritmos"
#let listquadrename = "Índice de cuadros"
#let algorithmname = "Algoritmo"
#let quadrename = "Cuadro"

#set figure(supplement: "Figura", kind: "figure")
#set figure(supplement: "Tabla", kind: "table")

#let algorithm_counter = counter("algorithm")
#let algorithm(caption: none, body) = {
  algorithm_counter.step()
  figure(
    kind: "algorithm",
    supplement: algorithmname,
    caption: caption,
    body
  )
}

#let quadre_counter = counter("quadre")
#let quadre(caption: none, body) = {
  quadre_counter.step()
  figure(
    kind: "quadre",
    supplement: quadrename,
    caption: caption,
    body
  )
}

#show figure: it => {
  if it.kind == "algorithm" or it.kind == "quadre" {
    it.body
    line(length: 100%)
    set text(size: 0.8em, weight: "bold")
    align(left, [
      #it.supplement #counter(it.kind).at(it.location()).first(): #h(0.4em) #it.caption
    ])
    line(length: 100%)
  } else {
    it.body
    if it.caption != none {
      set text(size: 0.8em, weight: "bold")
      align(center, [
        #it.supplement #counter(it.kind).at(it.location()).first(): #h(0.4em) #it.caption
      ])
    }
  }
}

#let APPENDIX = {
  set heading(numbering: "A.1")
  // Add separator to TOC
  context {
    let loc = here()
    outline.entry(heading(level: 1, "Apéndices"), page: counter(page).at(loc).first())
    line(length: 100%)
  }
}

#show heading.where(level: 1): it => {
  context {
    if in-outline.get() {
      // Renderiza el título normalmente en el índice
      it
    } else {
      // Calcula el número del capítulo usando el contador
      let chapter-num = counter(heading).at(it.location()).at(0)
      
      // Aplica el estilo deseado a los títulos de nivel 1 en el documento
      set heading(numbering: none)
      
      // Contenedor para las reglas y el espaciado
      box(
        // Estructura vertical con espacios y reglas
        stack(dir: ttb, spacing: 12pt,
          v(12pt),
          box(width: 100%, line(length: 100%, stroke: 1pt)),
          v(1pt),
          box(width: 100%, line(length: 100%, stroke: 0.4pt)),
          v(12pt),
          // Etiqueta del capítulo en mayúsculas y tamaño grande
          align(right, text(size: large)[#upper("capítulo " + str(chapter-num))]),
          // Título del capítulo
          align(right, text(size: huge)[#it.body]),
          v(5pt),
          box(width: 100%, line(length: 100%, stroke: 1pt)),
          v(12pt),
        ),
      )
    }
  }
}

#context in-outline.update(true)
#outline(title: [
  #align(right, text(size: huge, weight: "bold")[Índice])
  #line(length: 100%)
  #v(1em)
], depth: 3)
#outline(
  title: [
    #align(right, text(size: huge, weight: "bold")[Índice de figuras])
    #line(length: 100%)
    #v(1em)
  ],
  target: figure.where(kind: "figure") // O target: figure.where(kind: "figura") si usaste ese kind
)
#outline(
  title: [
    #align(right, text(size: huge, weight: "bold")[Índice de tablas])
    #line(length: 100%)
    #v(1em)
  ],
  target: figure.where(kind: "table") // o target: figure.where(kind: "tabla") si usaste ese kind
)
#outline(
  title: [
    #align(right, text(size: huge, weight: "bold")[Índice de algoritmos])
    #line(length: 100%)
    #v(1em)
  ],
  target: figure.where(kind: "algorithm")
)
#outline(
  title: [
    #align(right, text(size: huge, weight: "bold")[Índice de cuadros])
    #line(length: 100%)
    #v(1em)
  ],
  target: figure.where(kind: "quadre")
)
#context in-outline.update(false)

#pagebreak()

= Introduction

== Una figura de una imagen

#figure(
  image("baseportada.png"),
  caption: "Ejemplo de una figura.",
  kind: "figure", // Esto es opcional, pero recomendado para claridad
  supplement: "Figura",
) <fig:ejemplo>

= Otro chapter

#figure(
  table(
    columns: 2,
    [Encabezado 1], [Encabezado 2],
    [Dato A], [Dato B],
    [Dato C], [Dato D],
  ),
  caption: "Ejemplo de una tabla.",
  kind: "table", // Esto es opcional, pero recomendado para claridad
  supplement: "Tabla",
) <tbl:ejemplo>