-- query 01 get booking info with user name and vehicle name
select
  booking_id,
  user_name as "customer_name",
  vehicle_name as "vehicle_name",
  start_date,
  end_date,
  status
from
  bookings
  inner join users on bookings.user_id = users.user_id
  inner join vehicles on bookings.vehicle_id = vehicles.vehicle_id;

--query 02 get all non booked vehicle
select
  *
from
  vehicles
where
  not exists (
    select
      booking_id
    from
      bookings
    where
      bookings.vehicle_id = vehicles.vehicle_id
  )
order by
  vehicle_id asc;

--query 03  get all vehicles available for a single type vehile 
select
  *
from
  vehicles
where
  availability_status = 'available'
  and
type
  = 'bike';

--query 04 find total numbers of bookings by group by, having, count 
select
  vehicle_name,
  count(booking_id) as "total_bookings"
from
  bookings
  join vehicles on bookings.vehicle_id = vehicles.vehicle_id
group by
  vehicle_name
having
  count(booking_id) > 2;