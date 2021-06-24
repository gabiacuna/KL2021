# Cambiar el nombre de la base para comodidad en el trabajo
base<-datosClase1
str(base)
summary(base)
pairs(base)# Matriz con gr?ficos de dispersi?n de todas las variables

#Recta de regresi?n
regresion <- lm(Grasas ~ Edad, data = base)
summary(regresion)

#ANOVA
anova(regresion)

# Recta estimada
plot(base$Edad, base$Grasas, xlab='Edad', ylab='Grasas')
abline(regresion)

#Análisis de los residuales

install.packages('ggplot2')
library(ggplot2)

# Gr?fico residuos estudentizados frente a valores ajustados por el modelo
ggplot(data = base, aes(x = predict(regresion), 
                        y = abs(rstudent(regresion))))+
  geom_hline(yintercept = 3, color = "grey", linetype = "dashed")+
  # se identifican en rojo las observaciones con residuos estandarizados absolutos > 3
  geom_point(aes(color = ifelse(abs(rstudent(regresion)) > 3, "red", "black")))+
  scale_color_identity()+
  labs(title = "Distribuci?n de los residuos estudentizados", 
       x = "Predicci?n modelo", 
       y = "Residuos estudentizados")+
  theme_bw() + theme(plot.title = element_text(hjust = 0.5))

# Detecci?n de los residuos estudentizados > 3 considerados como outliers
which(rstudent(regresion) > 3)

install.packages("car")
library(car)
outlierTest(regresion)

# Test de hip?tesis para el an?lisis de normalidad de los residuos
shapiro.test(regresion$residuals)


# Test de contraste de homocedasticidad Breusch-Pagan
library(lmtest)
bptest(regresion)

# Matriz de correlaci?n entre predictors 
round(cor(subset(base, select = -Grasas), method = "pearson"), digits = 3)

install.packages("corrplot")
require(corrplot)
corrplot(round(cor(subset(base)), digits = 3), type = "lower")

#Estimaci?n del modelo de Regresi?n Lineal M?ltiple
regresion2 <- lm(Grasas ~ . , data = base)
summary(regresion2)

step(regresion2, direction = "both", trace = 1)
confint(regresion2)

plot(regresion2)

# Detecci?n y visualizaci?n de observaciones influyentes
require(car)
influencePlot(regresion2)

# Gr?fico residuos estudentizados frente a valores ajustados por el modelo
ggplot(data = base, aes(x = predict(regresion2), 
                        y = abs(rstudent(regresion2))))+
  geom_hline(yintercept = 3, color = "grey", linetype = "dashed")+
  # se identifican en rojo las observaciones con residuos estandarizados absolutos > 3
  geom_point(aes(color = ifelse(abs(rstudent(regresion2)) > 3, "red", "black")))+
  scale_color_identity()+
  labs(title = "Distribuci?n de los residuos estudentizados", 
       x = "Predicci?n modelo", 
       y = "Residuos estudentizados")+
  theme_bw() + theme(plot.title = element_text(hjust = 0.5))


# Detecci?n de los residuos estudentizados > 3 considerados como outliers
which(rstudent(regresion2) > 3)

outlierTest(regresion2)

# Test de hip?tesis para el an?lisis de normalidad de los residuos
shapiro.test(regresion2$residuals)

# Test de contraste de homocedasticidad Breusch-Pagan
library(lmtest)
bptest(regresion2)

library(dplyr)

corrplot(cor(select(base, Edad, Peso)), method = "number", type = "lower")

# Factores de inflaci?n de la varianza
vif(regresion2)
