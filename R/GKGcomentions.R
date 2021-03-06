#' Given a subsetted dataframe from the Global Knowledge Graph, return a df with co-mentions.
#' 
#' This takes a GKG dataframe (or subset thereof)  returns a dataframe with all co-mentioned entities of the desired type listed on the same row.
#' This is designed for export to social network analysis software.  Run the output through \code{write.gephi} if needed.
#' New feature: uses \code{nameFixer} to standardize people names.
#'
#' @param gkg.df A subset of the Global Knowledge Graph \code{gkg.df}
#' @param type Data types to subset: "themes", "persons", "organizations", "countries", or "latlong". \code{gkg.df}
#'
#' @return countries.df A data frame containing count information.
#'
#' @keywords GDELT, gdeltr
#'
#' @export
#' 
#' @examples
#' ieds <- gkg[grep("LANDMINE", gkg$THEMES),]
#' ieds.orgs <- GKGcomentions(ieds, type="organizations")


GKGcomentions <- function(gkg.df, type) {
  if (type=="organizations" | type=="orgs"){
    if (!"ORGANIZATIONS" %in% names(gkg.df)) stop("No column named 'ORGANIZATIONS'")
    orgs <- gkg.df$ORGANIZATIONS
    if (is.factor(orgs)==TRUE){orgs <- as.character(orgs)}
    orgs <- strsplit(orgs, split=";")
    nMax <- max(sapply(orgs, length))
    orgs <- cbind(t(sapply(orgs, function(i) i[1:nMax])))
    orgs <- as.data.frame(orgs)
    return(orgs)
  }
  if (type=="themes"){
    if (!"THEMES" %in% names(gkg.df)) stop("No column named 'THEMES'")
    themes <- gkg.df$THEMES
    if (is.factor(themes)==TRUE){themes <- as.character(themes)}
    themes <- strsplit(themes, split=";")
    nMax <- max(sapply(themes, length))
    themes <- cbind(t(sapply(themes, function(i) i[1:nMax])))
    themes <- as.data.frame(themes)
    return(themes)
  }
    
  if (type=="persons"){
    if (!"PERSONS" %in% names(gkg.df)) stop("No column named 'PERSONS'")
    persons <- gkg.df$PERSONS
    if (is.factor(persons)==TRUE){persons <- as.character(persons)}
    persons <- strsplit(persons, split=";")
    nMax <- max(sapply(persons, length))
    persons <- cbind(t(sapply(persons, function(i) i[1:nMax])))
    persons <- as.data.frame(persons)
    for (i in 1:ncol(persons)){
     persons[,i] <- nameFixer(persons[,i])
    }
    return(persons)
  }
  if (type=="countries"){
    if (!"LOCATIONS" %in% names(gkg.df)) stop("No column named 'LOCATIONS'")
    countries <- gkg.df$LOCATIONS
    if (is.factor(countries)==TRUE){countries <- as.character(countries)}
    countries <- strsplit(countries, split=";")
    nMax <- max(sapply(countries, length))
    countries <- cbind(t(sapply(countries, function(i) i[1:nMax])))
    countries <- countries[,3]
    countries.df <- data.frame(row.names=1:nrow(countries))
    for (i in 1:ncol(countries)) {
      tmp <- countries[,i]
      tmp1 <- strsplit(tmp, split="#")
      tmp2 <- sapply(tmp1, "[", 3)
      countries.df <- cbind(countries.df, tmp2)
    }
    cc <- function(x) {countrycode(x, "fips104", "country.name")}
    countries.df <- as.data.frame(lapply(countries.df[,1:ncol(countries.df)],FUN = function(x) {sapply(x,FUN=cc)}))
    return(countries.df)
}
  
    if (type=="latlong"){
      if (!"LOCATIONS" %in% names(gkg.df)) stop("No column named 'LOCATIONS'")
      latlong <- gkg.df$LOCATIONS
      if (is.factor(latlong)==TRUE){latlong <- as.character(latlong)}
      latlong <- strsplit(latlong, split=";")
      nMax <- max(sapply(latlong, length))
      latlong <- cbind(t(sapply(latlong, function(i) i[1:nMax])))
      latlong <- latlong[,3]
      latlong.df <- data.frame(row.names=1:nrow(latlong))
      for (i in 1:ncol(latlong)) {
        tmp <- latlong[,i]
        tmp1 <- strsplit(tmp, split="#")
        tmp2 <- sapply(tmp1, "[", 3)
        latlong.df <- cbind(latlong.df, tmp2)
      }
    }

  
}
