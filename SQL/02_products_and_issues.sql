-- Q1: Which products get the most complaints?
SELECT Product, COUNT(*) AS total_complaints
FROM `cfpb-complaints-512716.complaints.all_complaints`
GROUP BY Product
ORDER BY total_complaints DESC;

-- Q2: Which issues cause the most complaints? (top 10)
SELECT Issue, COUNT(*) AS total_complaints
FROM `cfpb-complaints-512716.complaints.all_complaints`
GROUP BY Issue
ORDER BY total_complaints DESC
LIMIT 10;

-- Q3: Which product + issue pairs drive complaints? (top 15)
SELECT Product, Issue, COUNT(*) AS total_complaints
FROM `cfpb-complaints-512716.complaints.all_complaints`
GROUP BY Product, Issue
ORDER BY total_complaints DESC
LIMIT 15;

-- Q4: How often do complaints end with money back to the customer? (cost signal)
SELECT
  Product,
  COUNT(*) AS total_complaints,
  COUNTIF(Company_response_to_consumer = 'Closed with monetary relief') AS money_back,
  ROUND(COUNTIF(Company_response_to_consumer = 'Closed with monetary relief') / COUNT(*) * 100, 1) AS pct_money_back
FROM `cfpb-complaints-512716.complaints.all_complaints`
GROUP BY Product
ORDER BY total_complaints DESC;


-- Q5: Inside the 2 biggest products, which issues cost the most money back?
SELECT
  Product,
  Issue,
  COUNT(*) AS total_complaints,
  COUNTIF(Company_response_to_consumer = 'Closed with monetary relief') AS money_back,
  ROUND(COUNTIF(Company_response_to_consumer = 'Closed with monetary relief') / COUNT(*) * 100, 1) AS pct_money_back
FROM `cfpb-complaints-512716.complaints.all_complaints`
WHERE Product IN ('Credit card', 'Checking or savings account')
GROUP BY Product, Issue
ORDER BY money_back DESC
LIMIT 10;