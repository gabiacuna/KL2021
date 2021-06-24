install.packages("dplyr")
install.packages("rio")
install.packages("PerformanceAnalytics")
install.packages("corrplot")
install.packages("caret")
install.packages("tidyverse")
install.packages("car")
install.packages("ggplot2")
library(dplyr)
library(rio)
library(PerformanceAnalytics)
library(corrplot)
library(caret)
library(tidyverse)
library(car)
library(ggplot2)

# Cambiar el nombre y eliminar el identificador
base<-Logistica[,-1]

#Convertir la variable tipo en 1 y 0
#Graficar un regresi?n lineal con la nueva variable Y

#base$Tipo <- ifelse(base$Tipo=="Si",1,0)
#base %>% ggplot(aes(x=X1,y=Tipo1))+
#  geom_point(aes(col=base$Tipo))+
#  geom_smooth(method = "lm")

#Explorar la data

#Estructura de la base
str(base)

# Resumen de la base
summary(base)

#Determinar la existencia de valores perdidos 
sum(is.na(base))

####### Visualizar la base #########

# Correlaci?n

#Extraer las variables num?ricas
basenumerica <- unlist(lapply(base, is.numeric))
head(basenumerica)
basenum <- base[ , basenumerica]
head(basenum)

#Gr?fico de correlaci?n y distribuci?n de cada variable num?rica
chart.Correlation(basenum,histogram = TRUE, pch = 19)

# Gr?fico de la variable Respuesta

bar <- table(base$Tipo)
par(mfrow = c(1,1))
barplot(bar, xlab = "Asignación de recursos")

######## Crear la varible respuesta ###########

base$Tipo <- ifelse(base$Tipo=="Si",1,0)
head(base$Tipo)

# Dividir la base para entrenar, 80% de los datos para entrenamiento
#seleccion aleatoria!
# Entrenamiento
entr = subset(base)
trainbase <- sample_frac(entr, 0.8)
dim(trainbase)

# Prueba
sid <- as.numeric(rownames(trainbase))
testbase <- entr[-sid,]
dim(testbase)

############## Modelo ##################

  #Modelo saturado
  modelo1 <- glm(Tipo ~ ., data = trainbase, family = "binomial")#Modelo lineal generalizado - gml
  summary(modelo1)  #Los p-values dan distinto ya que las muestras son aleatorias

# Remover las variables no significativas

modelo2 <- glm(Tipo ~ X1 + X3 + X6 + X8 +0, 
            data = trainbase, family = "binomial")
summary(modelo2)

# Remover las variables no significativas para el modelo final

modelo3 <- glm(Tipo ~   X3 + X6 + X8 +0, 
               data = trainbase, family = "binomial")
summary(modelo3)



############ Verificaci?n del modelo ###############

plot(modelo3)

plot(Tipo ~ X3 + X6 + X8 +0 , data = trainbase, pch = 20)


# Multicolinealidad

base1 <- trainbase[c(4,7,9)] # Se crea una base con las variables finales del modelo
head(base1)

basecor <- cor(base1) # Matriz de correlaciones
corrplot(basecor, method = "number") # Gr?fico de la matriz de correlaciones

# Cuando no hay intercepto no es bueno leer el VIF
vif(modelo3)


# Gr?ficos del modelo

ggplot(trainbase, aes(x = X3, y = Tipo)) + geom_point() +
stat_smooth(method = "glm", method.args = list(family = "binomial"),
            se = FALSE)
ggplot(trainbase, aes(x = X6, y = Tipo)) + geom_point() +
  stat_smooth(method = "glm", method.args = list(family = "binomial"),
              se = FALSE)
ggplot(trainbase, aes(x = X8, y = Tipo)) + geom_point() +
  stat_smooth(method = "glm", method.args = list(family = "binomial"),
              se = FALSE)

########## Matriz de confusi?n #############

pred_prob = predict(modelo3, trainbase, type = "response")
pred_valores = 1 * (pred_prob > 0.5)
actual_valor = trainbase$Tipo
matriz_confu = table(actual_valor, pred_valores)
matriz_confu

tasa_mal = 1 - sum(diag(matriz_confu))/sum(matriz_confu)
tasa_mal

library("pROC")
test_prob <- predict(modelo3, newdata = testbase, type = "response")
test_roc <- roc(testbase$Tipo ~ test_prob, plot = TRUE, print.auc = TRUE)


