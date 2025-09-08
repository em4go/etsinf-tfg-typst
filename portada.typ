#let x_margin = 3cm
#let y_margin = 2.35cm

#let gray40    = rgb(64, 64, 64) // gris oscuro

#set page(paper: "a4", margin: (left: x_margin, right: x_margin, top: y_margin, bottom: y_margin))


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

#v(2cm)
#align(center)[
  #text(fill: gray40)[
    Escuela Técnica Superior de Ingeniería Informática

    Universitat Politècnica de València
  ]
]
#pagebreak() 