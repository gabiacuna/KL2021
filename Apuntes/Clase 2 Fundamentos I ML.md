## Distribución logistica

Ahora trabajamos con una variable respuesta de **si/no** (dummy).

La regrecion logistica es uno de los algoritmos de ML que se utilizan para resolver problemas de clasificación

\* ML es lo mas chikito que hay en IA.

Si una P es mayor al umbral, la respuesta es si, si no es no. -> *clasificador binario*.

Por ej, pasas o pierdes un ramo, no hay un intermedio.

> Regrecion logistica y no lineal
> ya que la lineal no se ajusta bien a las respuestas de variable dicotomica (binaria) 

La func logistica se define como:

$$logistic(\eta) = \frac{1}{1+e^{-\eta}}$$

El modelo se utiliza con prob:
>AK LA FORMULA 

Ejemplo!

```r
> str(base)
tibble [777 × 18] (S3: tbl_df/tbl/data.frame)
 $ Tipo: chr [1:777] "Si" "Si" "Si" "Si" ...
 $ X1  : num [1:777] 1660 2186 1428 417 193 ...
 $ X2  : num [1:777] 1232 1924 1097 349 146 ...
 $ X3  : num [1:777] 721 512 336 137 55 158 103 489 227 172 ...
 $ X4  : num [1:777] 23 16 22 60 16 38 17 37 30 21 ...
 $ X5  : num [1:777] 52 29 50 89 44 62 45 68 63 44 ...
 $ X6  : num [1:777] 2885 2683 1036 510 249 ...
 $ X7  : num [1:777] 537 1227 99 63 869 ...
 $ X8  : num [1:777] 7440 12280 11250 12960 7560 ...
 $ X9  : num [1:777] 3300 6450 3750 5450 4120 ...
 $ X10 : num [1:777] 450 750 400 450 800 500 500 450 300 660 ...
 $ X11 : num [1:777] 2200 1500 1165 875 1500 ...
 $ X12 : num [1:777] 70 29 53 92 76 67 90 89 79 40 ...
 $ X13 : num [1:777] 78 30 66 97 72 73 93 100 84 41 ...
 $ X14 : num [1:777] 18.1 12.2 12.9 7.7 11.9 9.4 11.5 13.7 11.3 11.5 ...
 $ X15 : num [1:777] 12 16 30 37 2 11 26 37 23 15 ...
 $ X16 : num [1:777] 7041 10527 8735 19016 10922 ...
 $ X17 : num [1:777] 60 56 54 59 15 55 63 73 80 52 ...
> summary(base)
     Tipo                 X1              X2              X3             X4              X5              X6       
 Length:777         Min.   :   81   Min.   :   72   Min.   :  35   Min.   : 1.00   Min.   :  9.0   Min.   :  139  
 Class :character   1st Qu.:  776   1st Qu.:  604   1st Qu.: 242   1st Qu.:15.00   1st Qu.: 41.0   1st Qu.:  992  
 Mode  :character   Median : 1558   Median : 1110   Median : 434   Median :23.00   Median : 54.0   Median : 1707  
                    Mean   : 3002   Mean   : 2019   Mean   : 780   Mean   :27.56   Mean   : 55.8   Mean   : 3700  
                    3rd Qu.: 3624   3rd Qu.: 2424   3rd Qu.: 902   3rd Qu.:35.00   3rd Qu.: 69.0   3rd Qu.: 4005  
                    Max.   :48094   Max.   :26330   Max.   :6392   Max.   :96.00   Max.   :100.0   Max.   :31643  
       X7                X8              X9            X10              X11            X12              X13       
 Min.   :    1.0   Min.   : 2340   Min.   :1780   Min.   :  96.0   Min.   : 250   Min.   :  8.00   Min.   : 24.0  
 1st Qu.:   95.0   1st Qu.: 7320   1st Qu.:3597   1st Qu.: 470.0   1st Qu.: 850   1st Qu.: 62.00   1st Qu.: 71.0  
 Median :  353.0   Median : 9990   Median :4200   Median : 500.0   Median :1200   Median : 75.00   Median : 82.0  
 Mean   :  855.3   Mean   :10441   Mean   :4358   Mean   : 549.4   Mean   :1341   Mean   : 72.66   Mean   : 79.7  
 3rd Qu.:  967.0   3rd Qu.:12925   3rd Qu.:5050   3rd Qu.: 600.0   3rd Qu.:1700   3rd Qu.: 85.00   3rd Qu.: 92.0  
 Max.   :21836.0   Max.   :21700   Max.   :8124   Max.   :2340.0   Max.   :6800   Max.   :103.00   Max.   :100.0  
      X14             X15             X16             X17        
 Min.   : 2.50   Min.   : 0.00   Min.   : 3186   Min.   : 10.00  
 1st Qu.:11.50   1st Qu.:13.00   1st Qu.: 6751   1st Qu.: 53.00  
 Median :13.60   Median :21.00   Median : 8377   Median : 65.00  
 Mean   :14.09   Mean   :22.74   Mean   : 9660   Mean   : 65.46  
 3rd Qu.:16.50   3rd Qu.:31.00   3rd Qu.:10830   3rd Qu.: 78.00  
 Max.   :39.80   Max.   :64.00   Max.   :56233   Max.   :118.00  
> library(carData)
> basenumerica <- unlist(lapply(base, is.numeric))
> head(basenumerica)
 Tipo    X1    X2    X3    X4    X5 
FALSE  TRUE  TRUE  TRUE  TRUE  TRUE 
> basenum <- base[ , basenumerica]
> head(basenum)
# A tibble: 6 x 17
     X1    X2    X3    X4    X5    X6    X7    X8    X9   X10   X11   X12   X13   X14   X15   X16   X17
  <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
1  1660  1232   721    23    52  2885   537  7440  3300   450  2200    70    78  18.1    12  7041    60
2  2186  1924   512    16    29  2683  1227 12280  6450   750  1500    29    30  12.2    16 10527    56
3  1428  1097   336    22    50  1036    99 11250  3750   400  1165    53    66  12.9    30  8735    54
4   417   349   137    60    89   510    63 12960  5450   450   875    92    97   7.7    37 19016    59
5   193   146    55    16    44   249   869  7560  4120   800  1500    76    72  11.9     2 10922    15
6   587   479   158    38    62   678    41 13500  3335   500   675    67    73   9.4    11  9727    55
> chart.Correlation(basenum,histogram = TRUE, pch = 19)
```
![[chartCorr1.png]]

Por cada variable genera su distribucion que queda en la diagonal. Debajo de ella grafica la dispercion de dos variables.

```r
# Gráfico de la variable Respuesta

bar <- table(base$Tipo)
par(mfrow = c(1,1))
barplot(bar, xlab = "Asignación de recursos")
```
![[graphVarRes.png]]

Intercepto es signiificativo cuando es <0.05

```r
> # Entrenamiento
> entr = subset(base)
> trainbase <- sample_frac(entr, 0.8)
> dim(trainbase)
[1] 622  18
> 
> # Prueba
> sid <- as.numeric(rownames(trainbase))
> testbase <- entr[-sid,]
> dim(testbase)
[1] 155  18
> sid <- as.numeric(rownames(trainbase))
> testbase <- entr[-sid,]
> dim(testbase)
[1] 155  18
> modelo1 <- glm(Tipo ~ ., data = trainbase, family = "binomial")
Warning message:
glm.fit: fitted probabilities numerically 0 or 1 occurred 
> summary(modelo1)

Call:
glm(formula = Tipo ~ ., family = "binomial", data = trainbase)

Deviance Residuals: 
    Min       1Q   Median       3Q      Max  
-2.7184  -0.0095   0.0395   0.1389   4.5008  

Coefficients:
              Estimate Std. Error z value Pr(>|z|)    
(Intercept) -1.121e+00  2.276e+00  -0.492 0.622395    
X1          -7.045e-04  2.828e-04  -2.492 0.012717 *  
X2           9.117e-05  5.595e-04   0.163 0.870574    
X3           3.534e-03  1.194e-03   2.959 0.003087 ** 
X4           2.769e-02  3.411e-02   0.812 0.416859    
X5           1.711e-02  2.405e-02   0.712 0.476762    
X6          -8.094e-04  2.376e-04  -3.407 0.000657 ***
X7           6.693e-05  1.402e-04   0.477 0.633156    
X8           8.314e-04  1.466e-04   5.672 1.41e-08 ***
X9           2.625e-04  3.031e-04   0.866 0.386489    
X10          2.363e-03  1.560e-03   1.515 0.129792    
X11         -8.971e-05  3.120e-04  -0.288 0.773688    
X12         -5.075e-02  3.242e-02  -1.565 0.117518    
X13         -4.572e-02  3.354e-02  -1.363 0.172839    
X14         -6.907e-02  8.062e-02  -0.857 0.391597    
X15          4.594e-02  2.366e-02   1.941 0.052207 .  
X16          8.379e-05  1.489e-04   0.563 0.573634    
X17          4.896e-03  1.423e-02   0.344 0.730755    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

(Dispersion parameter for binomial family taken to be 1)

    Null deviance: 717.61  on 621  degrees of freedom
Residual deviance: 176.49  on 604  degrees of freedom
AIC: 212.49

Number of Fisher Scoring iterations: 8

> # Remover las variables no significativas
> 
> modelo2 <- glm(Tipo ~ X1 + X3 + X6 + X8 +0, 
+             data = trainbase, family = "binomial")
> summary(modelo2)

Call:
glm(formula = Tipo ~ X1 + X3 + X6 + X8 + 0, family = "binomial", 
    data = trainbase)

Deviance Residuals: 
    Min       1Q   Median       3Q      Max  
-2.1569  -0.0045   0.1944   0.3197   6.2210  

Coefficients:
     Estimate Std. Error z value Pr(>|z|)    
X1  4.158e-06  1.125e-04   0.037  0.97051    
X3  2.472e-03  8.832e-04   2.799  0.00513 ** 
X6 -1.157e-03  2.040e-04  -5.672 1.41e-08 ***
X8  3.797e-04  3.023e-05  12.560  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

(Dispersion parameter for binomial family taken to be 1)

    Null deviance: 862.28  on 622  degrees of freedom
Residual deviance: 265.65  on 618  degrees of freedom
AIC: 273.65

Number of Fisher Scoring iterations: 7


R version 4.1.0 (2021-05-18) -- "Camp Pontanezen"
Copyright (C) 2021 The R Foundation for Statistical Computing
Platform: x86_64-pc-linux-gnu (64-bit)

R is free software and comes with ABSOLUTELY NO WARRANTY.
You are welcome to redistribute it under certain conditions.
Type 'license()' or 'licence()' for distribution details.

  Natural language support but running in an English locale

R is a collaborative project with many contributors.
Type 'contributors()' for more information and
'citation()' on how to cite R or R packages in publications.

Type 'demo()' for some demos, 'help()' for on-line help, or
'help.start()' for an HTML browser interface to help.
Type 'q()' to quit R.

[Workspace loaded from ~/.RData]

> library(readxl)
> Logistica <- read_excel("Downloads/Logistica.xlsx")
> View(Logistica)                                                                                                       
> library(dplyr)

Attaching package: ‘dplyr’

The following objects are masked from ‘package:stats’:

    filter, lag

The following objects are masked from ‘package:base’:

    intersect, setdiff, setequal, union

> library(rio)
Error in library(rio) : there is no package called ‘rio’
> library(PerformanceAnalytics)
Loading required package: xts
Loading required package: zoo

Attaching package: ‘zoo’

The following objects are masked from ‘package:base’:

    as.Date, as.Date.numeric


Attaching package: ‘xts’

The following objects are masked from ‘package:dplyr’:

    first, last


Attaching package: ‘PerformanceAnalytics’

The following object is masked from ‘package:graphics’:

    legend

> library(corrplot)
corrplot 0.89 loaded
> library(caret)
Error in library(caret) : there is no package called ‘caret’
> library(tidyverse)
Error in library(tidyverse) : there is no package called ‘tidyverse’
> library(car)
Error in library(car) : there is no package called ‘car’
> library(ggplot2)
> base<-Logistica[,-1]
> str(base)
tibble [777 × 18] (S3: tbl_df/tbl/data.frame)
 $ Tipo: chr [1:777] "Si" "Si" "Si" "Si" ...
 $ X1  : num [1:777] 1660 2186 1428 417 193 ...
 $ X2  : num [1:777] 1232 1924 1097 349 146 ...
 $ X3  : num [1:777] 721 512 336 137 55 158 103 489 227 172 ...
 $ X4  : num [1:777] 23 16 22 60 16 38 17 37 30 21 ...
 $ X5  : num [1:777] 52 29 50 89 44 62 45 68 63 44 ...
 $ X6  : num [1:777] 2885 2683 1036 510 249 ...
 $ X7  : num [1:777] 537 1227 99 63 869 ...
 $ X8  : num [1:777] 7440 12280 11250 12960 7560 ...
 $ X9  : num [1:777] 3300 6450 3750 5450 4120 ...
 $ X10 : num [1:777] 450 750 400 450 800 500 500 450 300 660 ...
 $ X11 : num [1:777] 2200 1500 1165 875 1500 ...
 $ X12 : num [1:777] 70 29 53 92 76 67 90 89 79 40 ...
 $ X13 : num [1:777] 78 30 66 97 72 73 93 100 84 41 ...
 $ X14 : num [1:777] 18.1 12.2 12.9 7.7 11.9 9.4 11.5 13.7 11.3 11.5 ...
 $ X15 : num [1:777] 12 16 30 37 2 11 26 37 23 15 ...
 $ X16 : num [1:777] 7041 10527 8735 19016 10922 ...
 $ X17 : num [1:777] 60 56 54 59 15 55 63 73 80 52 ...
> summary(base)
     Tipo                 X1              X2              X3             X4              X5              X6       
 Length:777         Min.   :   81   Min.   :   72   Min.   :  35   Min.   : 1.00   Min.   :  9.0   Min.   :  139  
 Class :character   1st Qu.:  776   1st Qu.:  604   1st Qu.: 242   1st Qu.:15.00   1st Qu.: 41.0   1st Qu.:  992  
 Mode  :character   Median : 1558   Median : 1110   Median : 434   Median :23.00   Median : 54.0   Median : 1707  
                    Mean   : 3002   Mean   : 2019   Mean   : 780   Mean   :27.56   Mean   : 55.8   Mean   : 3700  
                    3rd Qu.: 3624   3rd Qu.: 2424   3rd Qu.: 902   3rd Qu.:35.00   3rd Qu.: 69.0   3rd Qu.: 4005  
                    Max.   :48094   Max.   :26330   Max.   :6392   Max.   :96.00   Max.   :100.0   Max.   :31643  
       X7                X8              X9            X10              X11            X12              X13       
 Min.   :    1.0   Min.   : 2340   Min.   :1780   Min.   :  96.0   Min.   : 250   Min.   :  8.00   Min.   : 24.0  
 1st Qu.:   95.0   1st Qu.: 7320   1st Qu.:3597   1st Qu.: 470.0   1st Qu.: 850   1st Qu.: 62.00   1st Qu.: 71.0  
 Median :  353.0   Median : 9990   Median :4200   Median : 500.0   Median :1200   Median : 75.00   Median : 82.0  
 Mean   :  855.3   Mean   :10441   Mean   :4358   Mean   : 549.4   Mean   :1341   Mean   : 72.66   Mean   : 79.7  
 3rd Qu.:  967.0   3rd Qu.:12925   3rd Qu.:5050   3rd Qu.: 600.0   3rd Qu.:1700   3rd Qu.: 85.00   3rd Qu.: 92.0  
 Max.   :21836.0   Max.   :21700   Max.   :8124   Max.   :2340.0   Max.   :6800   Max.   :103.00   Max.   :100.0  
      X14             X15             X16             X17        
 Min.   : 2.50   Min.   : 0.00   Min.   : 3186   Min.   : 10.00  
 1st Qu.:11.50   1st Qu.:13.00   1st Qu.: 6751   1st Qu.: 53.00  
 Median :13.60   Median :21.00   Median : 8377   Median : 65.00  
 Mean   :14.09   Mean   :22.74   Mean   : 9660   Mean   : 65.46  
 3rd Qu.:16.50   3rd Qu.:31.00   3rd Qu.:10830   3rd Qu.: 78.00  
 Max.   :39.80   Max.   :64.00   Max.   :56233   Max.   :118.00  
> library(carData)
> basenumerica <- unlist(lapply(base, is.numeric))
> head(basenumerica)
 Tipo    X1    X2    X3    X4    X5 
FALSE  TRUE  TRUE  TRUE  TRUE  TRUE 
> basenum <- base[ , basenumerica]
> head(basenum)
# A tibble: 6 x 17
     X1    X2    X3    X4    X5    X6    X7    X8    X9   X10   X11   X12   X13   X14   X15   X16   X17
  <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
1  1660  1232   721    23    52  2885   537  7440  3300   450  2200    70    78  18.1    12  7041    60
2  2186  1924   512    16    29  2683  1227 12280  6450   750  1500    29    30  12.2    16 10527    56
3  1428  1097   336    22    50  1036    99 11250  3750   400  1165    53    66  12.9    30  8735    54
4   417   349   137    60    89   510    63 12960  5450   450   875    92    97   7.7    37 19016    59
5   193   146    55    16    44   249   869  7560  4120   800  1500    76    72  11.9     2 10922    15
6   587   479   158    38    62   678    41 13500  3335   500   675    67    73   9.4    11  9727    55
> chart.Correlation(basenum,histogram = TRUE, pch = 19)
> bar <- table(base$Tipo)
> par(mfrow = c(1,1))
> barplot(bar, xlab = "Asignaci?n de recursos")
> barplot(bar, xlab = "Asignación de recursos")
> base$Tipo <- ifelse(base$Tipo=="Si",1,0)
> head(base$Tipo)
[1] 1 1 1 1 1 1
> # Entrenamiento
> entr = subset(base)
> trainbase <- sample_frac(entr, 0.8)
> dim(trainbase)
[1] 622  18
> # Entrenamiento
> entr = subset(base)
> trainbase <- sample_frac(entr, 0.8)
> dim(trainbase)
[1] 622  18
> 
> # Prueba
> sid <- as.numeric(rownames(trainbase))
> testbase <- entr[-sid,]
> dim(testbase)
[1] 155  18
> sid <- as.numeric(rownames(trainbase))
> testbase <- entr[-sid,]
> dim(testbase)
[1] 155  18
> modelo1 <- glm(Tipo ~ ., data = trainbase, family = "binomial")
Warning message:
glm.fit: fitted probabilities numerically 0 or 1 occurred 
> summary(modelo1)

Call:
glm(formula = Tipo ~ ., family = "binomial", data = trainbase)

Deviance Residuals: 
    Min       1Q   Median       3Q      Max  
-2.7184  -0.0095   0.0395   0.1389   4.5008  

Coefficients:
              Estimate Std. Error z value Pr(>|z|)    
(Intercept) -1.121e+00  2.276e+00  -0.492 0.622395    
X1          -7.045e-04  2.828e-04  -2.492 0.012717 *  
X2           9.117e-05  5.595e-04   0.163 0.870574    
X3           3.534e-03  1.194e-03   2.959 0.003087 ** 
X4           2.769e-02  3.411e-02   0.812 0.416859    
X5           1.711e-02  2.405e-02   0.712 0.476762    
X6          -8.094e-04  2.376e-04  -3.407 0.000657 ***
X7           6.693e-05  1.402e-04   0.477 0.633156    
X8           8.314e-04  1.466e-04   5.672 1.41e-08 ***
X9           2.625e-04  3.031e-04   0.866 0.386489    
X10          2.363e-03  1.560e-03   1.515 0.129792    
X11         -8.971e-05  3.120e-04  -0.288 0.773688    
X12         -5.075e-02  3.242e-02  -1.565 0.117518    
X13         -4.572e-02  3.354e-02  -1.363 0.172839    
X14         -6.907e-02  8.062e-02  -0.857 0.391597    
X15          4.594e-02  2.366e-02   1.941 0.052207 .  
X16          8.379e-05  1.489e-04   0.563 0.573634    
X17          4.896e-03  1.423e-02   0.344 0.730755    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

(Dispersion parameter for binomial family taken to be 1)

    Null deviance: 717.61  on 621  degrees of freedom
Residual deviance: 176.49  on 604  degrees of freedom
AIC: 212.49

Number of Fisher Scoring iterations: 8

> modelo2 <- glm(Tipo ~ X1 + X6 + X8 + X12 +0, 
+             data = trainbase, family = "binomial")
> summary(modelo2)

Call:
glm(formula = Tipo ~ X1 + X6 + X8 + X12 + 0, family = "binomial", 
    data = trainbase)

Deviance Residuals: 
    Min       1Q   Median       3Q      Max  
-2.8472  -0.0144   0.0754   0.1944   5.4783  

Coefficients:
      Estimate Std. Error z value Pr(>|z|)    
X1  -1.422e-04  1.267e-04  -1.122 0.261993    
X6  -4.132e-04  1.168e-04  -3.537 0.000405 ***
X8   8.718e-04  9.464e-05   9.212  < 2e-16 ***
X12 -6.165e-02  9.631e-03  -6.401 1.54e-10 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

(Dispersion parameter for binomial family taken to be 1)

    Null deviance: 862.28  on 622  degrees of freedom
Residual deviance: 216.28  on 618  degrees of freedom
AIC: 224.28

Number of Fisher Scoring iterations: 7

> modelo3 <- glm(Tipo ~  X6 + X8 + X12 +0, 
+                data = trainbase, family = "binomial")
> summary(modelo3)

Call:
glm(formula = Tipo ~ X6 + X8 + X12 + 0, family = "binomial", 
    data = trainbase)

Deviance Residuals: 
    Min       1Q   Median       3Q      Max  
-2.8799  -0.0116   0.0780   0.2032   5.8106  

Coefficients:
      Estimate Std. Error z value Pr(>|z|)    
X6  -5.244e-04  6.984e-05  -7.509 5.97e-14 ***
X8   8.473e-04  9.099e-05   9.312  < 2e-16 ***
X12 -5.930e-02  9.403e-03  -6.306 2.87e-10 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

(Dispersion parameter for binomial family taken to be 1)

    Null deviance: 862.28  on 622  degrees of freedom
Residual deviance: 217.55  on 619  degrees of freedom
AIC: 223.55

Number of Fisher Scoring iterations: 7

> plot(modelo3)
Hit <Return> to see next plot: 
Hit <Return> to see next plot: 
Hit <Return> to see next plot: 
Hit <Return> to see next plot: 
> # Remover las variables no significativas
> 
> modelo2 <- glm(Tipo ~ X1 + X3 + X6 + X8 +0, 
+             data = trainbase, family = "binomial")
> summary(modelo2)

Call:
glm(formula = Tipo ~ X1 + X3 + X6 + X8 + 0, family = "binomial", 
    data = trainbase)

Deviance Residuals: 
    Min       1Q   Median       3Q      Max  
-2.1569  -0.0045   0.1944   0.3197   6.2210  

Coefficients:
     Estimate Std. Error z value Pr(>|z|)    
X1  4.158e-06  1.125e-04   0.037  0.97051    
X3  2.472e-03  8.832e-04   2.799  0.00513 ** 
X6 -1.157e-03  2.040e-04  -5.672 1.41e-08 ***
X8  3.797e-04  3.023e-05  12.560  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

(Dispersion parameter for binomial family taken to be 1)

    Null deviance: 862.28  on 622  degrees of freedom
Residual deviance: 265.65  on 618  degrees of freedom
AIC: 273.65

Number of Fisher Scoring iterations: 7

> ############ Verificaci?n del modelo ###############
> 
> plot(modelo3)
Hit <Return> to see next plot: 
Hit <Return> to see next plot: plot(Tipo ~ X3 + X6 + X8 +0 , data = trainbase, pch = 20)
Hit <Return> to see next plot: 
Hit <Return> to see next plot: 
> 
> # Remover las variables no significativas para el modelo final
>
> modelo3 <- glm(Tipo ~   X3 + X6 + X8 +0, 
+                data = trainbase, family = "binomial")
> summary(modelo3)

Call:
glm(formula = Tipo ~ X3 + X6 + X8 + 0, family = "binomial", data = trainbase)

Deviance Residuals: 
    Min       1Q   Median       3Q      Max  
-2.1576  -0.0045   0.1941   0.3193   6.2122  

Coefficients:
     Estimate Std. Error z value Pr(>|z|)    
X3  2.481e-03  8.510e-04   2.915  0.00355 ** 
X6 -1.155e-03  1.992e-04  -5.800 6.64e-09 ***
X8  3.798e-04  3.019e-05  12.577  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

(Dispersion parameter for binomial family taken to be 1)

    Null deviance: 862.28  on 622  degrees of freedom
Residual deviance: 265.65  on 619  degrees of freedom
AIC: 271.65

Number of Fisher Scoring iterations: 7
```

Modelo 3 es el mejor modelo. Los otros los podemos dejar pero no son necesarios, se puede trabajar sobre solo un modelo.

```r
> # Multicolinealidad
> 
> base1 <- trainbase[c(4,7,9)] # Se crea una base con las variables finales del modelo
> head(base1)
# A tibble: 6 x 3
     X3    X6    X8
  <dbl> <dbl> <dbl>
1  5874 26213  9556
2  1547  9649  4300
3  2440 14445  8200
4   434  1405 13125
5   249  1698  9990
6   156   421  6500

```
Lo podemos ver así:
![[corrMod3.png]]

ya que las vars 3 y 6 se relacionan normalmente dejariamos solo una en el modelo, segun cual es mas importante considerar.  -> Buscamos que no haya una relacion entre las variables.

```r
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
```
Se corre uno para cada variable que funciona, esperamos una 'S' pero no siempre da eso. 


```r
#### Matriz de confución

> pred_prob = predict(modelo3, trainbase, type = "response")
> pred_valores = 1 * (pred_prob > 0.5)
> actual_valor = trainbase$Tipo
> matriz_confu = table(actual_valor, pred_valores)
> matriz_confu
            pred_valores
actual_valor   0   1
           0 122  42
           1   8 450
		  
```
En la diagonal inversa salen los equivocados, y la diagonal dice cuales son los resultados correctos. En este caso el modelo no funca muy bien ya que en total se equivoco n 50 :0.
```r
> tasa_mal = 1 - sum(diag(matriz_confu))/sum(matriz_confu)
> tasa_mal
[1] 0.08038585
```

Ahora pasamos a la curva ROC tambien denominadas de rendimiento de diagnostico. 
Al area bajo la curva se le dice AUC, y segun su valor sabemos que tan bueno es el  test.

A modo de guía para interpretar las curvas ROC se han establecido los siguientes intervalos para los valores de AUC:
* [0.5]: Es como lanzar una moneda.
* [0.5, 0.6): Test malo.
* [0.6, 0.75): Test regular.
* [0.75, 0.9): Test bueno.
* [0.9, 0.97): Test muy bueno.
* [0.97, 1): Test excelente.


```r
library("pROC")
test_prob <- predict(modelo3, newdata = testbase, type = "response")
test_roc <- roc(testbase$Tipo ~ test_prob, plot = TRUE, print.auc = TRUE)
```
![[aucMod3.png]]

Para practicar, haremos un ejercicio

## Análisis discriminante

---deffff-----

1. Comprobacion de las hipotesis!
2. Estimacion del modelo
Procedimiento de Fisher, es el mas utilizado.

El conjunto iris, se almacena en una matriz de 150x5. Hay 3 especiesm, 'setosa', 'viriginica', 'versicolor'.

La idea de la tecnica *linear discriminant analysis* busca una direccion de proyeccion de los datos.

```r
> library(MASS)   # Cargamos la libreria que contiene a  lda

Attaching package: ‘MASS’

The following object is masked from ‘package:dplyr’:

    select

> data(iris)      # Cargamos los datos
> #Dimensi?n de la base, 150 registros y 5 variables
> dim(iris)
[1] 150   5
> # Crear un data frame con las variables
> datos = data.frame(iris[,1:4],clase=as.vector(iris[,5]))
> head(datos)
  Sepal.Length Sepal.Width Petal.Length Petal.Width  clase
1          5.1         3.5          1.4         0.2 setosa
2          4.9         3.0          1.4         0.2 setosa
3          4.7         3.2          1.3         0.2 setosa
4          4.6         3.1          1.5         0.2 setosa
5          5.0         3.6          1.4         0.2 setosa
6          5.4         3.9          1.7         0.4 setosa
```

**NO logro instalar el ggpubr :(

Algo así me habria corrido el ggpubr:

![[Pasted image 20210622212817.png]]

Aca orientarnos respecto a con que informacion cuento, esto es para la orientacion de los datos

```r
> # Aplicaci?n del an?lisis discriminante 
> modelo_lda = lda(clase~.,datos)
> modelo_lda
Call:
lda(clase ~ ., data = datos)

Prior probabilities of groups:
    setosa versicolor  virginica 
 0.3333333  0.3333333  0.3333333 

Group means:
           Sepal.Length Sepal.Width Petal.Length Petal.Width
setosa            5.006       3.428        1.462       0.246
versicolor        5.936       2.770        4.260       1.326
virginica         6.588       2.974        5.552       2.026

Coefficients of linear discriminants:
                    LD1         LD2
Sepal.Length  0.8293776  0.02410215
Sepal.Width   1.5344731  2.16452123
Petal.Length -2.2012117 -0.93192121
Petal.Width  -2.8104603  2.83918785

Proportion of trace:
   LD1    LD2 
0.9912 0.0088 
> modelo_lda$prior  # Asi podemos ver,por ejemplo,las probabilidades a priori
    setosa versicolor  virginica 
 0.3333333  0.3333333  0.3333333 
```
Esta func nos debuelve las prob a priori de los grupos, calcula usando la prop de elementos de cada clase.

la ser LD1>>>LD2 y casi cercano a 1, quiere decir que las flores se pueden clasificar muy bien utilizando un solo eje discriminante.

Validación:
```r
> predicciones <- predict(object = modelo_lda, newdata = datos[, -5])
> table(datos$clase, predicciones$class, dnn = c("Clase real", "Clase predicha"))
            Clase predicha
Clase real   setosa versicolor virginica
  setosa         50          0         0
  versicolor      0         48         2
  virginica       0          1        49
```


En la diagonal estan los bien clasificados :)

en este caso, clasifico 3 mal.

```r
> # Visualizaci?n sobre los dos primeros ejes
> iris.proy = predict(modelo_lda,datos[,1:4])$x
> plot(iris.proy)
> plot(iris.proy,type="n")
> text(iris.proy,labels=datos$clase, col = as.numeric(datos$clase))
```
![[irisPlot.png]]
Muestra como es la clasificacion utilizando mi modelo.

Mañana correremos la regrecion lazo y raids