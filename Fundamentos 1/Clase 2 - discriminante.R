library(MASS)   # Cargamos la libreria que contiene a  lda
data(iris)      # Cargamos los datos

#Dimensi?n de la base, 150 registros y 5 variables
dim(iris)

# Crear un data frame con las variables
datos = data.frame(iris[,1:4],clase=as.factor(iris[,5]))
head(datos)

library(ggplot2)
install.packages("ggpubr")
library(ggpubr)

plot1 <- ggplot(data = datos, aes(x = Sepal.Length)) +
  geom_density(aes(colour = clase)) + theme_bw()
plot2 <- ggplot(data = datos, aes(x = Sepal.Width)) +
  geom_density(aes(colour = clase)) + theme_bw()
plot3 <- ggplot(data = datos, aes(x = Petal.Length)) +
  geom_density(aes(colour = clase)) + theme_bw()
plot4 <- ggplot(data = datos, aes(x = Petal.Width)) +
  geom_density(aes(colour = clase)) + theme_bw()
# la funci?n grid.arrange del paquete grid.extra permite ordenar
# graficos de ggplot2
ggarrange(plot1, plot2, plot3, plot4, common.legend = TRUE, legend = "bottom")


#representaci?n de cuantiles normales de cada variable para cada especie 
for (k in 1:4) {
  j0 <- names(datos)[k]
  x0 <- seq(min(datos[, k]), max(datos[, k]), le = 50)
  for (i in 1:3) {
    i0 <- levels(datos$clase)[i]
    x <- iris[datos$clase == i0, j0]
    qqnorm(x, main = paste(i0, j0), pch = 19, col = i + 1) 
    qqline(x)
  }
}

#Contraste de normalidad Shapiro-Wilk para cada variable en cada especie
library(reshape2)
library(knitr)
library(dplyr)
datos_tidy <- melt(datos, value.name = "valor")
kable(datos_tidy %>% group_by(clase, variable) %>% summarise(p_value_Shapiro.test = round(shapiro.test(valor)$p.value,5)))

# Normalidad Multivariada
install.packages("MVN")
library(MVN)
royston_test <- mvn(data = datos[,-5], mvnTest = "royston", multivariatePlot = "qq")
royston_test$multivariateNormality
hz_test <- mvn(data = datos[,-5], mvnTest = "hz")
hz_test$multivariateNormality

# Aplicaci?n del an?lisis discriminante 
modelo_lda = lda(clase~.,datos)
modelo_lda
modelo_lda$prior  # Asi podemos ver,por ejemplo,las probabilidades a priori

predicciones <- predict(object = modelo_lda, newdata = datos[, -5])
table(datos$clase, predicciones$class, dnn = c("Clase real", "Clase predicha"))

# Visualizaci?n sobre los dos primeros ejes
iris.proy = predict(modelo_lda,datos[,1:4])$x
plot(iris.proy)
plot(iris.proy,type="n")
text(iris.proy,labels=datos$clase, col = as.numeric(datos$clase))




