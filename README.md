# Paquete para Análisis de Letras de Canciones

Este paquete en R está diseñado para descargar, procesar y analizar letras de canciones a partir de una base de datos externa, permitiendo realizar tareas como la creación de corpus de canciones, tokenización de letras, generación de matrices de documentos-términos (DTM), y análisis de frecuencias de n-gramas. Aunque algunos ejemplos están enfocados en el género indie chileno, el paquete no se limita a este género y puede aplicarse a cualquier tipo de letra de canciones.

## Funciones Principales

### 1. `crear_corpus_de_bandas()`

Esta función crea un corpus a partir de una lista de bandas o artistas, recopilando y procesando sus canciones. El corpus resultante incluye información como títulos de canciones, artistas, álbumes y letras.

#### Parámetros:

-   `lista_bandas`: Un vector de cadenas que contiene los nombres de las bandas o artistas a procesar.

#### Retorno:

Un `data.frame` con las siguientes columnas:

-   `track_id`: Identificador único de la canción.

-   `name`: Nombre de la canción.

-   `name_lower`: Nombre de la canción en minúsculas.

-   `artist_name`: Nombre del artista o banda.

-   `artist_name_lower`: Nombre del artista o banda en minúsculas.

-   `album_name`: Nombre del álbum.

-   `album_name_lower`: Nombre del álbum en minúsculas.

-   `duration`: Duración de la canción (en segundos).

-   `updated_at`: Fecha de la última actualización de la información.

-   `lyrics_id`: Identificador único de las letras.

-   `plain_lyrics`: Letras en formato plano.

-   `synced_lyrics`: Letras sincronizadas con la música.

-   `has_plain_lyrics`: Indicador binario de si existen letras planas.

-   `has_synced_lyrics`: Indicador binario de si existen letras sincronizadas.

-   `instrumental`: Indicador binario de si la canción es instrumental.

#### Ejemplo:

```{r}
lista_bandas <- c("The Beatles", "Queen", "Pink Floyd")
corpus <- crear_corpus_de_bandas(lista_bandas)
```

### 2. `crear_corpus_literario()`

Esta función crea un objeto de tipo corpus a partir de un dataframe que contiene letras de canciones, tokeniza el texto, genera la matriz de documento-término (DTM), y calcula las frecuencias de términos, bigramas y trigramas.

#### Parámetros:

-   `dataframe`: Un dataframe que contiene las letras o textos en una columna llamada `plain_lyrics`.

-   `stopwords_extra`: Un vector opcional de palabras adicionales que se deben considerar como stopwords.

-   `bigrama_stopwords`: Lógico. Si es `TRUE`, excluye las stopwords al calcular las frecuencias de bigramas.

-   `trigrama_stopwords`: Lógico. Si es `TRUE`, excluye las stopwords al calcular las frecuencias de trigramas.

#### Retorno:

Una lista con los siguientes elementos:

-   `corpus_df`: El dataframe original con las letras.

-   `corpus`: El objeto corpus creado.

-   `tokens`: Los tokens generados a partir del corpus.

-   `stopwords`: La lista combinada de stopwords utilizadas.

-   `dtm`: La matriz de documento-termino generada a partir de los tokens.

-   `dtm_bigramas`: La matriz de documento-termino generada para los bigramas.

-   `dtm_trigramas`: La matriz de documento-termino generada para los trigramas.

-   `frecuencias`: Un dataframe con las frecuencias de los términos.

-   `frecuencias_bigramas`: Un dataframe con las frecuencias de los bigramas.

-   `frecuencias_trigramas`: Un dataframe con las frecuencias de los trigramas.

#### Ejemplo:

```{r}

lista_bandas <- c("The Beatles", "Queen", "Pink Floyd")
corpus <- crear_corpus_de_bandas(lista_bandas)
resultado <- crear_corpus_literario(corpus,
                                    stopwords_extra = c("oh", "yeah"),
                                    bigrama_stopwords = FALSE,
                                    trigrama_stopwords = FALSE
                                    )
```

## Funciones Secundarias

### 3. `importar_excel()`

Importa un archivo Excel y devuelve su contenido como un dataframe.

### 4. `exportar_excel()`

Exporta un dataframe a un archivo Excel.

## Instalación

Puedes instalar este paquete directamente desde GitHub utilizando el siguiente comando:

```{r}
devtools::install_github("exetrujillo/analisisletras")
```
