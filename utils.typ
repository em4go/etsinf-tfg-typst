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
    ()
  }
  
  let keywords_text = keywords_list.join(", ")
  
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