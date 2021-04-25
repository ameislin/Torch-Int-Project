set @target_date :=  CURDATE() 
#can change to any date using 'YYYY-MM-DD' format 
#The data was pulled on the 20th so it won't show 30 days using curdate, use '2021-04-20' or earlier to see 30 days

select  state_name, 
sum(case when overall_outcome = 'negative' then 0 else new_results_reported end) as 'Total-Positive-Tests',
sum(new_results_reported) as 'Total-Tests',
sum(case when overall_outcome='negative' then 0 else new_results_reported end)/sum(new_results_reported) as 'Positivity-Rate'
from COVID c 
where `date` BETWEEN DATE_SUB(@target_date,INTERVAL 29 DAY) and @target_date and state_name not IN ("Puerto Rico", "U.S. Virgin Islands", "Guam", "Northern Mariana Islands", "District of Columbia")
group by state_name 
order by sum(case when overall_outcome='negative' then 0 else new_results_reported end)/sum(new_results_reported) DESC
Limit 10