#import "template.typ": *

#let title = "Título del Trabajo"



#place(
  bottom + left,
  dx: -x_margin,
  dy: y_margin,
  image("baseportada.png", width: 21cm)
)
#place(
  top + left,
  dx: - x_margin + 2cm,
  dy: -y_margin + 2cm,
  image("logo-upv.svg", height: 2cm),
  )
#place(
  top + right,
  dx: x_margin - 2cm,
  dy: -y_margin + 2cm,
  image("logo-etsinf.svg", height: 2cm)
)

#v(3cm)
#align(center)[

#text(size: large, fill: grisfosc)[
  Escuela Técnica Superior de Ingeniería Informática

  Universitat Politècnica de València
]


#v(1fr)

#text(size: huge, weight: "bold")[#title]

#v(-0.5cm)
#text(size: large, weight: "bold")[
  Trabajo de Fin de Grado
]

#v(0.2cm)

#text(size: large, fill: grisclar)[
  Grado en Ingeniería Informática
]


#v(2fr)

#align(right)[
#grid(
  columns: 2,
  align: left + top,
  gutter: 0.2cm,
  text("Autor:", style: "italic"),"Ernesto Martínez Gómez",
  text("Tutor:", style: "italic"),"Laura Sebastiá Tarín" + "\n" + "César Castillo Espinosa",
)
Curso 2025/2026
]
]


#pagebreak() 