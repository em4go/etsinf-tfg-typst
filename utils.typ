/// Check whether this is an empty page.
// #let is-page-empty() = {
//   let page-num = here().page()
//   query(selector.or(<ep-start>, <ep-end>))
//     .chunks(2)
//     .any(((start, end)) => {
//       start.location().page() < page-num and page-num < end.location().page()
//     })
// }

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
  
  let keywords_list = if type(keywords) == str {
    keywords.split(",").map(s => s.trim())
  } else if type(keywords) == array {
    keywords
  } else {
    (keywords,)
  }
  
  let keywords_text = if type(keywords_list) == array {
    keywords_list.join(", ")
  } else {
    str(keywords_list)
  }
  
  [
    #align(right)[
      #text(size: 2em)[#abstract_str]
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

// Function to create a quadre (table-like figure)
#let quadre(caption: none, body, lang: "es") = {
  let strings = (
    "ca": "Quadre",
    "es": "Cuadro",
    "en": "Quadre"
  )
  let supplement = strings.at(lang, default: "Cuadro")
  figure(
    kind: "quadre",
    supplement: supplement,
    caption: caption,
    body
  )
}

// Function to create an algorithm (table-like figure with specific layout)
#let algorithm(caption: none, body, lang: "es") = {
  let strings = (
    "ca": "Algorisme",
    "es": "Algoritmo",
    "en": "Algorithm"
  )
  let supplement = strings.at(lang, default: "Algoritmo")
  
  // LaTeX format: ruled (\hrulefill\par#1#2#3\vspace{-.5\baselineskip}\hrulefill)
  // We can simulate this with a block and lines
  block(width: 100%, breakable: true)[
    #line(length: 100%, stroke: 0.5pt)
    #v(-0.5em)
    #figure(
      kind: "algorithm",
      supplement: supplement,
      caption: caption,
      // The body will be between lines
      align(left, body)
    )
    #v(-0.5em)
    #line(length: 100%, stroke: 0.5pt)
  ]
}
