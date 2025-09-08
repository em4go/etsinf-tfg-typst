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