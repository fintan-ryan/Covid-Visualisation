# 17-05-2020
# Fintan Ryan
# Comparing Irish and British Coronavirus Figures

# Loading Required Packages
library(ggplot2)

# Reading in our covid dataset
url <- 'https://covid.ourworldindata.org/data/owid-covid-data.csv'
download.file(url, destfile = 'Coronavirus.csv')
df <- read.csv('Coronavirus.csv')


#######################################################################################


# Creating dfs for both Irish and British Daily new Cases (per million)

irl <- data.frame(df$date[df$location=='Ireland'],
                  df$new_cases_per_million[df$location=='Ireland'])
head(irl)

uk <- data.frame(df$date[df$location=='United Kingdom'],
                         df$new_cases_per_million[df$location=='United Kingdom'])

# Naming the columns in our new dataframes
names(irl) <- c('date','new cases')
names(uk) <- c('date','new cases')

# Merging our two new dataframes
merged_df <- merge(irl,uk,by='date')
names(merged_df) <- c('date','Irl','UK')

# Melting our dataframe
melted_df <- reshape2::melt(merged_df,id.var='date')
head(melted_df)

# Plotting the daily new cases (per million) in both Ireland and the UK
IUK <- ggplot(melted_df, aes(x=as.Date(date),y=value, col=variable))+
  geom_point()+
  geom_line() +
  labs(x='Date',
       y='Daily New Cases (per million)')+
  ggtitle('Daily New Cases (per million) Ireland vs UK')

colouredPlot <- IUK +
  scale_color_manual(values=c('#a24ab6','#f3558f'))

colouredPlot

#######################################################################################

# Creating dfs for both Irish and British Daily new Deaths (per million)

irldeaths <- data.frame(df$date[df$location=='Ireland'],
                  df$new_deaths_per_million[df$location=='Ireland'])
head(irl)

ukdeaths <- data.frame(df$date[df$location=='United Kingdom'],
                 df$new_deaths_per_million[df$location=='United Kingdom'])

# Naming the columns in our new dataframes
names(irldeaths) <- c('date','new deaths')
names(ukdeaths) <- c('date','new deaths')

# Merging our two new dataframes
merged_nd <- merge(irldeaths,ukdeaths,by='date')
names(merged_nd) <- c('date','Irl','UK')

# Melting our dataframe
melted_nd <- reshape2::melt(merged_nd,id.var='date')
head(melted_nd)

# Plotting the daily new cases (per million) in both Ireland and the UK
IUKND <- ggplot(melted_nd, aes(x=as.Date(date),y=value, col=variable))+
  geom_point()+
  geom_line() +
  labs(x='Date',
       y='Daily New Deaths (per million)')+
  ggtitle('Daily New Deaths (per million) Ireland vs UK')

colouredND <- IUKND +
  scale_color_manual(values=c('#a24ab6','#f3558f'))

colouredND

#######################################################################################

# Creating dfs for both Irish and British Total Cases

irltc <- data.frame(df$date[df$location=='Ireland'],
                        df$total_cases[df$location=='Ireland'])
head(irl)

uktc <- data.frame(df$date[df$location=='United Kingdom'],
                       df$total_cases[df$location=='United Kingdom'])

# Naming the columns in our new dataframes
names(irltc) <- c('date','new deaths')
names(uktc) <- c('date','new deaths')

# Merging our two new dataframes
merged_tc <- merge(irltc,uktc,by='date')
names(merged_tc) <- c('date','Irl','UK')

# Melting our dataframe
melted_tc <- reshape2::melt(merged_tc,id.var='date')
head(melted_tc)

# Plotting the total cases in both Ireland and the UK
IUKTC <- ggplot(melted_tc, aes(x=as.Date(date),y=value, col=variable))+
  geom_point()+
  geom_line() +
  labs(x='Date',
       y='Total Cases')+
  ggtitle('Total Cases Ireland vs UK')

colouredTC <- IUKTC +
  scale_color_manual(values=c('#a24ab6','#f3558f'))

colouredTC

#######################################################################################

# Creating dfs for both Irish and British Total Cases per million

irltcpm <- data.frame(df$date[df$location=='Ireland'],
                    df$total_cases_per_million[df$location=='Ireland'])
head(irltcpm)

uktcpm <- data.frame(df$date[df$location=='United Kingdom'],
                   df$total_cases_per_million[df$location=='United Kingdom'])

# Naming the columns in our new dataframes
names(irltcpm) <- c('date','new deaths')
names(uktcpm) <- c('date','new deaths')

# Merging our two new dataframes
merged_tcpm <- merge(irltcpm,uktcpm,by='date')
names(merged_tcpm) <- c('date','Irl','UK')

# Melting our dataframe
melted_tcpm <- reshape2::melt(merged_tcpm,id.var='date')
head(melted_tcpm)

# Plotting the Total Cases (per million) in both Ireland and the UK
IUKTCPM <- ggplot(melted_tcpm, aes(x=as.Date(date),y=value, col=variable))+
  geom_point()+
  geom_line() +
  labs(x='Date',
       y='Total Cases (per million)')+
  ggtitle('Total Cases (per million) Ireland vs UK')

colouredTCPM <- IUKTCPM +
  scale_color_manual(values=c('#a24ab6','#f3558f'))

colouredTCPM

