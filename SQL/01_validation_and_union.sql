-- Step 1: Check row counts after upload (must match the CSV files)
SELECT COUNT(*) AS total_complaints FROM `cfpb-complaints-512716.complaints.credit_card`;       -- 77,734
SELECT COUNT(*) AS total_complaints FROM `cfpb-complaints-512716.complaints.checking_savings`;  -- 72,172
SELECT COUNT(*) AS total_complaints FROM `cfpb-complaints-512716.complaints.other_fintech`;     -- 51,822

-- Step 2: Combine the 3 tables into one (CFPB export limit = 100,000 rows per file)
CREATE OR REPLACE TABLE `cfpb-complaints-512716.complaints.all_complaints` AS
SELECT * FROM `cfpb-complaints-512716.complaints.credit_card`
UNION ALL
SELECT * FROM `cfpb-complaints-512716.complaints.checking_savings`
UNION ALL
SELECT * FROM `cfpb-complaints-512716.complaints.other_fintech`;

-- Step 3: Check the combined table
SELECT COUNT(*) AS total_complaints FROM `cfpb-complaints-512716.complaints.all_complaints`;    -- 201,728