# regression-analysis

Research project on the relationship between various factors and profit of refineries with regression analysis

## Summary
Profit of refineries with larger refining facility are more affected by scale of facility and exchange fluctuations. Refineries should consider realizing economy of scale on refining facility and hedging exchange risk to maximize profit

## Data
22 x 14 panel data
- n = 22 (selected representative global refineries)
- t = 14 (2005-2018 yearly)

## Independent variables
- scale : size of refining facility
- crackerratio : ratio of size of additional distillation facility to size of refining facility
- diversified : size of diversified chemical production facility
- oilprice : average price of WTI, Dubai and Brent oil
- forex : US dollar index futures

## Dependent variable
- profit : EBITDA margin of a refinery

## Research process
1. Data cleansing and pre-processing
2. Multiple linear regression analysis (using plm package)
3. Clustering based on the size of refining facility (using K-means clustering)
4. Multiple linear regression analysis by clusters
