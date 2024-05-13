--1)Retrieve the data

select *  FROM [dbo].[financial_loan]

--2) Find all the financial loan application.

select count(id) as Total_Applications
from [dbo].[financial_loan]

--3) Find all the Appliaction issue in current month

select count(id) as Total_Applications
from [dbo].[financial_loan]
where MONTH(issue_date)= 12 

--4) Find all the Application issue in previous month 

select count(id) as PMTD_Total_Applications
from [dbo].[financial_loan]
where MONTH(issue_date)= 11

--5) Find the sum of total amount of funded loan in current month.

select SUM(loan_amount) as MTD_Total_funded_amount
from [dbo].[financial_loan]
where MONTH(issue_date)=12

--6) Find the sum of total amount of funded loan in previous month.


select SUM(loan_amount) as PMTD_Total_funded_amount
from [dbo].[financial_loan]
where MONTH(issue_date)=11

--7) Find the total loan received in current month.

Select SUM(total_payment) as MTD_Total_payment_received
from [dbo].[financial_loan]
where MONTH(issue_date)=12

--8) Find the total loan received in previous month.

Select SUM(total_payment) as PMTD_Total_payment_received
from [dbo].[financial_loan]
where MONTH(issue_date)=11


--9) Find the  Average interest rate of current month

Select Round(AVG(int_rate),4)*100 As MTD_Average_Interest 
from [dbo].[financial_loan]
where Month(issue_date)=12

--10) Find the  Average interest rate of current month

Select Round(AVG(int_rate),4)*100 As PMTD_Average_Interest 
from [dbo].[financial_loan]
where Month(issue_date)=11

--11) Find the  Average interest rate of current month

Select Round(AVG(dti),4)*100 As MTD_DTI
from [dbo].[financial_loan]
where Month(issue_date)=12

--12) Find the  Average interest rate of current month

Select Round(AVG(dti),4)*100 As PMTD_DTI 
from [dbo].[financial_loan]
where Month(issue_date)=11

--13) Find the percentage of good loans(fully paid or current)

select 
    (count(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END)*100)
	/
	COUNT(id) AS  Good_loan_percentage
from [dbo].[financial_loan]

--14) Find the count for good loan application

select COUNT(id) Good_loan_Application
from [dbo].[financial_loan]
where loan_status ='Fully Paid' or loan_status='Current'

--15) Find the sum for good loan application.

select SUM(loan_amount) Good_loan_Application
from [dbo].[financial_loan]
where loan_status ='Fully Paid' or loan_status='Current'


--16) Find the sum for good loan amount received.

select SUM(total_payment) Good_loan_amount_received
from [dbo].[financial_loan]
where loan_status ='Fully Paid' or loan_status='Current'

--17) Find the percentage of bad loans(charged off)

select 
    (count(CASE WHEN loan_status = 'Charged Off' THEN id END)*100.0)
	/
	COUNT(id) AS  Bad_loan_percentage
from [dbo].[financial_loan]


--18)Find the total count of bad loan application

select COUNT(id) Bad_loan_Application
from [dbo].[financial_loan]
where loan_status ='Charged Off'

--19) Find the sum for bad loan funded amount.

select SUM(loan_amount) Bad_loan_funded_amount
from [dbo].[financial_loan]
where loan_status ='Charged Off'

--20) Find the sum for good loan amount received.

select SUM(total_payment) Bad_loan_amount_received
from [dbo].[financial_loan]
where loan_status ='Charged Off'

--21)Find the loan status of amount

select 
       loan_status,
       count(id) AS LoanCount,
	   SUM(total_payment) as Total_Amount_Received,
	   SUM(loan_amount) as Total_Funded_Amount,
	   Avg(int_rate *100) As Interest_rate,
	   Avg(dti*100) AS DTI
from [dbo].[financial_loan]
group by loan_status


--22)Find the amount received and funded amount of current month.

select 
       loan_status,
       count(id) AS LoanCount,
	   SUM(total_payment) as MTD_Total_Amount_Received,
	   SUM(loan_amount) as Total_Funded_Amount
from [dbo].[financial_loan]
where MONTH(issue_date)=12
group by loan_status

--23)Find the amount received and funded amount of previous month.

select 
       loan_status,
       count(id) AS LoanCount,
	   SUM(total_payment) as PMTD_Total_Amount_Received,
	   SUM(loan_amount) as Total_Funded_Amount
from [dbo].[financial_loan]
where MONTH(issue_date)=11
group by loan_status


--24)Find total count of application of monthly trends of loan amount. 

select
      MONTH(issue_date) As Month_order,
      DATENAME(MONTH,issue_date) As Month,
	  count(id) As Total_loan_Applications,
	  Sum(loan_amount) As Total_Funded_Amount
From [dbo].[financial_loan]
group by MONTH(issue_date),Datename(MONTH,issue_date) 
order by MONTH(issue_date) 
