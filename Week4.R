for (i in 1:nrow(ump_data)) {
  ump_data$date[i] <- ymd(paste(ump_data$Year[i],ump_data$Month[i], ump_data$Day[i], sep = "-"))
}

ump_data |>
  filter(HPUmpire == "Marty Foster") |>
  mutate(days_off <- date - lag(date)) 

#Read in data
ump_data <- read_delim("https://www4.stat.ncsu.edu/~online/datasets/umps2012.txt",
                       delim = ">",
                       col_names = c("Year", "Month", "Day", "Home", "Away", "HPUmpire")
)

#create date column with filler values
ump_data$date <- ymd("2012-01-01")
ump_data

for (i in 1:dim(ump_data)[1]) {
  ump_data$date[i] <- ymd(paste(ump_data$Year[i],
                                ump_data$Month[i],
                                ump_data$Day[i],
                                sep = "-"))
}

ump_data |>
  filter(HPUmpire == "Marty Foster") |>
  mutate(days_off <- date - lag(date))
