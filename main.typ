#import "lib.typ": tfgetsinf_template
#import "utils.typ": quadre, algorithm, tfgetsinf_table
#import table: *

#show: tfgetsinf_template.with(
  lang: "es",
  list_of_tables: true,
  list_of_figures: true,
  list_of_quadres: false,
  list_of_algorithms: true,
  title: "Introducción a las Redes Neuronales Artificiales: Fundamentos y Aplicaciones",
  author: "Ernesto Martínez Gómez",
  tutor: "Fernando Martínez Gómez",
  tutor2: "Imad Rifai",
  course: "2025/2026",
  abstract_es: [
    Las redes neuronales artificiales han revolucionado el campo del aprendizaje automático en las últimas décadas. Este trabajo presenta una introducción completa a los fundamentos teóricos de las redes neuronales, desde el perceptrón simple hasta arquitecturas complejas como redes convolucionales y recurrentes. Se analizan los principales algoritmos de entrenamiento, funciones de activación y técnicas de regularización. Además, se exploran aplicaciones prácticas en diversos dominios como visión por computador, procesamiento de lenguaje natural y sistemas recomendadores. El objetivo es proporcionar una base sólida para comprender el funcionamiento interno de estas herramientas omnipresentes en la inteligencia artificial moderna.
  ],
  abstract_cat: [
    Les xarxes neuronals artificials han revolucionat el camp de l'aprenentatge automàtic en les últimes dècades. Aquest treball presenta una introducció completa als fonaments teòrics de les xarxes neuronals, des del perceptró simple fins a arquitectures complexes com xarxes convolucionals i recurrents. S'analitzen els principals algorismes d'entrenament, funcions d'activació i tècniques de regularització. A més, s'exploren aplicacions pràctiques en diversos dominis com visió per computador, processament del llenguatge natural i sistemes recomanadors. L'objectiu és proporcionar una base sòlida per a comprendre el funcionament intern d'aquestes eines omnipresents en la intel·ligència artificial moderna.
  ],
  abstract_en: [
    Artificial neural networks have revolutionized the field of machine learning in recent decades. This work presents a comprehensive introduction to the theoretical foundations of neural networks, from the simple perceptron to complex architectures such as convolutional and recurrent networks. The main training algorithms, activation functions, and regularization techniques are analyzed. Furthermore, practical applications in various domains such as computer vision, natural language processing, and recommender systems are explored. The goal is to provide a solid foundation for understanding the internal workings of these ubiquitous tools in modern artificial intelligence.
  ],
  keywords_es: "Redes Neuronales, Aprendizaje Profundo, Perceptrón, Backpropagation, CNN, RNN, Inteligencia Artificial, Machine Learning",
  keywords_cat: "Xarxes Neuronals, Aprenentatge Profund, Perceptró, Backpropagation, CNN, RNN, Intel·ligència Artificial, Machine Learning",
  keywords_en: "Neural Networks, Deep Learning, Perceptron, Backpropagation, CNN, RNN, Artificial Intelligence, Machine Learning",
)

= Introducción

Las redes neuronales artificiales representan uno de los paradigmas más importantes en el campo de la inteligencia artificial y el aprendizaje automático. Inspiradas en la estructura biológica del cerebro humano, estas redes están compuestas por unidades de procesamiento interconectadas que pueden aprender patrones complejos a partir de datos.

El objetivo de este trabajo es proporcionar una introducción accesible pero rigurosa a los fundamentos de las redes neuronales, desde los conceptos más básicos hasta las arquitecturas más avanzadas utilizadas en la actualidad.

== Motivación y Contexto

En los últimos años, hemos presenciado un avance extraordinario en las capacidades de los sistemas de inteligencia artificial. Desde el reconocimiento de imágenes que supera la capacidad humana hasta modelos de lenguaje que pueden generar texto coherente, las redes neuronales están en el centro de estas innovaciones.

== Objetivos

Los principales objetivos de este trabajo son:

- Comprender los fundamentos matemáticos de las redes neuronales
- Analizar diferentes arquitecturas y sus aplicaciones
- Estudiar los algoritmos de entrenamiento
- Explorar técnicas de regularización y optimización

= Fundamentos Teóricos

== El Perceptrón

El perceptrón, introducido por Frank Rosenblatt en 1958, es la unidad fundamental de una red neuronal. Es un algoritmo de clasificación binaria que aprende un hiperplano de separación óptimo.

=== Modelo Matemático

La salida de un perceptrón se calcula mediante la siguiente función:

$
  y = f( sum_(i=1)^n w_i x_i + b ) = f( bold(w)^top bold(x) + b )
$

donde $bold(w)$ representa los pesos, $bold(x)$ las entradas, $b$ el sesgo, y $f$ la función de activación.

=== Funciones de Activación

Las funciones de activación introducen no linealidades en la red, permitiendo aprender patrones complejos. Las más comunes son:

#figure(
  supplement: "Tabla",
  caption: "Funciones de activación más utilizadas en redes neuronales",
)[
  #table(
    columns: (1fr, 2fr, 2fr),
    stroke: 0.5pt,
    [Nombre], [Definición], [Rango],
    [Sigmoide], $sigma(x) = 1/(1 + e^(-x))$, $(0, 1)$,
    [Tanh], $tanh(x) = (e^x - e^(-x))/(e^x + e^(-x))$, $(-1, 1)$,
    [ReLU], $"ReLU"(x) = max(0, x)$, $[0, +infinity)$,
    [Leaky ReLU], $f(x) = max(alpha x, x)$, $(-infinity, +infinity)$,
  )
]

== Redes Multicapa (MLP)

Una red neuronal multicapa (Multi-Layer Perceptron) consiste en múltiples capas de perceptrones organizados de forma jerárquica.

=== Arquitectura

#quadre(
  lang: "es",
  caption: [Arquitectura típica de una red neuronal multicapa],
)[
  #align(center)[
    #stack(dir: ltr, spacing: 2em,
      // Input layer
      stack(dir: ttb, spacing: 1em,
        circle(radius: 0.4cm, fill: rgb("#E8F4FD")),
        circle(radius: 0.4cm, fill: rgb("#E8F4FD")),
        circle(radius: 0.4cm, fill: rgb("#E8F4FD")),
      ),
      // Hidden layer
      stack(dir: ttb, spacing: 0.8em,
        circle(radius: 0.4cm, fill: rgb("#FFE4CC")),
        circle(radius: 0.4cm, fill: rgb("#FFE4CC")),
        circle(radius: 0.4cm, fill: rgb("#FFE4CC")),
        circle(radius: 0.4cm, fill: rgb("#FFE4CC")),
      ),
      // Output layer
      stack(dir: ttb, spacing: 1.5em,
        circle(radius: 0.4cm, fill: rgb("#E8F8E8")),
        circle(radius: 0.4cm, fill: rgb("#E8F8E8")),
      ),
    )
    
    #v(0.5em)
    
    #stack(dir: ltr, spacing: 3.5em,
      [Capa de entrada],
      [Capa oculta],
      [Capa de salida],
    )
  ]
]

=== Algoritmo de Retropropagación

El algoritmo de retropropagación (_backpropagation_) es el método fundamental para entrenar redes neuronales multicapa. Se basa en la regla de la cadena del cálculo diferencial para calcular gradientes de manera eficiente.

#algorithm(
  lang: "es",
  caption: [Algoritmo de Retropropagación (simplificado)],
)[
  1. *Propagación hacia adelante*: Se calculan las salidas de la red capa por capa
  2. *Cálculo del error*: Se compara la salida obtenida con la esperada
  3. *Propagación hacia atrás*: Se calculan los gradientes del error respecto a cada peso
  4. *Actualización de pesos*: Se ajustan los pesos usando gradiente descendente
]

La actualización de pesos sigue la regla del gradiente descendiente:

$
  w_(i j)^(l) := w_(i j)^(l) - eta frac(partial L, partial w_(i j)^(l))
$

donde $eta$ es la tasa de aprendizaje y $L$ es la función de pérdida.

= Arquitecturas Avanzadas

== Redes Convolucionales (CNN)

Las redes neuronales convolucionales (CNN) están especialmente diseñadas para procesar datos con estructura de cuadrícula, como imágenes.

=== Operación de Convolución

$
  (I * K)(i, j) = sum_m sum_n I(i+m, j+n) dot K(m, n)
$

donde $I$ es la imagen de entrada y $K$ es el kernel o filtro.

=== Componentes Principales

#quadre(
  lang: "es",
  caption: [Componentes principales de una CNN],
)[
  #table(
    columns: (1fr, 3fr),
    stroke: 0.5pt,
    [Capa convolucional], [Aplica filtros para detectar características locales],
    [Capa de pooling], [Reduce la dimensionalidad espacial],
    [Capa fully-connected], [Conecta todas las neuronas para la clasificación final],
  )
]

La operación de convolución en 2D se define como:

$
  (I * K)(i, j) = sum_m sum_n I(i+m, j+n) dot K(m, n)
$

donde $I$ es la imagen de entrada y $K$ es el kernel o filtro.

== Redes Recurrentes (RNN)

Las redes neuronales recurrentes están diseñadas para procesar secuencias de datos, como series temporales o texto.

=== Estructura Recurrente

En una RNN, la salida en un paso de tiempo depende tanto de la entrada actual como del estado oculto anterior:

$
  bold(h)_t = f(bold(W)_(h h) bold(h)_(t-1) + bold(W)_(x h) bold(x)_t + bold(b)_h)
$

$
  bold(y)_t = g(bold(W)_(h y) bold(h)_t + bold(b)_y)
$

=== Variantes Modernas

Para abordar el problema del desvanecimiento del gradiente en secuencias largas, se han desarrollado arquitecturas como:

- *LSTM* (Long Short-Term Memory): Utiliza compuertas de olvido, entrada y salida
- *GRU* (Gated Recurrent Unit): Simplificación del LSTM con menos parámetros

= Aplicaciones Prácticas

Las redes neuronales han encontrado aplicaciones en prácticamente todos los campos de la tecnología moderna.

== Visión por Computador

#figure(
  supplement: "Figura",
  caption: "Aplicaciones de redes neuronales en visión por computador",
)[
  #image("logo-etsinf.svg", width: 5cm)
]

Algunas aplicaciones destacadas incluyen:

- Detección y reconocimiento de objetos
- Segmentación semántica de imágenes
- Reconocimiento facial
- Conducción autónoma

== Procesamiento de Lenguaje Natural

Las redes neuronales han transformado el procesamiento del lenguaje natural:

#quadre(
  lang: "es",
  caption: [Aplicaciones de NLP basadas en redes neuronales],
)[
  #table(
    columns: (1fr, 2fr, 2fr),
    stroke: 0.5pt,
    [Tarea], [Descripción], [Arquitectura],
    [Traducción automática], [Traducir texto entre idiomas], [Transformer],
    [Análisis de sentimiento], [Clasificar polaridad emocional], [RNN, BERT],
    [Generación de texto], [Crear contenido coherente], [GPT, T5],
    [Respuesta a preguntas], [Sistemas de Q\&A], [BERT, RoBERTa],
  )
]

= Técnicas de Regularización

Para evitar el sobreajuste en redes neuronales profundas, se utilizan diversas técnicas de regularización.

== Dropout

El dropout desactiva aleatoriamente neuronas durante el entrenamiento:

$
  y = f(bold(W) dot "dropout"(bold(x), p) + bold(b))
$

donde $p$ es la probabilidad de desactivar una neurona.

== Normalización por Lotes (Batch Normalization)

Normaliza las activaciones de cada capa:

$
  hat(x)_i = frac(x_i - mu_B, sqrt(sigma_B^2 + epsilon))
$

$
  y_i = gamma hat(x)_i + beta
$

= Conclusiones

Las redes neuronales artificiales representan una de las herramientas más poderosas en el arsenal de la inteligencia artificial moderna. Desde sus humildes comienzos con el perceptrón simple hasta las sofisticadas arquitecturas actuales como Transformers y GANs, estas redes han demostrado una capacidad extraordinaria para aprender representaciones complejas de datos.

Los principales puntos clave de este trabajo son:

1. Los fundamentos matemáticos del perceptrón y la retropropagación siguen siendo relevantes hoy en día
2. Diferentes arquitecturas están diseñadas para diferentes tipos de datos y problemas
3. Las técnicas de regularización son esenciales para redes profundas
4. Las aplicaciones prácticas abarcan desde la visión por computador hasta el procesamiento del lenguaje natural

El campo continúa evolucionando rápidamente, con nuevas arquitecturas y técnicas emergiendo constantemente. La comprensión de estos fundamentos proporciona una base sólida para seguir los avances futuros en este campo fascinante.

= Trabajo Futuro

Como líneas de trabajo futuro, se podrían explorar:

- Implementación práctica de las arquitecturas descritas utilizando frameworks modernos como PyTorch o TensorFlow
- Estudio de arquitecturas más recientes como Vision Transformers (ViT) y modelos de difusión
- Análisis de las implicaciones éticas y sociales de los sistemas de inteligencia artificial basados en redes neuronales
- Optimización de redes neuronales para dispositivos con recursos limitados (_edge computing_)

#tfgetsinf_table(
  caption: [Best obtained results for each neural family],
  columns: 3,
  hline(),
  [*Family*], [*Binary*], [*Multiclass*],
  hline(),
  [Feed-Forward], [0.65], [0.19],
  [CNN], [0.57], [0.18],
  [RNN], [*0.70*], [*0.26*],
  [TDNN], [0.69], [*0.26*],
  hline()
)