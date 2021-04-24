# 18-05-2020
# Scandinavian Deaths per million

# Reading in our data
url <- 'https://covid.ourworldindata.org/data/owid-covid-data.csv'
download.file(url, destfile = 'Coronavirus.csv')
df <- read.csv('Coronavirus.csv')

FL <- data.frame(df$date[df$location=='Finland'],
                 df$total_deaths_per_million[df$location=='Finland'])
SW <- data.frame(df$date[df$location=='Sweden'],
                 df$total_deaths_per_million[df$location=='Sweden'])
NW <- data.frame(df$date[df$location=='Norway'],
                 df$total_deaths_per_million[df$location=='Norway'])
DK <- data.frame(df$date[df$location=='Denmark'],
                 df$total_deaths_per_million[df$location=='Denmark'])

# Naming the columns in our new dataframes
names(FL) <- c('date','total deaths')
names(SW) <- c('date','total deaths')
names(NW) <- c('date','total deaths')
names(DK) <- c('date','total deaths')

updated_df <- merge(FL,SW, by='date')
updated_df <- merge(updated_df, NW, by='date')
names(updated_df) <- c('date','FL','SW','NW')
updated_df <- merge(updated_df, DK, by='date')
names(updated_df) <- c('date','FL','SW','NW','DK')

melted_df <- reshape2::melt(updated_df, id.var='date')
head(melted_df)

SD <- ggplot(melted_df, aes(x=as.Date(date),y=value, col=variable))+
  geom_point() +
  geom_line() +
  labs(x='Date',
       y='Total Deaths (per million)')+
  ggtitle('Total Deaths (per million) across Scandinavia')

SD

# Adding some colour
CSD <- SD + 
  scale_color_manual('Country', values = c('#f8b195','#355c7d','#c06c84','#6c5b76'))
CSD


