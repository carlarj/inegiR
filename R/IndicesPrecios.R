#' Obtener tasa de inflacion
#'
#' Obtiene tasa de inflación inter anual en porcentaje.
#' La inflación se define como el cambio porcentual en el INPC. 
#' Es un wrapper de las funciones \code{serie_inegi()} y \code{YoY()}. 
#'
#' @param token token persona emitido por el INEGI para acceder al API de indicadores.
#' @author Eduardo Flores 
#' @return Data.frame
#'
#' @examples
#' Inflacion<-inflacion_general(token)
#' @note Encoding no permite acentos en titulo de descripción
#' @export
#' 

inflacion_general<-function (token){
  #Serie de INPC general;
  s<-"http://www3.inegi.org.mx/sistemas/api/indicadores/v1//Indicador/216064/00000/es/false/xml/"
  i<-serie_inegi(s,token)
  t<-YoY(serie = i$Valores,lapso = 12,decimal = FALSE)
  d<-cbind.data.frame(Fechas=i$Fechas,Valores=t)
  return(d)
}

#' Obtener tasa de inflacion de Estudiantes
#'
#' Obtiene tasa de inflación de estudiantes, inter anual en porcentaje. Es un wrapper de las funciones Serie_Inegi() y YoY(). 
#' La metodología del índice se puede encontrar aquí: \url{http://www.enelmargen.org/2011/04/indice-de-precios-estudiantes.html}
#' Es un wrapper de las funciones \code{serie_inegi()} y \code{YoY()}. 
#'
#' @param token token persona emitido por el INEGI para acceder al API.
#' @author Eduardo Flores 
#' @return Data.frame
#'
#' @examples
#' InflacionEstudiantes<-inflacion_estudiantes(token)
#' @note Encoding no permite acentos en titulo de descripción
#' @export
#' 

inflacion_estudiantes<-function (token){
  #Series de INPC;
  s1<-serie_inegi("http://www3.inegi.org.mx/sistemas/api/indicadores/v1//Indicador/216065/00000/es/false/xml/",token)
  names(s1)<-c("s1","Fechas")
  s2<-serie_inegi("http://www3.inegi.org.mx/sistemas/api/indicadores/v1//Indicador/216066/00000/es/false/xml/",token)
  names(s2)<-c("s2","Fechas")
  s3<-serie_inegi("http://www3.inegi.org.mx/sistemas/api/indicadores/v1//Indicador/216067/00000/es/false/xml/",token)
  names(s3)<-c("s3","Fechas")
  s4<-serie_inegi("http://www3.inegi.org.mx/sistemas/api/indicadores/v1//Indicador/216068/00000/es/false/xml/",token)
  names(s4)<-c("s4","Fechas")
  s5<-serie_inegi("http://www3.inegi.org.mx/sistemas/api/indicadores/v1//Indicador/216069/00000/es/false/xml/",token)
  names(s5)<-c("s5","Fechas")
  s6<-serie_inegi("http://www3.inegi.org.mx/sistemas/api/indicadores/v1//Indicador/216070/00000/es/false/xml/",token)
  names(s6)<-c("s6","Fechas")
  s7<-serie_inegi("http://www3.inegi.org.mx/sistemas/api/indicadores/v1//Indicador/216071/00000/es/false/xml/",token)
  names(s7)<-c("s7","Fechas")
  s8<-serie_inegi("http://www3.inegi.org.mx/sistemas/api/indicadores/v1//Indicador/216072/00000/es/false/xml/",token)
  names(s8)<-c("s8","Fechas")
  
  df<-Reduce(function(...) merge(...,all=T),list(s1,s2,s3,s4,s5,s6,s7,s8))
  df$ipe<-(df$s1*0.331417)+(df$s2*0.032764)+(df$s3*0.077735)+(df$s4*0.00378)+(df$s5*0.028353177)+(df$s6*0.199190)+(df$s7*0.0606992)+(df$s8*0.266067)
  
  st<-YoY(serie = df$ipe,lapso = 12,decimal = FALSE)
  d<-cbind.data.frame(Fechas=df$Fechas,Valores=st)
  return(d)
}
#' Obtener terminos de intercambio
#'
#' Obtiene la razón de términos de intercambio para México (ToT). Es un wrapper de las funciones serie_inegi() y YoY(). 
#' La razón se define como el índice de precios de exportaciones entre el índice de precios de importaciones. 
#' Es un wrapper de las funciones \code{serie_inegi()} y \code{YoY()}. 
#'
#' @param token token personal emitido por el INEGI para acceder al API.
#' @author Eduardo Flores 
#' @return Data.frame 
#'
#' @examples
#' TerminosIntercambio<-inflacion_tot(token)
#' @note Encoding no permite acentos en titulo de descripción
#' @export
#'

inflacion_tot<-function(token)
{ #calcular terminos de intercambio (Terms-Of-Trade)
  x<-"http://www3.inegi.org.mx/sistemas/api/indicadores/v1//Indicador/37502/00000/es/false/xml/"
  m<-"http://www3.inegi.org.mx/sistemas/api/indicadores/v1//Indicador/37503/00000/es/false/xml/"
  
  x_val<-serie_inegi(x,token)
  names(x_val)<-c("x","Fechas")
  m_val<-serie_inegi(m,token)
  names(m_val)<-c("m","Fechas")
  
  df<-Reduce(function(...) merge(...,all=T),list(m_val,x_val))
  df$ToT<-df$x/df$m
  
  d<-cbind.data.frame(Fechas=df$Fechas,Valores=df$ToT)
  return(d)
}