# 17-05-2020

library(readr)
df <- read_csv("https://covid.ourworldindata.org/data/owid-covid-data.csv")
View(df)


url <- 'https://covid.ourworldindata.org/data/owid-covid-data.csv'
download.file(url, destfile = 'Coronavirus.csv')
df <- read.csv('Coronavirus.csv')