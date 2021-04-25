select sum(new_results_reported) as 'Total-Tests' from COVID c
where `date` <= CURDATE() -1
