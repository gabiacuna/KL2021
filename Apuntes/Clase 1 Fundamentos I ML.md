## Regresion lineal Simple y Multiple

\- Profe Yesid Rodriguez

### Regresión

Modelo matematico permite describir como influye una variable X sobre otra Y.
- X : Independiente
- Y : Dependiente

Obj: obtener estimaciones razonables de Y para distintos valores de X a partir de una muestra de n pasers (x, y)

==! Las variables de conteo no se pueden predecir con modelos de regresion lineal.==

### Relacion lineal
$$Y = f(x) = \beta_0 + \beta_1 \cdot X$$

* $\beta_1 > 0$ : relacion lineal positiva / directa
* $\beta_1 < 0$: relacion lineal negativa / inversa

**Medidas de **

Cambiar el nombre del dataFrame
```r
base <- regresion_simple
```
 Mestra los tipos de los datos
 ```r
> str(base)
tibble [38 × 3] (S3: tbl_df/tbl/data.frame)
 $ Peso  : num [1:38] 70 65 85 74 81 74 76 75 83 77 ...
 $ Edad  : num [1:38] 46 20 52 30 57 25 28 36 57 44 ...
 $ Grasas: num [1:38] 354 190 405 263 451 302 288 385 402 365 ...
```
 Muestra un resumen de la tabla
 ```r
> summary(base)
      Peso            Edad           Grasas     
 Min.   :62.00   Min.   :20.00   Min.   :181.0  
 1st Qu.:70.00   1st Qu.:28.50   1st Qu.:256.2  
 Median :76.50   Median :36.50   Median :305.5  
 Mean   :75.24   Mean   :39.24   Mean   :316.6  
 3rd Qu.:80.00   3rd Qu.:50.75   3rd Qu.:382.2  
 Max.   :88.00   Max.   :60.00   Max.   :451.0  
```
 Muestra unos gráficos
```r
pairs(base)
```

![](Rplot.png)
```r
> regresion<-lm(Grasas~Edad, data = base)
> summary(regresion)

Call:
lm(formula = Grasas ~ Edad, data = base)

Residuals:
   Min     1Q Median     3Q    Max 
-70.52 -31.61  -2.25  24.70  84.51 

Coefficients:
            Estimate Std. Error t value Pr(>|t|)    
(Intercept) 120.9727    24.0477   5.031 1.37e-05 ***
Edad          4.9866     0.5851   8.522 3.71e-10 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 44.1 on 36 degrees of freedom
Multiple R-squared:  0.6686,	Adjusted R-squared:  0.6594 
F-statistic: 72.63 on 1 and 36 DF,  p-value: 3.71e-10

```

Con esto decimos que 
> X es Edad y 
> Y es Grasas
> **regresion$<-$lm(VarY~VarX, data = dataFrame)**

La salida anterior nos dice que:
1. se presenta un resumen de los residualen del modelo
2. Coefficientes:
2.1 Indica la estimacion de los parámetros $\beta_0 = 120.9727$ 7 $\beta_1 = 4.9866$ 
2.2 $Pr(>|t|)$: es el p-valor asociado a la hipotesis Ho:$\beta_i=0$. Objetivo rechazar la hipostesis
Ho : $\beta_0 = 0$. Rechazar si $Pr(>|t|)<$Nivel de significancia. 0.0000137 < 0.05
\*El Pr(>|t|) sale como p-value en la última linea. 
Ho: $\beta_1=0$
3. Multiple R-squared: 0.6686, conocido como R2: indica el grado de ajuste al modelo, se busca que sea lo mas cercano a 1.

El nivel de significancia vemos si vamos a rechazar o aceptar la hipotesis. 

Recta de regresion viene en la columna 'Estimate' de la tabla 'Coefficients':
> Grasas = 120.9727 + 4.9866 Edad

Si el modelo completo sirve, el modelo debe pasar la prueba realizada por __anova__(Analysis Of Varianmce)

```r
> anova(regresion)
Analysis of Variance Table

Response: Grasas
          Df Sum Sq Mean Sq F value   Pr(>F)    
Edad       1 141212  141212  72.625 3.71e-10 ***
Residuals 36  69998    1944                     
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
```
Los codigos de signif, nos dicen que numeros rechaza el modelo?
El objetivo es rechazar la hipotesis nula: Ho : $\beta_0 = \beta_1 = 0$. 
-> esto por que trabajamos con una muestra, no con la poblacion completa
* F value: cociente de los cuadrados medios.
* P valor: probabilidad de que los valores sean mayores a F \*No estoy segura, profundizar!*

Plot de los datos:
```r
plot(base$Edad, base$Grasas, xlab='Edad', ylab='Grasas')
```

![[resPlot.png]]

Luego cono el abline(regresion) se agrega la linea de tendencia:
![[plotCLineaTend.png]]

Buscamos tratar a los outliers, para ello se intrasla el paquete `ggplot`

Luego se corre:
```r
# Gráfico residuos estudentizados frente a valores ajustados por el modelo
ggplot(data = base, aes(x = predict(regresion), 
                        y = abs(rstudent(regresion))))+
  geom_hline(yintercept = 3, color = "grey", linetype = "dashed")+
  # se identifican en rojo las observaciones con residuos estandarizados absolutos > 3
  geom_point(aes(color = ifelse(abs(rstudent(regresion)) > 3, "red", "black")))+
  scale_color_identity()+
  labs(title = "Distribución de los residuos estudentizados", 
       x = "Predicción modelo", 
       y = "Residuos estudentizados")+
  theme_bw() + theme(plot.title = element_text(hjust = 0.5))
```
![](ggplot1.png)

Con este se ven los outliers

\* con library se traen los paquetes al ambiente :3
-> paquetes ya instalados 

```r
which(rstudent(regresion) > 3)	#3 es un numero std para trabajar esto, viene de la dist normal

#por aca van las cosas con la linea car -> revisar edespues!!!
> shapiro.test(regresion$residuals)

	Shapiro-Wilk normality test

data:  regresion$residuals
W = 0.9603, p-value = 0.1942
```
shapiro test testea la hipotisis sin descartarla :)
```r
> library(lmtest)
> bptest(regresion)

	studentized Breusch-Pagan test

data:  regresion
BP = 0.37748, df = 1, p-value = 0.539

#Con lo anterior queda validada la regresion simple! :)
```

### Regresión lineal múltiple

Para regresiones con 2 o + variables.
El obj, es observar que pasa con las otras variables traidas, como afectan a la que se le esta analizando.
Vamos a buscar la siguiente estimación:
$$Y = \beta_0+\beta_1 X_1 + \beta_2 X_2 + ... + \beta_pX_p + \epsilon$$
- $\beta_j$ : efecto medio que tiene sobre Y el incremento de una unidad de $X_j$, manteniendo fijos el resto de los predictores.
- $\beta_0$ : ordenada de origen. valor esperado de Y cuando todos los otros valores son 0
- FALTA - REV PPT

Ya que tenemos una muestra, realizamos una estimacion de los valores de la ec.

Supuestos a tener en cuenta a la hora de considerar válido un modelo lineal:
1. No linealidad en los datos
Cada variable debe estar relacionada con la variable respuesta.
-> como detectarla?
Graficar los residuos en funcion de los valores del Y predicho.
2. Correlacion de los errores
Los errores no deben estar correlacionados, deben ser independientes. Si hay correlacion entre los errores puede que los p-values sean muy pequeños.
-> detectar: si al graficarlos, quedan en una linea rexta.
3. Varianza no constante de los errores (herterocedasticidad)
???
4. Outliers
Aveces no afectan mucho pero es importante tenerlos identificados.
5. Puntos de alta influencia
Puntos que son un valor inusual pueden afectar a la recta. 
6. Colinealidad
dos o mas variables $X$ estan estrechamente relacionadas entre si.
es bien pesimo tener esto, completar con ppt.
Una forma de detectarla es inspeccionar una **matriz de correlación de los predictores**, pero solo sirve para relaciones de a 2.
para multirelaciones:
$$VIF(\hat{\beta_j}) = \frac{1}{1-R^2_{X_j | X_{-j}}}$$
-> VIF = 1 (ausencia de colinealidad)
-> 1 <VIF<5 Cierta colinealidad
-> 5<VIF<10 Alta colinealidad
	Valores de referencia :3
7. Tamaño de la muestra
Si la muestra es muy pequeña elementos que no deberian afectar, lo hacen.
Se recomienda que el numero de observaciones sea en torno a 10-20 veces el numero de predictores

#### Ejemplo en R
Buscamos correlacion entre variables X, todas menos grasas. Nos importa peso y edad.
```r
> round(cor(subset(base, select = -Grasas), method = "pearson"), digits = 3)
      Peso  Edad
Peso 1.000 0.683
Edad 0.683 1.000

> require(corrplot)
> corrplot(round(cor(subset(base)), digits = 3), type = "lower")
```
El corrplot es para verlo de forma visual!.
![](corrplot1.png) 

El 1 es la relacion perfecta, el 0.683 significa la relacion entre la var peso y edad. A medida que me hacerco a los 1, hay una mayor relacion entre ellas. Se buscan valores lo mas cercanos al cero posible, para que sean independientes.
-> entre mas oscuro el color mayor relacion! (en el graph)
```r
> regresion2 <- lm(Grasas ~ . , data = base)	#con esto el unico Y es Grasas, el resto de las variables son X. esto se denota con el '.'
> summary(regresion2)

Call:
lm(formula = Grasas ~ ., data = base)

Residuals:
   Min     1Q Median     3Q    Max 
-61.48 -20.34  -2.93  22.12  90.09 

Coefficients:
             Estimate Std. Error t value Pr(>|t|)    
(Intercept) -205.0083    75.2502  -2.724  0.00999 ** 
Peso           5.3679     1.1971   4.484 7.54e-05 ***
Edad           3.0017     0.6478   4.634 4.82e-05 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 35.64 on 35 degrees of freedom
Multiple R-squared:  0.7895,	Adjusted R-squared:  0.7775 
F-statistic: 65.64 on 2 and 35 DF,  p-value: 1.434e-12	#este p-v es el de la significatividad conjunta
```
Cuando un p-valor sea mayor al valor de significancia de una variable se debe sacar del modelo!

constrast variables dummy que R ha generado
Step -> seleccion de predictores por stepwise y AIC, Metemos una a una y las probamos en el modelo. 
update()-> reajustar y actualizar el modelo
confint() -> intervalos de confianza para los coeficientes del modelo. Por default se genera un intervalo de confianza al 5%. Se acepta si 0 no pertenece al intervalo. Entonces son significatvos.
```r
> step(regresion2, direction = "both", trace = 1)
Start:  AIC=274.46
Grasas ~ Peso + Edad

       Df Sum of Sq   RSS    AIC
<none>              44458 274.46
- Peso  1     25541 69998 289.71
- Edad  1     27276 71734 290.64

Call:
lm(formula = Grasas ~ Peso + Edad, data = base)

Coefficients:
(Intercept)         Peso         Edad  
   -205.008        5.368        3.002  

> confint(regresion2)
                  2.5 %     97.5 %
(Intercept) -357.774303 -52.242343
Peso           2.937657   7.798065	#0 no pertenece a nunguno de los int. de conf
Edad           1.686699   4.316790	#ambas vars son signidicaticas :)

> plot(regresion2)	#Muestra 4 gráficas!
```

![](plotRegresion2.png)

La linea roja indica que tanto se ajusta la linealidad del modelo, lo ideal es que no se aleje mucho del 0 ya que estamos viendo los residuales

![[plotRegresion22.png]]
![[plotRegresion23.png]] 
![[plotRegresion24.png]]

>investigar que son especificamente los residuales !!!!

\* revisar las dif pruebas que tiene que pasar el modelo!

https://github.com/karlosmantilla/importacion

> Mañana veremos regresión logistica

https://r-forge.r-project.org/projects/car/