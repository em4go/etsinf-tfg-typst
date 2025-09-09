#import "lib.typ": tfgetsinf_template, create_abstract

#show: tfgetsinf_template.with(
  lang: "es",
  list_of_tables: false,
  list_of_figures: false,
  list_of_quadres: false,
  list_of_algorithms: false,
  title: "Título del Trabajo",
  author: "Ernesto Martínez Gómez",
  tutor: "Laura Sebastiá Tarín",
  tutor2: "César Castillo Espinosa",
  course: "2025/2026",
  keywords_cat: "palabras clave en catalán",
  keywords_es: "palabras clave en español",
  keywords_en: "keywords in english",
)

#pagebreak()

#create_abstract(
  lang: "es",
  body: lorem(100),
  keywords: ("Typst", "LaTeX", "Overleaf", "Markdown", "Word", "Google Docs", "Document Preparation", "Academic Writing", "Technical Writing", "Formatting", "Typesetting")
)


#create_abstract(
  lang: "ca",
  body: lorem(100),
  keywords: ("Typst", "LaTeX", "Overleaf", "Markdown", "Word", "Google Docs", "Document Preparation", "Academic Writing", "Technical Writing", "Formatting", "Typesetting")
)

#create_abstract(
  lang: "en",
  body: lorem(100),
  keywords: ("Typst", "LaTeX", "Overleaf", "Markdown", "Word", "Google Docs", "Document Preparation", "Academic Writing", "Technical Writing", "Formatting", "Typesetting")
)

#pagebreak()

#set heading(numbering: "1.1.")

#let create_index = (
  lang: "es",
) => {
  align(right, text(size: 3em, weight: "bold")[Índice])
  v(-0.7cm)
  line(length: 100%)
  v(1em)
  context{
    let outlines = query(<index-text>)
    for item in outlines {
      if item == none {
        continue
      }
      let loc  = item.location()
      let page = counter(page).at(loc).at(0)
      link(loc, [
        *#item.text*
        #h(1fr)
        *#page*

      ])
    }
  }
  line(length: 100%)
  outline(title: none, depth: 3, target: heading)
}

#create_index(lang: "es")

#pagebreak()

#pagebreak()

#outline(title: [
  #align(right, text(size: 24pt, weight: "bold")[Índice de figuras <index-text>])
  #line(length: 100%)
  #v(1em)
  ],
  target: figure.where(kind: image))
  #pagebreak()
#outline(title: [
  #align(right, text(size: 24pt, weight: "bold")[Índice de cosas <index-text>])
  #line(length: 100%)
  #v(1em)
  ],
  target: figure.where(kind: image))
#pagebreak()
#outline(title: [
  #align(right, text(size: 24pt, weight: "bold")[Índice de pedos <index-text>])
  #line(length: 100%)
  #v(1em)
  ],
  target: figure.where(kind: image))
#pagebreak()

= Hola

== Subtitle

= Segundo titulo

#figure(
  supplement: "Figura",
  caption: "Figura de ejemplo",
)[
  #image("logo-etsinf.svg"),
]

= Other title