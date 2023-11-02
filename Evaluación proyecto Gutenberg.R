library(tidyverse)
library(gutenbergr)
library(tidytext)
options(digits = 3)

rm (list = ls())

libros <- gutenberg_metadata

libros$gutenberg_id[str_detect(libros$title, "Pride and Prejudice")]

libros <- gutenberg_works()


libro <- gutenberg_download(1342)
pride <- libro %>% unnest_tokens(word, text, token = "words")


## Remuevo stop_words 

palabras_vacías <- stop_words

pride <- pride %>% anti_join(palabras_vacías)

## remuevo palabras con dígitos: 

pride <- pride[!str_detect(pride$word, "\\d"),]

pride %>% group_by(word) %>%count()%>%filter(n>100)%>%arrange(desc(n))


## definiendo léxicos: 

afinn <- get_sentiments("afinn")

a <- pride %>% left_join(afinn) %>% filter(value>=0) 
