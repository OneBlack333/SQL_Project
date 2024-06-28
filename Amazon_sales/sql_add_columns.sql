use endtoend;
select * from amazon;

alter table amazon 
add column dayname varchar(255);
UPDATE amazon
SET dayname = DATE_FORMAT(date, '%a');

ALTER TABLE amazon
ADD COLUMN monthname VARCHAR(255);
UPDATE amazon
SET monthname = DATE_FORMAT(date, '%b');


ALTER TABLE amazon
ADD COLUMN timeofday VARCHAR(255);
UPDATE amazon
SET timeofday = 
case 
when time <= 12 then 'Morning'
when time > 12 and time <= 18 then 'Afternoon'
when time > 18 then 'Evening'
end;







