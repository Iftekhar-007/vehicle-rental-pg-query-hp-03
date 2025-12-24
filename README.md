🚗 Vehicle Rental System – SQL Queries Documentation
📌 Project Overview

This project demonstrates core SQL querying concepts using a Vehicle Rental System database.
The schema is designed around three primary entities:

Users (customers)

Vehicles

Bookings

The objective is to retrieve meaningful insights from the database using standard SQL techniques such as JOIN, WHERE, NOT EXISTS, GROUP BY, and HAVING.

This project follows traditional relational database principles while keeping queries clean, readable, and scalable — the right way to do SQL.

🗂️ Database Tables Used
users

Stores customer information.

user_id (PK)

user_name

email

phone

role

vehicles

Stores vehicle details.

vehicle_id (PK)

vehicle_name

type

availability_status

bookings

Stores booking records.

booking_id (PK)

user_id (FK → users)

vehicle_id (FK → vehicles)

start_date

end_date

status

📄 File Structure
├── README.md
├── queries.sql
├── QUERY.md   (Sample Input/Output reference)

🧠 SQL Queries Explanation (queries.sql)
✅ Query 1: Retrieve Booking Information with Customer & Vehicle Names

Concepts Used: INNER JOIN

This query fetches booking details along with:

Customer name

Vehicle name

Booking duration

Booking status

SELECT
  booking_id,
  user_name AS "customer_name",
  vehicle_name AS "vehicle_name",
  start_date,
  end_date,
  status
FROM
  bookings
INNER JOIN users ON bookings.user_id = users.user_id
INNER JOIN vehicles ON bookings.vehicle_id = vehicles.vehicle_id;


📌 Why INNER JOIN?
Only records that exist in all related tables are returned — exactly what we want for valid bookings.

✅ Query 2: Find Vehicles That Have Never Been Booked

Concepts Used: NOT EXISTS

This query returns all vehicles that do not appear in the bookings table.

SELECT
  *
FROM
  vehicles
WHERE
  NOT EXISTS (
    SELECT
      booking_id
    FROM
      bookings
    WHERE
      bookings.vehicle_id = vehicles.vehicle_id
  )
ORDER BY
  vehicle_id ASC;


📌 Why NOT EXISTS?
It’s the cleanest and safest way to detect missing relationships without false matches.

✅ Query 3: Retrieve Available Vehicles of a Specific Type

Concepts Used: SELECT, WHERE

This query retrieves all available vehicles filtered by a specific type (example: bike).

SELECT
  *
FROM
  vehicles
WHERE
  availability_status = 'available'
  AND type = 'bike';


📌 Use Case:
Perfect for search filters in real rental applications.

✅ Query 4: Find Vehicles with More Than 2 Bookings

Concepts Used: GROUP BY, HAVING, COUNT

This query calculates the total number of bookings per vehicle and shows only those booked more than twice.

SELECT
  vehicle_name,
  COUNT(booking_id) AS "total_bookings"
FROM
  bookings
JOIN vehicles ON bookings.vehicle_id = vehicles.vehicle_id
GROUP BY
  vehicle_name
HAVING
  COUNT(booking_id) > 2;


📌 Why HAVING instead of WHERE?
Because filtering happens after aggregation, not before — classic SQL rule.

📊 Sample Output

For expected outputs of each query, please refer to the QUERY.md file included in the project.

🎯 Key SQL Concepts Demonstrated

Relational joins

Subqueries with EXISTS

Conditional filtering

Data aggregation

Constraint-safe querying
