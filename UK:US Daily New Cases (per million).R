# 17-05-2020

# Plotting UK and US daily new cases

# Reading in our covid dataset
df <- read.csv('owid-covid-data.csv')

# Creating a daily new cases df for the UK and US
tpuk <- data.frame(df$date[df$location=='United Kingdom'],
                   df$new_cases_per_million[df$location=='United Kingdom'])
tpus <- data.frame(df$date[df$location=='United States'],
                   df$new_cases_per_million[df$location=='United States'])

# Naming the columns in our new dfs
names(tpuk) <- c('date','new cases')
names(tpus) <- c('date','new cases')

# Merging our two dataframes
merged_df <- merge(tpuk,tpus,by='date')
names(merged_df) <- c('date','UK','US')

# Melting our two dataframes
melted_df <- reshape2::melt(merged_df,id.var='date')
head(melted_df)

# Plotting UK and US daily new cases (per million) 
ukus <- ggplot(melted_df, aes(x=as.Date(date),y=value) +
                 geom_point()+
                 geom_line() +
                 labs(x='Date',y='Daily New Cases (per million)')

# Changing the colors               
new_ukus <- ukus +
  scale_color_manual(values=c('#f6cac9','#91a7d0'))

new_ukus
