CREATE DATABASE churn_project;
USE churn_project;
CREATE TABLE telco_churn (
customerID VARCHAR(20),
gender VARCHAR(10),
SeniorCitizen INT,
Partner VARCHAR(5),
Dependents VARCHAR(5),
tenure INT,
PhoneService VARCHAR(5),
MultipleLines VARCHAR(20),
InternetService VARCHAR(20),
OnlineSecurity VARCHAR(20),
OnlineBackup VARCHAR(20),
DeviceProtection VARCHAR(20),
TechSupport VARCHAR(20),
StreamingTV VARCHAR(20),
StreamingMovies VARCHAR(20),
Contract VARCHAR(20),
PaperlessBilling VARCHAR(5),
PaymentMethod VARCHAR(50),
MonthlyCharges DECIMAL(10,2),
TotalCharges DECIMAL(10,2),
Churn VARCHAR(5)
);

select count(*) from telco_churn;

# Churn Rate Calculation
select
count(*) as Total_Customers,
sum(case when Churn = 'Yes' then 1 else 0 end) as Churned_Customers,
round(sum(case when Churn='Yes' then 1 else 0 end)*100.0/count(*),2) as Churn_Rate
from telco_churn;
# Insight: the churn rate is 26.54% and the number of churned customer is 1869.

# Churn by Contract Type
select Contract,
count(*) as Customers,
sum(case when Churn='Yes' then 1 else 0 end) as Churned
from telco_churn
group by Contract 
Order by Churned desc;
/*Month-to-month	3875	1655
  One year	        1473	166
  Two year	        1695	48*/
# Insight: Month to month contract dominates churn.

# Churn by Internat Service
select 
InternetService,
count(*) as Customers,
sum(case when Churn = 'Yes' then 1 else 0 end) as Churned
from telco_churn
group by InternetService
order by Churned desc;
/* Fiber optic	3096	1297
   DSL	        2421	459
   No	        1526	113*/
# Insight: Fiber optics users churn more.

# Average Monthly Charges of Churned Customers
select 
Churn,
round(avg(MonthlyCharges),2) as Avg_Monthly_Charge
from telco_churn
group by Churn;
/* No	61.27
   Yes	74.44*/
