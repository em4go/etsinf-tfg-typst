#import "lib.typ": tfgetsinf_template

#show: tfgetsinf_template.with(
  lang: "en",
  list_of_tables: false,
  list_of_figures: false,
  list_of_quadres: false,
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

#counter(page).update(1)

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