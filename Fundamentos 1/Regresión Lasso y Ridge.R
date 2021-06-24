#Paquetes
install.packages("glmnet")
library(glmnet)
library(dplyr)
library(tidyr)
library(ggplot2)
library(scales)
#########################################################################
# Cambio de nombre
datos<-Clase_3

########### Regresi?n Lasso #############

# Dividir los datos en 75% para entrenar y 25 % de prueba
base <- sample(1:nrow(datos), size = 0.75*nrow(datos), replace = FALSE)
datos_train <- datos[base, ]
datos_test  <- datos[-base, ]

# Crear matrices de entrenamiento y prueba

x_train <- model.matrix(Y~., data = datos_train)[, -1] # Covariables
y_train <- datos_train$Y # Variable Dependiente

x_test <- model.matrix(Y~., data = datos_test)[, -1]
y_test <- datos_test$Y

# Creación y entrenamiento del modelo

modelo <- glmnet(
  x           = x_train,
  y           = y_train,
  alpha       = 1,
  nlambda     = 100,
  standardize = TRUE
)


# Evolución de los coeficientes en función de lambda

regularizacion <- modelo$beta %>% 
  as.matrix() %>%
  t() %>% 
  as_tibble() %>%
  mutate(lambda = modelo$lambda)

regularizacion <- regularizacion %>%
  pivot_longer(
    cols = !lambda, 
    names_to = "predictor",
    values_to = "coeficientes"
  )

regularizacion %>%
  ggplot(aes(x = lambda, y = coeficientes, color = predictor)) +
  geom_line() +
  scale_x_log10(
    breaks = trans_breaks("log10", function(x) 10^x),
    labels = trans_format("log10", math_format(10^.x))
  ) +
  labs(title = "Coeficientes del modelo en función de la regularización") +
  theme_bw() +
  theme(legend.position = "none")


# Evolución del error en función de lambda

cv_error <- cv.glmnet(
  x      = x_train,
  y      = y_train,
  alpha  = 1,
  nfolds = 10, # Se puede dejar tan grande como la muestra
  type.measure = "mse",
  standardize  = TRUE
)
plot(cv_error)

paste("Lambda encontrado:", cv_error$lambda.min)

# Mejor valor lambda encontrado + 1sd

# Mayor valor de lambda con el que el test-error no se aleja más de 1sd del mínimo.
paste("Lambda óptimo + 1 desviaci?n estándar:", cv_error$lambda.1se)

# Modelo usando lambda ?ptimo + 1sd

modelo <- glmnet(
  x           = x_train,
  y           = y_train,
  alpha       = 1, # Para la regresi?n Lasso
  lambda      = cv_error$lambda.1se,
  standardize = TRUE
)


# Coeficientes del modelo

df_coeficientes <- coef(modelo) %>%
  as.matrix() %>%
  as_tibble(rownames = "predictor") %>%
  rename(coeficiente = s0)

df_coeficientes %>%
  filter(predictor != "(Intercept)") %>%
  ggplot(aes(x = predictor, y = coeficiente)) +
  geom_col() +
  labs(title = "Coeficientes del modelo Lasso") +
  theme_bw() +
  theme(axis.text.x = element_text(size = 6, angle = 45))

df_coeficientes %>%
  filter(
    predictor != "(Intercept)",
    coeficiente != 0
  ) 

# Predicciones de entrenamiento

predicciones_train <- predict(modelo, newx = x_train)
predicciones_train

# MSE de entrenamiento
training_mse <- mean((predicciones_train - y_train)^2)
paste("Error (mse) de entrenamiento:", training_mse)

# Predicciones de test

predicciones_test <- predict(modelo, newx = x_test)
predicciones_test

# MSE de test
test_mse_lasso <- mean((predicciones_test - y_test)^2)
paste("Error (mse) de test:", test_mse_lasso)

#######################################################################
######### Regresión Ridge##############################################

# Matrices de entrenamiento y prueba

# Crear matrices de entrenamiento y prueba

x_train <- model.matrix(Y~., data = datos_train)[, -1] # Covariables
y_train <- datos_train$Y # Variable Dependiente

x_test <- model.matrix(Y~., data = datos_test)[, -1]
y_test <- datos_test$Y

# Creaci?n y entrenamiento del modelo
modelo <- glmnet(
  x           = x_train,
  y           = y_train,
  alpha       = 0,
  nlambda     = 100,
  standardize = TRUE
)

# Evoluci?n de los coeficientes en funci?n de lambda

regularizacion <- modelo$beta %>% 
  as.matrix() %>%
  t() %>% 
  as_tibble() %>%
  mutate(lambda = modelo$lambda)

regularizacion <- regularizacion %>%
  pivot_longer(
    cols = !lambda, 
    names_to = "predictor",
    values_to = "coeficientes"
  )

regularizacion %>%
  ggplot(aes(x = lambda, y = coeficientes, color = predictor)) +
  geom_line() +
  scale_x_log10(
    breaks = trans_breaks("log10", function(x) 10^x),
    labels = trans_format("log10", math_format(10^.x))
  ) +
  labs(title = "Coeficientes del modelo en funci?n de la regularizaci?n") +
  theme_bw() +
  theme(legend.position = "none")

# Evoluci?n del error en funci?n de lambda
cv_error <- cv.glmnet(
  x      = x_train,
  y      = y_train,
  alpha  = 0,
  nfolds = 10,
  type.measure = "mse",
  standardize  = TRUE
)

plot(cv_error)

# Mejor valor lambda encontrado
paste("Lambda encontrado:", cv_error$lambda.min)
# Lambda encontrado + 1sd
# Mayor valor de lambda con el que el test-error no se aleja m?s de 1sd del m?nimo.
paste("Mejor valor de lambda encontrado + 1 desviaci?n est?ndar:", cv_error$lambda.1se)

# Mejor modelo lambda ?ptimo + 1sd

modelo <- glmnet(
  x           = x_train,
  y           = y_train,
  alpha       = 0,
  lambda      = cv_error$lambda.1se,
  standardize = TRUE
)

# Coeficientes del modelo

df_coeficientes <- coef(modelo) %>%
  as.matrix() %>%
  as_tibble(rownames = "predictor") %>%
  rename(coeficiente = s0)

df_coeficientes %>%
  filter(predictor != "(Intercept)") %>%
  ggplot(aes(x = predictor, y = coeficiente)) +
  geom_col() +
  labs(title = "Coeficientes del modelo Ridge") +
  theme_bw() +
  theme(axis.text.x = element_text(size = 6, angle = 45))

# Predicciones de entrenamiento
predicciones_train <- predict(modelo, newx = x_train)

# MSE de entrenamiento
training_mse <- mean((predicciones_train - y_train)^2)
paste("Error (mse) de entrenamiento:", training_mse)

# Predicciones de test
predicciones_test <- predict(modelo, newx = x_test)

# MSE de test
test_mse_ridge <- mean((predicciones_test - y_test)^2)
paste("Error (mse) de test:", test_mse_ridge)
