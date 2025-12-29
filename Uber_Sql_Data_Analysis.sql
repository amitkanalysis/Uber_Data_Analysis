use uber;

select * from uber_rides_dataset;

-- Total number of rides in the dataset.
select count(*) as total_riders
from uber_rides_dataset;
 
-- Completed vs cancelled rides count.
select ride_status, count(*) as rides_count
from uber_rides_dataset
group by ride_status;

-- City-wise total number of rides.
select city, count(*) as rides
from uber_rides_dataset
group by city;

-- Year-wise total revenue (total_fare)
select year, round(sum(total_fare),2) as total_revenue
from uber_rides_dataset
group by year
order by year;

-- Month-wise total rides across all years
select month, count(*) as total_rides
from uber_rides_dataset
group by month
order by total_rides desc;

-- City-wise average ride distance
select city, round(avg(distance_km),2) as avg_ride_distance
from uber_rides_dataset
group by city
order by avg_ride_distance desc;

-- Payment method-wise total revenue
select payment_method, round(sum(total_fare),2) as total_revenue
from uber_rides_dataset
group by payment_method
order by total_revenue desc;

-- Cab type-wise total rides
select cab_type, count(*) as total_rides
from uber_rides_dataset
group by cab_type
order by total_rides desc;

-- Gender-wise average fare
select gender, round(avg(total_fare),2) as avg_fare
from uber_rides_dataset
group by gender
order by avg_fare desc;

-- Peak hour vs non-peak hour revenue
select 
	round(sum(case when peak_hour = 'Yes' then total_fare else 0 end),2) as peak_hour_revenue,
    round(sum(case when peak_hour = 'No' then total_fare else 0 end),2) as non_peak_hour_revenue
from uber_rides_dataset
where ride_status = 'Completed';

select peak_hour, round(sum(total_fare),2) as revenue
from uber_rides_dataset
where ride_status = 'Completed'
group by peak_hour;

-- Top 5 highest fare rides
select *
from uber_rides_dataset
where ride_status =  'Completed'
order by total_fare desc
limit 5;

select * 
from (
	select * ,
		dense_rank() over (order by total_fare desc) as rnk
	from uber_rides_dataset
	where ride_status = 'Completed'
) t
where rnk <= 5;

-- City-wise highest single ride fare
select city, max(total_fare) as highest_fare
from uber_rides_dataset 
where ride_status = 'Completed'
group by city
order by highest_fare desc; 

-- Cancellation reason-wise cancelled rides count
SELECT cancellation_reason, COUNT(*) AS cancelled_rides
FROM uber_rides_dataset
WHERE ride_status = 'Cancelled'
GROUP BY cancellation_reason
ORDER BY cancelled_rides DESC;

-- Rides with driver rating below 4.0.
select *
from uber_rides_dataset
where driver_rating < 4.0;

-- Repeat customers (more than 5 rides)
select customer_id, count(*) As total_rides
from uber_rides_dataset
group by customer_id
having count(*) > 5
order by total_rides desc;

-- City and year wise total revenue
select city, year, round(sum(total_fare),2) as total_revenu
from uber_rides_dataset
group by city, year;

-- Gender and cab type wise average distance
select gender, cab_type, round(avg(distance_km),2) as average_distance
from uber_rides_dataset
group by gender, cab_type
order by gender, cab_type;

-- City and peak hour wise total rides
select city, peak_hour, count(*) as total_rides
from uber_rides_dataset
group by city, peak_hour
order by city, peak_hour;

-- Month-wise cancellation rate
select
	month,
		round(sum(case when ride_status = 'Cancelled' then 1 else 0 end) * 100.0
        / count(*),2) As cancellation_rate
from uber_rides_dataset
group by month
order by str_to_date(month, '%M');   

-- Top 3 cities by total revenue
select city, round(sum(total_fare),2) as total_revenue
from uber_rides_dataset
where ride_status = 'Completed'
group by city
order by total_revenue desc
limit 3;

select * from uber_rides_dataset;

