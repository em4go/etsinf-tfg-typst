// Definición de colores
#let dkgreen = "rgb(0, 153, 0)";
#let gray = "rgb(128, 128, 128)";
#let mauve = "rgb(148, 0, 209)";
#let grisclar = luma(0.5)
#let grisfosc = luma(0.25)
#let gray40    = rgb(64, 64, 64) // gris oscuro
#let gray60    = rgb(96, 96, 96) // gris claro

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
  set text(lang: lang, font: "Palatino", size: 11pt)
  set page(paper: "a4", margin: (left: 2cm, right: 2cm, top: 2cm, bottom: 2cm))
  set par(justify: true, spacing: 1em)

  set heading(numbering: "1.")

  show heading.where(level: 1): it => {
  v(1cm)
  line(length:100%, stroke: 1pt)
  // Stack the elements vertically with a small amount of spacing
  stack(dir: ttb, spacing: 0.2cm, [
    #align(right, text(size: 2em)[Capítulo #counter(heading).at(it.location()).at(0)])
    #align(right, text(size: 2em, weight: "bold")[#it.body])
  ])
  line(length:100%, stroke: 1pt)
  v(1cm)
}


  // 2. Definición de cadenas de texto multi-idioma
  let titulacioname_str = if lang == "catalan" { "Grau en Enginyeria Informàtica" } else if lang == "spanish" { "Grado en Ingeniería Informática" } else { "Degree in Computer Engineering" }
  let tfgname_str = if lang == "catalan" { "Treball fi de grau" } else if lang == "spanish" { "Trabajo fin de grado" } else { "Degree final work" }
  let authorname_str = if lang == "catalan" { "Autor" } else if lang == "spanish" { "Autor" } else { "Author" }
  let tutorname_str = if lang == "catalan" { "Tutor" } else if lang == "spanish" { "Tutor" } else { "Tutor" }
  let coursename_str = if lang == "catalan" { "Curs" } else if lang == "spanish" { "Curso" } else { "Course" }
  let keywordsname_str = if lang == "catalan" { "Paraules clau" } else if lang == "spanish" { "Palabras clave" } else { "Key words" }
  let algorithm_name_str = if lang == "catalan" { "Algorisme" } else if lang == "spanish" { "Algoritmo" } else { "Algorithm" }
  let list_algorithm_name_str = if lang == "catalan" { "Índex d'algorismes" } else if lang == "spanish" { "Índice de algoritmos" } else { "List of algorithms" }
  let quadre_name_str = if lang == "catalan" { "Quadre" } else if lang == "spanish" { "Cuadro" } else { "Quadre" }
  let list_quadre_name_str = if lang == "catalan" { "Índex de quadres" } else if lang == "spanish" { "Índice de cuadros" } else { "List of quadres" }
  let appendicesname_str = if lang == "catalan" { "Apèndixs" } else if lang == "spanish" { "Apéndices" } else { "Appendices" }

  // Función que genera el contenido de la portada
  // Recibe como argumentos el título, autor, tutor y curso específicos de tu trabajo.
  let title_page_content() = {
// -------------------------------
// Elementos fijos (fuera del flujo)
// -------------------------------

// Logos superiores
place(bottom + left, dx: -2cm, dy: 5cm)[
  #image("baseportada.png", height: 12.89cm, width:21cm)
]
grid(
  columns: (auto, 1fr, auto),
  image("logo-upv.svg", height:2cm),
  (""), // espacio en blanco
  image("logo-etsinf.svg", height:2cm)
)


// -------------------------------
// Bloque central (contenido en flujo)
// -------------------------------
v(2cm)

// Línea institucional (gris oscuro)
align(center)[
  #text(size: 1.25em, fill: gray40)[
    Escuela Técnica Superior de Ingeniería Informática
  ]
]
align(center)[
  #text(size: 1.25em, fill: gray40)[
    Universitat Politècnica de València
  ]
]

v(1.2fr) // espacio elástico

align(center)[
  #text(size: 2em, weight: "bold")[#title]
]

v(0.4cm)

// Sub-título en versalitas (aproximado con mayúsculas)  
align(center)[
  #text(size: 1.2em,)[#tfgname_str]
]

v(0.2cm)

// Titulación en gris claro
align(center)[
  #text(size: 1.2em, fill: gray60)[#titulacioname_str]
]

v(2fr) // espacio elástico hasta la parte baja

place(bottom + right, float: true, clearance: 0.5cm)[
#table(
  columns: 2,
  align: left + top, // primera columna a la izquierda, segunda a la izquierda
  stroke: none,
  text("Autor:", style: "italic"),author,
  text("Tutor:", style: "italic"),tutor + "\n" + tutor2,
)
#if course != none {"Curso " + course; ""}
]

pagebreak()
  }

  // 5. Formato de captions de figuras y flotantes
  show figure: it => {
    // Asegúrate de que el contenido principal de la figura (por ejemplo, la imagen o tabla) se muestre.
    // 'it.body' se refiere al contenido que está dentro de la función 'figure' (ej. #image(...)).
    it.body

    // Comprueba si la figura tiene un pie de figura (caption) definido.
    if it.caption != none {
      // Aplica el estilo de texto deseado para el pie de figura.
      // 'size: 0.8em' es una aproximación al tamaño 'small' de LaTeX [6, 12].
      // 'weight: "bold"' hace que el texto sea negrita, replicando el 'bf' de LaTeX [6, 13].
      set text(size: 0.8em, weight: "bold")

      // Obtiene el número de la figura (ej. "Figura 1").
      // 'counter(figure)' accede al contador de figuras.
      // '.at(it.location)' obtiene el valor del contador en la ubicación de esta figura [14, 15].
      // '.display()' formatea el número con el nombre localizado (ej. "Figura") y el número [16].
      let figure_number = counter(figure).at(it.location).display()

      // Crea el contenido del pie de figura.
      // 'align(center, [...])' centra el pie de figura, similar al 'justification=centerlast' de LaTeX [6, 17].
      // El formato es "Figura X: Texto del pie", con un espacio horizontal '#h(0.4em)' después de los dos puntos.
      // 'it.caption' es el bloque de contenido que has pasado al argumento 'caption' de tu función 'figure' [1, 11].
      align(center, [
        #figure_number: #h(0.4em) #it.caption
      ])
    }
}
  // Implementación de #algorithm y #quadre como funciones custom, similar al punto 6 anterior.
  // Ejemplo de #algorithm function:
  let algorithm_counter = counter("algorithm")
  let algorithm(caption: none, body) = {
    algorithm_counter.step()
    figure(
      caption: if caption != none {
        set text(size: 0.8em, weight: "bold")
        algorithm_name_str + " " + algorithm_counter.display("1") + ": " + caption
      },
      body
    )
  }
  // Implementación similar para #quadre

  // 6. Listados de código
  let code_block(lang: "cpp", caption: none, body) = {
    set text(font: "New Computer Modern Mono", size: 0.8em)
    figure(
      caption: caption,
      block(
        stroke: 1pt,
        fill: white,
        raw(lang: lang, body)
      )
    )
  }

  // 7. Resumen y palabras clave
  let abstract(abstract_content) = {
    set text(font: "New Computer Modern", weight: "bold", size: 2.5em)
    align(center)[#if lang == "catalan" { "Resum" } else if lang == "spanish" { "Resumen" } else { "Abstract" }]
    v(1em)
    set text(size: 11pt)
    abstract_content
    v(1em)
    line(length: 100%)
    set text(font: "New Computer Modern", weight: "bold")
  [#keywordsname_str:] + if lang == "catalan" { keywords_cat } else if lang == "spanish" { keywords_es } else { keywords_en }
    v(1em)
  }

  // Comienza el documento
  title_page_content()

  // Inserta un salto de página después de la portada [25]
  pagebreak()

  // Restablece la numeración de página a 1 para el cuerpo del documento
  // y configura el estilo de numeración. "1" implica números arábigos, generalmente en el pie de página [26, 27]
  set page(numbering: "1")

  abstract("hola") // Asumiendo que el primer argumento de `body` es el resumen
  
  // make_indexes() // Generar índices y listas [41]

  body // Contenido principal del documento
}