set @target_date :=  CURDATE() 
#can change to any date using 'YYYY-MM-DD' format 
#The data was pulled on the 20th so it won't show 30 days using curdate, use '2021-04-20' or earlier to see 30 days

select `date`, sum(new_results_reported) as 'Total-Tests-Daily',
(select round(sum(new_results_reported)/7,0) 
from COVID cp 
where DATEDIFF(c.`date`, cp.`date`) BETWEEN 0 and 6
) as 'Past-7-Days-Daily-Average'
from COVID c 
where `date` BETWEEN DATE_SUB(@target_date,INTERVAL 29 DAY) and @target_date
group by `date` 
order by `date` DESC 