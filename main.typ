#import "lib.typ": tfgetsinf_template

#show: tfgetsinf_template.with(
  lang: "es",
  list_of_tables: false,
  list_of_figures: false,
  list_of_quadres: false,
  list_of_algorithms: false,
  title: "Título del Trabajo",
  author: "Ernesto Martínez Gómez",
  tutor: "Juan Miguel Alberola Oltra",
  tutor2: "Victor Sánchez Anguix",
  course: "2025/2026",
  keywords_cat: "palabras clave en catalán",
  keywords_es: "palabras clave en español",
  keywords_en: "keywords in english",
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