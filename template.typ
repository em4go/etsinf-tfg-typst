// -------------------------------
// Variables del documento
// -------------------------------
#let tfgetsinf(
  title: "",
  subtitle: "",
  author: "",
  tutor: "",
  tutor2: "",
  affiliation: "",
  faculty: "",
  degree: "",
  year: none,
  logo_university: none,
  logo_faculty: none,
  main-color: "E94845",
  whitepage: false,
  body,
) = {

let gray40    = rgb(64, 64, 64) // gris oscuro
let gray60    = rgb(96, 96, 96) // gris claro

// -------------------------------
// Configuración de página
// -------------------------------
set text(lang: "es")
set page(
  margin: (top: 2cm, bottom: 2cm, left: 2cm, right: 2cm),
)

// Set the initial value of the heading counter to 0.
// This is the correct way to ensure the first heading
// gets a value of 1.
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

// let unary(.., last) = {
//   text("Capítulo " + str(last) + "\n", weight: "regular")
// }
// set heading(numbering: unary)

// show heading.where(level: 1): it => {
//   v(1cm)
//   line(length:100%, stroke: 1pt)
//   v(-0.8cm)
//   align(right)[
//     #text(size: 2em)[#it]
//   ]
//   line(length:100%, stroke: 1pt)
//   v(1cm)
// }

  // Número alineado a la derecha
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
  #text(size: 1.2em,)[#subtitle]
]

v(0.2cm)

// Titulación en gris claro
align(center)[
  #text(size: 1.2em, fill: gray60)[#degree]
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
#if year != none {"Curso " + year; ""}
]

pagebreak()

if whitepage {pagebreak(); none}


body
}
