% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/etl_extract.R
\name{etl_extract.etl_macleish}
\alias{etl_extract.etl_macleish}
\alias{etl_transform.etl_macleish}
\title{Extract weather data}
\usage{
\method{etl_extract}{etl_macleish}(obj, ...)

\method{etl_transform}{etl_macleish}(obj, ...)
}
\arguments{
\item{obj}{an \code{\link{etl}} object}

\item{...}{arguments passed to methods}
}
\description{
Retrieve data from the Macleish Field Station weather monitors
}
\examples{

macleish <- etl("macleish")
str(macleish)

\dontrun{
macleish \%>\%
  etl_extract() \%>\%
  etl_transform() \%>\%
  etl_load()
whately <- macleish \%>\%
  tbl("whately") 
orchard <- macleish \%>\%
  tbl("orchard") 
  
whately \%>\%
  summarize(N = n(), avg_temp = mean(temperature))
orchard \%>\%
  summarize(N = n(), avg_temp = mean(temperature))
  
# check data types
whately \%>\%
  glimpse()

# if using SQLite, datetimes will get converted to integers
whately <- whately \%>\%
  mutate(when_datetime = datetime(when, 'unixepoch'))
whately \%>\%
  glimpse()

# show the most recent data -- should be within the past hour
whately \%>\%
  collect() \%>\%
  tail()

# show that no time-shifting is happening
if (require(ggplot2)) {
macleish \%>\%
  tbl("whately") \%>\%
  collect() \%>\%
  mutate(when = lubridate::ymd_hms(when)) \%>\%
  filter(lubridate::year(when) == 2012 & month(when) == 12 & day(when) == 20) \%>\%
  ggplot(aes(x = when, y = temperature)) + geom_line()
}
}
}
