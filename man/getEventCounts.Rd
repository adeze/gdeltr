\name{getEventCounts}
\alias{getEventCounts}
\title{Get event counts per country-month from GDELT}
\usage{
getEventCounts(countryname, eventtype = "root", min.date = 20000101)
}
\arguments{
  \item{country.name}{A normal English country name
  (character) \code{country.name}}

  \item{eventtype}{What event code resolution?  Options:
  "code", "base", "root", "quad". \code{eventtype}}

  \item{min.date}{Furthest date back you want (numeric).
  \code{min.date}}
}
\value{
df A data frame counts per event per month in the country
}
\description{
By default, this goes back to Jan 1 2000, but you can
change it. Inputs must be characters. Requires the
\code{countrycode} package to translate from country name
to FIPS104. Assumes you have GDELT in a dplyr tble in
tables called "hist.db" and "daily.db".  I have them in a
SQLite database, but dplyr will let you use whatever you
want.  See Hadley Wickham's github page.
}
\details{
Reverted to a prev. version.  No pre-build scaffolding to
get all of the columns.
}
\examples{
mex.protest <- getEventCounts("Mexico", eventtype="root", min.date==20000101)
}
\keyword{GDELT,}
\keyword{gdeltr}

