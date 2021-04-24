# 17-05-2020
# Scandinavian Comparison

# Reading in our covid dataset
url <- 'https://covid.ourworldindata.org/data/owid-covid-data.csv'
download.file(url, destfile = 'Coronavirus.csv')
df <- read.csv('Coronavirus.csv')


# Creating seperate dataframes for each country
FL <- data.frame(df$date[df$location=='Finland'],
                 df$new_cases_per_million[df$location=='Finland'])
SW <- data.frame(df$date[df$location=='Sweden'],
                 df$new_cases_per_million[df$location=='Sweden'])
NW <- data.frame(df$date[df$location=='Norway'],
                 df$new_cases_per_million[df$location=='Norway'])
DK <- data.frame(df$date[df$location=='Denmark'],
                 df$new_cases_per_million[df$location=='Denmark'])
IL <- data.frame(df$date[df$location=='Iceland'],
                 df$new_cases_per_million[df$location=='Iceland'])

ice <- df %>% 
  filter(location == "Iceland")

max(ice$new_cases_per_million)

# Naming the columns in our new dataframes
names(FL) <- c('date','new cases')
names(SW) <- c('date','new cases')
names(NW) <- c('date','new cases')
names(DK) <- c('date','new cases')
names(IL) <- c('date','new cases')

# Merging our dataframes
merged_df <- merge(FL,SW, by='date')
merged_df <- merge(merged_df, NW, by='date')
names(merged_df) <- c('date','FL','SW','NW')

merged_df <- merge(merged_df, DK, by='date')
merged_df <- merge(merged_df,IL, by='date')
names(merged_df) <- c('date','FL','SW','NW','DK','IL')

# Melting our dataframe
melted_df <- reshape2::melt(merged_df,id.var='date')
head(melted_df)

# Plotting the daily new cases (per million) in Scandinavia
SP <- ggplot(melted_df, aes(x=as.Date(date),y=value,col=variable)) +
  geom_point()+
  geom_line()

SP

library(ggsci)
# Recolouring our graph
CSP <- SP + scale_color_manual(values=c('#002F6C','#FFCD00','#666666','#C7042d','#02529C'))
CSP

# Removing Iceland, as it appears to be an outlier, and as it is also, 
# geographically speaking, an outliear

updated_df <- merge(FL,SW, by='date')
updated_df <- merge(updated_df, NW, by='date')
names(updated_df) <- c('date','FL','SW','NW')
updated_df <- merge(updated_df, DK, by='date')
names(updated_df) <- c('date','FL','SW','NW','DK')

# Merging our df
melted_updated <- reshape2::melt(updated_df,id.var='date')
head(melted_updated)

# Plotting our updated scandinavian dataframe
USP <- ggplot(melted_updated, aes(x=as.Date(date),y=value,col=variable)) +
  geom_line()+
  geom_point() +
  labs(y='Daily New Cases (per million)',
       x='Date')+
  ggtitle('Daily New Cases (per million) across Scandinavia')

# Adding Color
CUSP <- USP + 
  scale_color_manual('Country', values = c('#f8b195','#355c7d','#c06c84','#6c5b76'))
CUSP




