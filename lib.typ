#let x_margin = 3cm
#let y_margin = 2.35cm

#let large = 14.4pt
#let huge = 24.88pt

// Definición de colores
// Definiciones de colores equivalentes a los de tfgetsinf.cls
#let dkgreen = rgb(0, 153, 0)      // Original: rgb{0,0.6,0} (verde oscuro)
#let gray = rgb(128, 128, 128)     // Original: rgb{0.5,0.5,0.5} (gris)
#let mauve = rgb(148, 0, 209)      // Original: rgb{0.58,0,0.82} (malva)
#let grisclar = rgb(128, 128, 128) // Original: gray{0.5} (gris claro)
#let grisfosc = rgb(64, 64, 64)    // Original: gray{0.25} (gris oscuro)

// Function to create abstract
#let create_abstract = (
  lang: "es",
  body: "",
  keywords: ()
) => {
  let strings = (
    "ca": (
      "abstractname": "Resum",
      "keywordsname": "Paraules clau"
    ),
    "es": (
      "abstractname": "Resumen",
      "keywordsname": "Palabras clave"
    ),
    "en": (
      "abstractname": "Abstract",
      "keywordsname": "Key words"
    )
  )
  
  let abstract_str = strings.at(lang).at("abstractname")
  let keywords_str = strings.at(lang).at("keywordsname")
  
  let keywords_text = keywords.join(", ")
  
  [
    #align(right)[
      #text(size: 2em, font: "Droid Sans")[#abstract_str]
    ]

    #par(
      first-line-indent: 2em,
      justify: true,
      body
    )

    *#keywords_str:* #keywords_text

    #v(-0.2cm)
    #line(length: 100%)
  ]
}

#let tfgetsinf_template(
  lang: "es", // or "ca" or "en"
  list_of_tables: false,
  list_of_figures: false,
  list_of_quadres: false,
  list_of_algorithms: false,
  title: "Título del Trabajo",
  author: "Autor del Trabajo",
  tutor: "Tutor del Trabajo",
  tutor2: "Co-Tutor del Trabajo",
  course: "Curso Académico",
  keywords_cat: "palabras clave en catalán",
  keywords_es: "palabras clave en español",
  keywords_en: "keywords in english",
  body
) = {
  // 1. Configuración de idioma, geometría, tipografía, colores, etc.
  set text(lang: lang)
  set page(paper: "a4", margin: (left: x_margin, right: x_margin, top: y_margin, bottom: y_margin), numbering: "1.")


  // 2. Definición de cadenas de texto multi-idioma
  let strings = (
    "ca": (
      "titulacioname": "Grau en Ciència de Dades",
      "tfgname": "Treball fi de grau",
      "authorname": "Autor",
      "tutorname": "Tutor",
      "coursename": "Curs",
      "keywordsname": "Paraules clau",
      "abstractname": "Resum",
      "algorithm_name": "Algorisme",
      "list_algorithm_name": "Índex d'algorismes",
      "quadre_name": "Quadre",
      "list_quadre_name": "Índex de quadres",
      "appendicesname": "Apèndixs",
      "university1": "Escola Tècnica Superior d'Enginyeria Informàtica",
      "university2": "Universitat Politècnica de València",
      "tfg_full": "Treball de Fi de Grau",
      "degree_full": "Grau en Ciència de Dades"
    ),
    "es": (
      "titulacioname": "Grado en Ciencia de Datos",
      "tfgname": "Trabajo fin de grado",
      "authorname": "Autor",
      "tutorname": "Tutor",
      "coursename": "Curso",
      "keywordsname": "Palabras clave",
      "abstractname": "Resumen",
      "algorithm_name": "Algoritmo",
      "list_algorithm_name": "Índice de algoritmos",
      "quadre_name": "Cuadro",
      "list_quadre_name": "Índice de cuadros",
      "appendicesname": "Apéndices",
      "university1": "Escuela Técnica Superior de Ingeniería Informática",
      "university2": "Universitat Politècnica de València",
      "tfg_full": "Trabajo de Fin de Grado",
      "degree_full": "Grado en Ciencia de Datos"
    ),
    "en": (
      "titulacioname": "Degree in Data Science",
      "tfgname": "Degree final work",
      "authorname": "Author",
      "tutorname": "Tutor",
      "coursename": "Course",
      "keywordsname": "Key words",
      "abstractname": "Abstract",
      "algorithm_name": "Algorithm",
      "list_algorithm_name": "List of algorithms",
      "quadre_name": "Quadre",
      "list_quadre_name": "List of quadres",
      "appendicesname": "Appendices",
      "university1": "School of Computer Engineering",
      "university2": "Polytechnic University of Valencia",
      "tfg_full": "Final Degree Project",
      "degree_full": "Degree in Data Science"
    )
  )

  let titulacioname_str = strings.at(lang).at("titulacioname")
  let tfgname_str = strings.at(lang).at("tfgname")
  let authorname_str = strings.at(lang).at("authorname")
  let tutorname_str = strings.at(lang).at("tutorname")
  let coursename_str = strings.at(lang).at("coursename")
  let keywordsname_str = strings.at(lang).at("keywordsname")
  let algorithm_name_str = strings.at(lang).at("algorithm_name")
  let list_algorithm_name_str = strings.at(lang).at("list_algorithm_name")
  let quadre_name_str = strings.at(lang).at("quadre_name")
  let list_quadre_name_str = strings.at(lang).at("list_quadre_name")
  let appendicesname_str = strings.at(lang).at("appendicesname")
  let university1_str = strings.at(lang).at("university1")
  let university2_str = strings.at(lang).at("university2")
  let tfg_full_str = strings.at(lang).at("tfg_full")
  let degree_full_str = strings.at(lang).at("degree_full")

  place(
  bottom + left,
  dx: -x_margin,
  dy: y_margin,
  image("baseportada.png", width: 21cm)
)
place(
  top + left,
  dx: - x_margin + 2cm,
  dy: -y_margin + 2cm,
  image("logo-upv.svg", height: 2cm),
  )
place(
  top + right,
  dx: x_margin - 2cm,
  dy: -y_margin + 2cm,
  image("logo-etsinf.svg", height: 2cm)
)

v(3cm)
align(center)[

#text(size: large, fill: grisfosc)[
  #university1_str

  #university2_str
]


#v(1fr)

#text(size: huge, weight: "bold")[#title]

#v(-0.5cm)

#text(size: large, weight: "bold")[
  #smallcaps(tfg_full_str)
]

#v(0.2cm)

#text(size: large, fill: grisclar)[
  #degree_full_str
]


#v(2fr)

#align(right)[
#grid(
  columns: 2,
  align: left + top,
  gutter: 0.2cm,
  text(authorname_str + ":", style: "italic"),author,
  text(tutorname_str + ":", style: "italic"),tutor + "\n" + tutor2,
)
#block(coursename_str + " " + course)
]
]

pagebreak()


  body // Contenido principal del documento
}