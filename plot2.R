#' Please note:
#' 
#' This script uses the pipe-operators `%>%` and `%$%` as ìmplemented in the 
#' [`dplyr`][dplyr] and [`magrittr`][magrittr] packages.
#' 
#' [dplyr]: http://cran.rstudio.com/web/packages/dplyr/vignettes/introduction.html
#' [magrittr]: http://cran.r-project.org/web/packages/magrittr/vignettes/magrittr.html



#' # Prepare the analysis

#' ## Clear workspace
rm(list=ls())

#' ## Set the working directory
setwd("/Users/herzog/GitHub/ExData_Plotting1")

#' ## Load packages
#' 
#' Install packages (if not yet installed).

if (!"dplyr" %in% installed.packages()) install.packages("dplyr")
library(dplyr)

if (!"lubridate" %in% installed.packages()) install.packages("lubridate")
library(lubridate)

if (!"magrittr" %in% installed.packages()) install.packages("magrittr")
library(magrittr)



#' # Download the data

#' Only necessary the first time. (I commented out the corresponding code.)

# urlZIP <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
# 
# if(!file.exists("data")) dir.create("data")
# 
# download.file(urlZIP, destfile = "./data/exdata_data_household_power_consumption.zip", method = "curl")
# unzip(zipfile = "./data/exdata_data_household_power_consumption.zip", exdir = "data")


#' # Load the data
dat <- 
        read.table("./data/household_power_consumption.txt", sep = ";",
                   stringsAsFactors = FALSE, header = TRUE, na.strings = "?",
                   nrows = -1) %>% # read table
        tbl_df

#' Convert date/time information and select relevant days
dat <-
        mutate(dat,
                date.time = dmy_hms(paste(Date, Time)),
                Date = dmy(Date)
                ) %>%
        filter(
               (Date == ymd("2007-02-01")) | (Date == ymd("2007-02-02"))
        )



#' # Create Plot 2
png("plot2.png")
dat %$%
        plot(date.time, Global_active_power, type = "l",
             ylab = "Global Active Power (kilowatts)",
             xlab = "")
dev.off()
