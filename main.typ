#import "lib.typ": tfgetsinf_template
#import "utils.typ": quadre

#show: tfgetsinf_template.with(
  lang: "en",
  list_of_tables: false,
  list_of_figures: false,
  list_of_quadres: true,
  list_of_algorithms: false,
  title: "Título del Trabajo",
  author: "Ernesto Martínez Gómez",
  tutor: "Juan Miguel Alberola Oltra",
  tutor2: "Victor Sánchez Anguix",
  course: "2025/2026",
  abstract_cat: lorem(100),
  abstract_es: lorem(100),
  abstract_en: lorem(100),
  keywords_cat: "Typst, LaTeX, Overleaf, Markdown, Word, Google Docs, Document Preparation, Academic Writing, Technical Writing, Formatting, Typesetting",
  keywords_es: "Typst, LaTeX, Overleaf, Markdown, Word, Google Docs, Document Preparation, Academic Writing, Technical Writing, Formatting, Typesetting",
  keywords_en: "Typst, LaTeX, Overleaf, Markdown, Word, Google Docs, Document Preparation, Academic Writing, Technical Writing, Formatting, Typesetting",
)

= Hola

== Subtitle

= Segundo titulo

#figure(
  supplement: "Figura",
  caption: "Figura de ejemplo",
)[
  #image("logo-etsinf.svg"),
]

#quadre(
  caption: [Example of a quadre],
)[
  #block(
    stroke: 0.5pt,
    inset: 10pt,
    [This is the content of a quadre, which is a custom environment in the ETSINF template.]
  )
]

#lorem(50)

#quadre(
  caption: [Another quadre with a table inside],
)[
  #table(
    columns: (1fr, 1fr),
    [Feature], [Description],
    [Typst], [Modern typesetting],
    [LaTeX], [Classic typesetting],
  )
]

= Other title
