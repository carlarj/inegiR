% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/Tasas.R
\name{tasa_comercio}
\alias{tasa_comercio}
\title{Obtener Tasa de Crecimiento de Comercio}
\usage{
tasa_comercio(token)
}
\arguments{
\item{token}{token personal emitido por el INEGI para acceder al API.}
}
\value{
Data.frame
}
\description{
Obtiene tasa de crecimiento del Comercio (Actividad Terciaria), por mes.
Es un wrapper de las funciones \code{serie_inegi()} y \code{YoY()}.
}
\examples{
Comercio<-tasa_comercio(token)
}
\author{
Eduardo Flores
}

