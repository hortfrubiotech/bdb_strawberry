## Código para importar datos a partir de una tabla de dos columnas, calcular medias y desviación típica de cada línea, escribir estos estadísticos en una tabla y generar un diagrama de cajas en formato png.
## Instalar, si no lo tienes, el paquete data.table que usaremos más adelante (solo necesario una vez por sistema)
##install.packages("data.table")
## Cargar el paquete data.table (cada vez que se necesite, o se puede incluir como opción del sistema en R)
library("data.table")
## Importar los datos desde un archivo ".csv" en el directorio de trabajo.
data<-read.table("all_firmness_pg.csv",header=TRUE, sep=",")

## Da formato "data.table" a nuestros datos
dtd <- data.table(data)
## Agrupa las medias y sd por grupos en un formato tabla.
medias<-dtd[,list(mean=mean(VALUE),sd=sd(VALUE)),by=NAME]
## Escribe los resutlados a un archivo
capture.output(medias,file="estadistica_pg.txt")

## Rutina estadística
## Test de normalidad
## con un test Shapiro-Wilk test (si p-value > 0.05 podemos asumir normalidad)
normalidad<-shapiro.test(data[,2])
capture.output(normalidad,file="estadistica_pg.txt", append=TRUE)
## con una Kolmogorov-Smirnov test frente a una distribución normal de igual media y desviación típica que nuestros datos-
## No hay diferencias significativas con una distribución normal si p-value > 0.05
normalidad2<-ks.test(data[,2], "pnorm", mean=mean(data[,2]), sd=sd(data[,2]))
capture.output(normalidad2,file="estadistica_pg.txt", append=TRUE)

## Evaluamos ahora la homogeneidad de la varianza (donde "Y" es la variable dependiente y "A*B*C" las combinaciones de variables independientes).
## Bartlett's test
homogeneidad<-bartlett.test(VALUE ~ NAME,data)
capture.output(homogeneidad,file="estadistica_pg.txt", append=TRUE)
## Fligner's test
homogeneidad2<-fligner.test(VALUE ~ NAME, data)
capture.output(homogeneidad2,file="estadistica_pg.txt", append=TRUE)

## ANOVA
fit<- aov(VALUE~NAME, data=data)
capture.output(fit,file="estadistica_pg.txt", append=TRUE)
capture.output(summary(fit),file="estadistica_pg.txt", append=TRUE)
## Comparación múltiple por grupos
Tukey<-TukeyHSD(fit)
capture.output(Tukey,file="estadistica_pg.txt", append=TRUE)

## Rutina gráfica. 
## Crea un crea etiquetas con los nombres de las variables a representar 
xlab<-names(data[1])
ylab<-names(data[2])
## Genera un archivo png con una figura tipo diagrama de cajas usando los datos y las etiquetas que hemos creado antes.
png(filename="boxplot_pg.png")
boxplot(data$VALUE ~ data$NAME,ylab=ylab,xlab=xlab)
dev.off()

## Por hacer, faltaría mejorar las etiquetas del plot final, con nombres de variables más elaborados pero que no dependan de la etiqueta de la columna.
## También mejorar el formato del archivo de texto que va agrupando los resultados estadísticos, quizas con encabezados de sección entre test y test, además de breves instrucciones para interpretar los resutlados.
