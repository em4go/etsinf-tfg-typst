#import "utils.typ": *

#let x_margin = 3cm
#let y_margin = 2.35cm

#let large = 14.4pt
#let huge = 24.88pt

// Definición de colores
// Definiciones de colores equivalentes a los de tfgetsinf.cls
#let dkgreen = rgb(0, 153, 0)      // Original: rgb{0,0.6,0} (verde oscuro)
#let gray = rgb(127, 127, 127)     // Original: rgb{0.5,0.5,0.5} (gris)
#let mauve = rgb(148, 0, 209)      // Original: rgb{0.58,0,0.82} (malva)
#let grisclar = rgb(127, 127, 127) // Original: gray{0.5} (gris claro)
#let grisfosc = rgb(64, 64, 64)    // Original: gray{0.25} (gris oscuro)

// check whether this is an empty page
#let is-page-empty() = {
  let page-num = here().page()
  query(selector.or(<empty-page-start>, <empty-page-end>)).chunks(2).any(((start, end)) => {
    start.location().page() < page-num and page-num < end.location().page()
  })
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
  abstract_cat: "",
  abstract_es: "",
  abstract_en: "",
  keywords_cat: "palabras clave en catalán",
  keywords_es: "palabras clave en español",
  keywords_en: "keywords in english",
  body
) = {
  // make pagebreaks detectable
  show pagebreak: it => {
    [#metadata(none) <empty-page-start>]
    it
    [#metadata(none) <empty-page-end>]
  }



  // 1. Configuración de idioma, geometría, tipografía, colores, etc.
  set text(lang: lang, font: ("TeX Gyre Pagella", "Palatino")) // Typst supports CM for math well, Palatino for text
  set math.equation(numbering: "(1)")
  show math.equation: set text(font: "New Computer Modern Math")
  
  let sans-font = ("LMSans10", "Helvetica", "Arial")
  
  set par(justify: true, spacing: 1em)
  set page(paper: "a4", margin: (left: x_margin, right: x_margin, top: y_margin, bottom: y_margin),
  numbering: "i",
  footer: context {
    let page_num = here().page()
    if is-page-empty() or page_num <= 2 {
      return none
    }

    // No mostrar header en páginas de índices
    let is_index_page = query(outline).any(it => it.location().page() == page_num)
    
    // Verificar si estamos en la página donde comienza el capítulo
    let chapter_on_this_page = query(heading.where(level: 1)).filter(h => h.location().page() == page_num)
    
    if is_index_page or chapter_on_this_page.len() > 0 {
      // Mostrar número de página en el footer (estilo 'plain')
      return align(center, text(font: "Palatino", size: 10pt, weight: "bold", counter(page).display()))
    }
    return none
  },
  header: context {
    let page_num = here().page()
    if is-page-empty() or page_num <= 2 {
      return none
    }

    // No mostrar header en páginas de índices
    let is_index_page = query(outline).any(it => it.location().page() == page_num)
    
    // Verificar si estamos en la página donde comienza el capítulo
    let chapter_on_this_page = query(heading.where(level: 1)).filter(h => h.location().page() == page_num)
    
    if is_index_page or chapter_on_this_page.len() > 0 {
      return none
    }

    let is_odd = calc.odd(page_num)
    
    // Buscar el capítulo actual (heading nivel 1)
    let chapters = query(heading.where(level: 1).before(here()))
    
    let chapter_text = if chapters.len() > 0 {
      let last_chapter = chapters.last()
      last_chapter.body
    } else {
      ""
    }

    // Buscar la sección actual (heading nivel 2)
    let sections = query(heading.where(level: 2).before(here()))
    let section_text = if sections.len() > 0 {
      let last_section = sections.last()
      // Verificar si la sección pertenece al capítulo actual
      if chapters.len() > 0 and last_section.location().page() >= chapters.last().location().page() {
        if last_section.numbering != none {
          let nums = counter(heading).at(last_section.location())
          str(nums.at(0)) + "." + str(nums.at(1)) + " " + last_section.body
        } else {
          last_section.body
        }
      } else {
        ""
      }
    } else {
      ""
    }

    let header_content = if is_odd {
      // Páginas impares: sección izquierda (\lhead), número derecha (\rhead)
      // En LaTeX: \lhead[\bfseries\thepage]{\sffamily\rightmark} \rhead[\sffamily\leftmark]{\bfseries\thepage}
      // Para impares: \lhead = \rightmark (sección), \rhead = \thepage
      grid(
        columns: (1fr, 1fr),
        align: (left, right),
        text(font: "Palatino", size: 10pt, section_text),
        text(font: "Palatino", size: 10pt, weight: "bold", counter(page).display())
      )
    } else {
      // Páginas pares: número izquierda (\lhead), capítulo derecha (\rhead)
      // Para pares: \lhead = \thepage, \rhead = \leftmark (capítulo)
      grid(
        columns: (1fr, 1fr),
        align: (left, right),
        text(font: "Palatino", size: 10pt, weight: "bold", counter(page).display()),
        text(font: "Palatino", size: 10pt, chapter_text)
      )
    }

    header_content
    v(5pt)
    line(length: 100%, stroke: 1.2pt)
  }
  )

  // Configuración de captions (equivalente a \RequirePackage[justification=centerlast,small,bf,labelsep=colon]{caption})
  show figure.caption: it => {
    set align(center)
    set text(size: 9pt) // small
    block(inset: (x: 2em))[
      *#it.supplement #it.counter.display():* #it.body
    ]
  }

  // Estilo específico para algoritmos (ruled)
  show figure.where(kind: "algorithm"): it => {
    set figure.caption(position: top)
    it
  }
  // skip header and footer on empty pages
  show selector.or(
    pagebreak.where(to: "odd"),
    pagebreak.where(to: "even"),
  ): set page(header: none, footer: none)

  // Estilos de los headings (chapters)
  set heading(numbering: "1.1.")

  show heading.where(level: 1): it => {
    let is_frontmatter_heading = it.numbering == none

    if not is_frontmatter_heading and it.outlined {
      pagebreak(to: "odd", weak: true)
    }
    context {
      if is_frontmatter_heading {
        align(right, text(size: huge, weight: "bold", font: sans-font)[#it.body])
        v(0.35em)
        line(length: 100%)
        v(1em)
      } else {
        // Calcula el número del capítulo usando el contador
        let chapter-num = counter(heading).at(it.location()).at(0)
        
        // Aplica el estilo deseado a los títulos de nivel 1 en el documento
        set heading(numbering: none)
        
        let label_str = if lang == "ca" { "capítol" } else if lang == "en" { "chapter" } else { "capítulo" }

        // LaTeX style for chapter:
        // \titleformat{\chapter}[display]
        // {\normalfont\Large\filleft\sffamily\bfseries}  % FORMAT
        // {\titlerule[1pt]                                  
        //  \vspace{1pt}
        //  \titlerule
        //  \vspace{1pc}
        //  \LARGE\MakeUppercase{\chaptertitlename} \thechapter} % LABEL
        // {0pc}                                                 % SEP
        // {\Huge}                                               % BEFORE CODE (abans del tÃ­tol)
        // [\vspace{5pt}{\titlerule[1pt]}]                       % AFTER CODE (desprÃ©s del tÃ­tol)

        set align(right)
        set text(font: sans-font, weight: "bold")

        v(12pt)
        stack(
          spacing: 1pt,
          line(length: 100%, stroke: 1pt),
          line(length: 100%, stroke: 0.5pt)
        )
        v(12pt) // 1pc approx 12pt
        text(size: large)[#upper(label_str + " " + str(chapter-num))]
        v(0pt)
        text(size: huge)[#it.body]
        v(5pt)
        line(length: 100%, stroke: 1pt)
        v(24pt)
      }
    }
  }

  show heading.where(level: 2): it => {
    set text(size: large, weight: "bold", font: sans-font)
    it
    v(-0.8em)
    line(length: 100%, stroke: 1.5pt)
    v(0.5em)
  }


  // 2. Definición de cadenas de texto multi-idioma
  let strings = (
    "ca": (
      "titulacioname": "Grau en Enginyeria Informàtica",
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
      "figures_name": "Figura",
      "list_figures_name": "Índex de figures",
      "tables_name": "Taula",
      "list_tables_name": "Índex de taules",
      "appendicesname": "Apèndixs",
      "university1": "Escola Tècnica Superior d'Enginyeria Informàtica",
      "university2": "Universitat Politècnica de València",
      "tfg_full": "Treball de Fi de Grau",
      "degree_full": "Grau en Enginyeria Informàtica"
    ),
    "es": (
      "titulacioname": "Grado en Ingeniería Informática",
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
      "figures_name": "Figura",
      "list_figures_name": "Índice de figuras",
      "tables_name": "Tabla",
      "list_tables_name": "Índice de tablas",
      "appendicesname": "Apéndices",
      "university1": "Escuela Técnica Superior de Ingeniería Informática",
      "university2": "Universitat Politècnica de València",
      "tfg_full": "Trabajo de Fin de Grado",
      "degree_full": "Grado en Ingeniería Informática"
    ),
    "en": (
      "titulacioname": "Degree in Computer Engineering",
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
      "figures_name": "Figure",
      "list_figures_name": "List of figures",
      "tables_name": "Table",
      "list_tables_name": "List of tables",
      "appendicesname": "Appendices",
      "university1": "School of Computer Engineering",
      "university2": "Polytechnic University of Valencia",
      "tfg_full": "Final Degree Project",
      "degree_full": "Degree in Computer Engineering"
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
  let figures_name_str = strings.at(lang).at("figures_name")
  let list_figures_name_str = strings.at(lang).at("list_figures_name")
  let tables_name_str = strings.at(lang).at("tables_name")
  let list_tables_name_str = strings.at(lang).at("list_tables_name")
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

pagebreak()

  create_abstract(
    lang: "es",
    body: abstract_es,
    keywords: keywords_es
  )


  create_abstract(
    lang: "ca",
    body: abstract_cat,
    keywords: keywords_cat
  )

  create_abstract(
    lang: "en",
    body: abstract_en,
    keywords: keywords_en
  )

pagebreak()


  let create_index = (
    lang: "es",
  ) => {
    let index_title = if lang == "ca" { "Índex" } else if lang == "en" { "Contents" } else { "Índice" }
    heading(level: 1, numbering: none, index_title)
    show outline.entry: it => context {
      let is-top-level = it.level == 1
      let page-counter = counter(page).at(it.element.location()).at(0)
      let is-first-body-entry = is-top-level and page-counter == 1

      let entry = link(
        it.element.location(),
        if is-top-level {
          text(weight: "bold")[#it.indented(it.prefix(), it.inner())]
        } else {
          it.indented(it.prefix(), it.inner())
        },
      )

      if is-first-body-entry {
        block(width: 100%, above: 1.3em)[
          #block(width: 100%, below: 1.3em)[
            #line(length: 100%)
          ]
          #entry
        ]
      } else {
        entry
      }
    }
    outline(title: none, depth: 3, target: heading)
  }

  create_index(lang: lang)

  if list_of_figures {
    pagebreak(weak: true)
    heading(level: 1, numbering: none, list_figures_name_str)
    outline(
      title: none,
      target: figure.where(kind: image)
    )
  }

  if list_of_tables {
    pagebreak(weak: true)
    heading(level: 1, numbering: none, list_tables_name_str)
    outline(
      title: none,
      target: figure.where(kind: table)
    )
  }

  if list_of_quadres {
    pagebreak(weak: true)
    heading(level: 1, numbering: none, list_quadre_name_str)
    outline(
      title: none,
      target: figure.where(kind: "quadre")
    )
  }

  if list_of_algorithms {
    pagebreak(weak: true)
    heading(level: 1, numbering: none, list_algorithm_name_str)
    outline(
      title: none,
      target: figure.where(kind: "algorithm")
    )
  }

  pagebreak(to: "odd", weak: true)
  set page(
    numbering: "1",
  )
  counter(page).update(1)

  body // Contenido principal del documento

  // Documentación de bibliografía:
  // Para incluir la bibliografía, el usuario debe llamar a #bibliography("references.bib") 
  // (o el nombre del archivo correspondiente) al final de su documento principal.
}