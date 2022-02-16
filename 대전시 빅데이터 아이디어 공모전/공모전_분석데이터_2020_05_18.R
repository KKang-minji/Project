install.packages("readxl")
library(readxl)
df <- read_excel(file.choose(),sheet = "sheet1")

# 전체인구 기준 23시, 13시 뽑기
?subset()
all_23 <- subset(df, df$시간대 == 23)
all_13 <- subset(df, df$시간대 == 13)

#### 변수 이름 바꾸기 ####

library('dplyr')
all_23 <- rename(all_23, m0 = `남10대 미만`, m1 = 남10대, m2 = 남20대, m3 = 남30대, m4 = 남40대, m5 = 남50대, m6 = 남60대, m7 = `남70대 이상`)
all_23 <- rename(all_23, f0 = `여10대 미만`, f1 = 여10대, f2 = 여20대, f3 = 여30대, f4 = 여40대, f5 = 여50대, f6 = 여60대, f7 = `여70대 이상`)
names(all_23)

all_13 <- rename(all_13, m0 = `남10대 미만`, m1 = 남10대, m2 = 남20대, m3 = 남30대, m4 = 남40대, m5 = 남50대, m6 = 남60대, m7 = `남70대 이상`)
all_13 <- rename(all_13, f0 = `여10대 미만`, f1 = 여10대, f2 = 여20대, f3 = 여30대, f4 = 여40대, f5 = 여50대, f6 = 여60대, f7 = `여70대 이상`)
names(all_23)

###
# 결측치 처리 및 숫자형 변환
all_23[all_23=="-"] <- 0
all_23[is.na(all_23)] <- 0
sum(is.na(all_23))
all_23

all_23$m0 <- as.numeric(all_23$m0)
all_23$m7 <- as.numeric(all_23$m7)
all_23$f0 <- as.numeric(all_23$f0)
all_23$f1 <- as.numeric(all_23$f1)
all_23$f3 <- as.numeric(all_23$f3)
all_23$f4 <- as.numeric(all_23$f4)
all_23$f6 <- as.numeric(all_23$f6)
all_23$f7 <- as.numeric(all_23$f7)

all_13[all_13=="-"] <- 0
all_13[is.na(all_13)] <- 0
sum(is.na(all_13))
all_13

all_13$m0 <- as.numeric(all_13$m0)
all_13$m7 <- as.numeric(all_13$m7)
all_13$f0 <- as.numeric(all_13$f0)
all_13$f1 <- as.numeric(all_13$f1)
all_13$f3 <- as.numeric(all_13$f3)
all_13$f4 <- as.numeric(all_13$f3)
all_13$f4 <- as.numeric(all_13$f4)
all_13$f6 <- as.numeric(all_13$f6)
all_13$f7 <- as.numeric(all_13$f7)


# 60대~70대 이상인구 23시, 13시 뽑기
age6070_23 <- subset(all_23, select = c(연월, 시, 구, 행정동, 시간대, m6, m7, f6, f7))

age6070_13 <- subset(all_13, select = c(연월, 시, 구, 행정동, 시간대, m6, m7, f6, f7))


# 70대 이상인구 23시 13시 뽑기
age70_23 <- subset(all_23, select = c(연월, 시, 구, 행정동, 시간대, m7, f7))
age70_13 <- subset(all_13, select = c(연월, 시, 구, 행정동, 시간대, m7, f7))


head(all_23)
str(all_23)

#all_23$total<- sum(all_23[,6:21])

#### 합계(total)
all_23 <- transform(all_23, total = rowSums(all_23[,6:21], na.rm = T))
all_23

all_13 <- transform(all_13, total = rowSums(all_13[,6:21], na.rm = T))
all_13


all_13_rate <- all_13
all_23_rate <- all_23
all_13_rate <- transform(all_13_rate, ratio = (all_13_rate$total/all_23_rate$total))
all_13_rate
all_23_rate <- transform(all_23_rate, ratio = (all_13_rate$total/all_23_rate$total))
all_23_rate
#rowSums(all_13_rate[15,6:21], na.rm = T)


### 변수) m0~7 : m은 남자 f는 여자, 0은 10대 미만 1은 10대, ... , 7은 70대 이상
# total은 m0~f7까지 합, ratio는 "13시 유동인구/23시 유동인구"로 13시 유동인구와 23시 유동인구가 똑같으면 1,
# 13시 유동인구가 더 많으면 1보다 크고, 13시 유동인구보다 23시 유동인구가 더 크면 1보다 작다.

####### 2020_05_18 수정 #######