# 14/05/2020
# Plot, deaths by country
# Adjust deaths per million
# Adjust from intial outbreak

# Plot, deaths by country
df <- read.csv('owid-covid-data.csv')
df

idf <- data.frame(Dates, T_Cases)
plot(df$date, df$total_cases)
head(idf)
preLock <- idf[idf$Dates=='2020-03-27',]

preLock <- split(idf, idf$Dates=='2020-03-27')
preLock


# UK new cases
plot(df$date[df$location=='United Kingdom'],
     df$new_cases[df$location=='United Kingdom'], add = T)
for (i in range(length(df$new_cases[df$location=='United Kingdom']))){
  lines(df$date[df$location=='United Kingdom'],
        df$new_cases[df$location=='United Kingdom'])
}

# UK total cases
plot(df$date[df$location=='United Kingdom'],
     df$total_cases[df$location=='United Kingdom'])
for (i in range(length(df$new_cases[df$location=='United Kingdom']))){
  lines(df$date[df$location=='United Kingdom'],
        df$total_cases[df$location=='United Kingdom'])
}


# US new cases
plot(df$date[df$location=='United States'],
     df$new_cases[df$location=='United States'])
for (i in range(length(df$new_cases[df$location=='United States']))){
  lines(df$date[df$location=='United States'],
        df$new_cases[df$location=='United States'])
}


# UK new cases per million
plot(df$date[df$location=='United Kingdom'],
     df$new_cases_per_million[df$location=='United Kingdom'], col='red')
for (i in range(length(df$new_cases[df$location=='United Kingdom']))){
  lines(df$date[df$location=='United Kingdom'],
        df$new_cases_per_million[df$location=='United Kingdom'])
}



# US new cases per million
plot(df$date[df$location=='United States'],
     df$new_cases_per_million[df$location=='United States'],add = T,col='#f54321')
for (i in range(length(df$new_cases[df$location=='United States']))){
  lines(df$date[df$location=='United States'],
        df$new_cases_per_million[df$location=='United States'])
}


# Using ggplot
library(ggplot2)
uk <- df[df$location=='United Kingdom',]
uknc <- ggplot(uk, aes(x = date,
                       y = new_cases_per_million)) +
  geom_point(color='#34558b') +
  geom_line(aes(group=1),color='#34558b')

uknc

us <- df[df$location=='United States',]
usnc <- ggplot(us, aes(x = date,
                       y = new_cases_per_million)) +
  geom_point() +
  geom_line(aes(group=1))

usnc

irl <- df[df$location=='Ireland',]
irlnc <- ggplot(irl, aes(x = date,
                         y = new_cases_per_million))+
  geom_point(color='#91a7d0')+
  geom_line(aes(group=1),color='#91a7d0')

irlnc


###
library(tidyverse)
# Subsetting our uk data after first detected case
first_case_uk <- uk %>% 
  subset(total_cases > 0)
first_case_uk

fcuk <- ggplot(first_case_uk, aes(x=as.Date(date), y = new_cases_per_million))+
  geom_point()
fcuk

head(first_case_uk)

plot(x=as.Date(first_case_uk$date),first_case_uk$new_cases_per_million)


###

two_countries <- data.frame(df$date[df$location=='United Kingdom'],
                              df$new_cases_per_million[df$location=='United Kingdom'],
                              df$new_cases_per_million[df$location=='United States'])
two_countries
names(two_countries) <- c('date', 'UK','US')


two_plots <- ggplot(two_countries, aes(x=as.Date(date)))+
  geom_point(aes(y = UK), color='#91a7d0', show.legend = TRUE) +
  geom_line(aes(group=1,y=UK), color='#91a7d0') +
  geom_point(aes(y = US), color='#f6cac9', show.legend = TRUE) +
  geom_line(aes(group=1,y=US),color='#f6cac9')+
  labs(x='Date',
       y='Daily New Cases Per Million',
       color='Legend') +
  theme(legend.position = c('Left','Top'))

two_plots

# Creating a daily new cases df for the UK and US
tpuk <- data.frame(df$date[df$location=='United Kingdom'],
                   df$new_cases_per_million[df$location=='United Kingdom'])
tpus <- data.frame(df$date[df$location=='United States'],
                   df$new_cases_per_million[df$location=='United States'])

# Naming the columns in our new dfs
names(tpuk) <- c('date','new cases')
names(tpus) <- c('date','new cases')

# Merging our two dataframes
merged_two_plots <- merge(tpuk,tpus,by='date')
names(merged_two_plots) <- c('date','UK','US')

# Melting our two dataframes
melted_two_plots <- reshape2::melt(merged_two_plots,id.var='date')
head(melted_two_plots)

# Plotting UK and US daily new cases (per million) 
new_two_plot <- ggplot(melted_two_plots, aes(x=as.Date(date),y=value, col=variable)) +
  geom_point()+
  geom_line()+
  labs(x='Date',
       y='Daily New Cases (per million)')
new_two_plot
