# 워킹디렉토리 설정
setwd("~/Desktop/data")

# 패키지 로드
install.packages("plm")
library(plm)

# 데이터 로드
rm(list=ls())
refinery.df <- read.csv("refinery_data (2005-2018).csv", encoding = "UTF-8")
names(refinery.df) <- c("year", "company", "scale", "crackerratio", "diversified", "profit", "oilprice", "forex")
head(refinery.df, 10)

# 설비규모별 클러스터링
scalelevel <- NA
tmp <- cbind(refinery.df, scalelevel)

tmp$scalelevel[is.na(tmp$scalelevel)] <- "Mid"
tmp$scalelevel[tmp$company == "Motor Oil Hellas"
              | tmp$company == "IRPC"
              | tmp$company == "Grupa Lotos SA"
              | tmp$company == "Delek Refining Ltd."
              | tmp$company == "Thai Oil Company Ltd."
              | tmp$company == "Petron"
              | tmp$company == "Saras Raffinerie Sarde"
              ] <- "Low"
tmp$scalelevel[tmp$company == "SK Corporation"
              | tmp$company == "Reliance Industries"
              | tmp$company == "JX Nippon Oil and Energy"
              | tmp$company == "Marathon Petroleum"
              | tmp$company == "Valero"
              | tmp$company == "Phillips 66 Co."
              ] <- "High"

tmp$scalelevel <- as.factor(tmp$scalelevel)
refinery.df <- tmp

# 클러스별 데이터프레임 생성
scalelevel_low.df <- subset(refinery.df, scalelevel == "Low")
scalelevel_mid.df <- subset(refinery.df, scalelevel == "Mid")
scalelevel_high.df <- subset(refinery.df, scalelevel == "High")

# 회귀분석 & 독립변수 유의성 검증
########################### Total ###########################
model_total <- plm(profit ~ scale + crackerratio + diversified + oilprice + forex, index=c("company", "year"), data=refinery.df, model="within")
summary(model_total)

########################### Low ###########################
model_low <- plm(profit ~ scale + crackerratio + diversified + oilprice + forex, index=c("company", "year"), data=scalelevel_low.df, model="within")
summary(model_low)

########################### Mid ###########################
model_mid <- plm(profit ~ scale + crackerratio + diversified + oilprice + forex, index=c("company", "year"), data=scalelevel_mid.df, model="within")
summary(model_mid)

########################### High ###########################
model_high <- plm(profit ~ scale + crackerratio + diversified + oilprice + forex, index=c("company", "year"), data=scalelevel_high.df, model="within")
summary(model_high)

# 산점도
par(mfrow=c(2,3))
plot(profit ~ scale + crackerratio + diversified + oilprice + forex, data=refinery.df, main="Scatter plot", pch=20)