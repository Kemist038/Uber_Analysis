# Basic Level 

# 1. What are & how many unique pickup locations are there in the dataset?
SELECT COUNT(DISTINCT(Pickup_Location)) AS Unique_Locations FROM Rides;

# 2. What is the total number of rides in the dataset?
SELECT SUM(Total_Rides) AS Total_Rides FROM passangers;

# 3. Calculate the average ride duration.
SELECT AVG(Ride_Duration) AS Average_Ride_Duration FROM Rides;

# 4. List the top 5 drivers based on their total earnings.
SELECT Driver_Name, Earnings FROM Drivers
ORDER BY Earnings DESC
LIMIT 5;

#5. Calculate the total number of rides for each payment method.
SELECT Payment_Method, COUNT(Payment_Method) AS Total_Rides_for_Payment_Method
FROM Rides
GROUP BY Payment_Method;

# 6. Retrieve rides with a fare amount greater than 2000.
SELECT Ride_Id FROM Rides
WHERE Fare_Amount > 2000;

# 7. Identify the most common pickup location.
SELECT pickup_location, COUNT(pickup_location) AS No_of_Times
FROM Rides
GROUP BY pickup_location
ORDER BY No_of_Times DESC
LIMIT 1;

# 8. Calculate the average fare amount.
SELECT ROUND(AVG(Fare_Amount),2) AS Average_Fare_Amount
FROM Rides;

# 9. List the top 10 drivers with the highest average ratings.
SELECT Driver_Name FROM Drivers
ORDER BY Rating DESC
LIMIT 10;

# 10. Calculate the total earnings for all drivers.
SELECT ROUND(SUM(Earnings),2) AS Total_Earnings FROM drivers;

# 11. How many rides were paid using the "Cash" payment method?
SELECT Payment_Method, COUNT(Payment_Method) AS No_of_Times
FROM Rides
WHERE Payment_Method = "Cash";

/* 12. Calculate the number of rides & average ride distance for rides originating 
   from the 'Dhanbad' pickup location. */
SELECT  Pickup_Location, 
	   COUNT(Pickup_Location) AS No_of_Rides ,
	   ROUND(AVG(Ride_Distance),2) AS Average_ride_Distance
FROM Rides
WHERE Pickup_Location = "Dhanbad";

# 13. Retrieve rides with a ride duration less than 10 minutes.
SELECT Ride_Id FROM Rides
WHERE Ride_Duration < 10;

# 14. List the passengers who have taken the most number of rides.
SELECT passenger_name FROM Passangers
ORDER BY Total_rides DESC
LIMIT 10;

# 15. Calculate the total number of rides for each driver in descending order.
SELECT Driver_Name, Total_rides FROM Drivers
ORDER BY Total_rides DESC;

/* 16. Identify the payment methods used by passengers who took rides 
   from the 'Gandhinagar' pickup location. */
SELECT Payment_Method FROM rides
WHERE pickup_location = "Gandhinagar"
GROUP BY Payment_Method;

# 17. Calculate the average fare amount for rides with a ride distance greater than 10.
SELECT ROUND(AVG(Fare_Amount),2) AS Fare_Amount_For_Dis_greater_Then_10 
FROM Rides
WHERE Ride_Distance > 10;

# 18. List the drivers in descending order according to their total number of rides.
SELECT Driver_Name FROM Drivers 
ORDER BY Total_Rides DESC;

# 19. Calculate the percentage distribution of rides for each pickup location.
SELECT Pickup_Location,
	ROUND((((Count(Pickup_LOcation))/5000) * 100),2) AS Distribution_of_Pickup
FROM Rides
GROUP BY Pickup_Location;

# OR
# Use this for always getting correct answer.

SELECT Pickup_Location,
		ROUND((((COUNT(pickup_location))/(SELECT COUNT(pickup_location) FROM rides))*100),2) AS Distribution
FROM Rides
GROUP BY pickup_location
ORDER BY Distribution DESC;

# 20. Retrieve rides where both pickup and dropoff locations are the same.
SELECT Ride_Id FROM RIDES
WHERE Pickup_Location = Dropoff_Location;


# Intermediate Level


# 1. List the passengers who have taken rides from at least 300 different pickup locations.

SELECT P.passenger_Id, p.passenger_name, COUNT(DISTINCT(r.pickup_location)) AS No_of_diff_pickup_location
FROM passangers AS p JOIN rides AS r
ON p.passenger_id = r.passenger_id
GROUP BY P.passenger_Id,p.passenger_name
HAVING COUNT(DISTINCT(r.pickup_location)) >= 300
ORDER BY No_of_diff_pickup_location;

#2. Calculate the average fare amount for rides taken on weekdays.

SELECT AVG(fare_amount) AS Average_Fare_Amount 
FROM Rides
WHERE DAYOFWEEK(STR_TO_DATE(ride_timestamp, "%m/%d/%Y %H:%i")) BETWEEN 2 AND 6; 

# 3. Identify the drivers who have taken rides with distances greater than 19.

SELECT DISTINCT(Driver_id), Driver_Name 
FROM Drivers
WHERE Driver_Id IN (
					SELECT Driver_ID 
					FROM rides 
					WHERE ride_distance > 19
				   );

# 4. Calculate the total earnings for drivers who have completed more than 100 rides.

SELECT 
	DISTINCT(Driver_id), 
	Driver_Name, 
	SUM(Earnings) AS Total_Earning, 
	Total_rides
FROM drivers
GROUP BY Driver_Id
HAVING Total_Rides > 100;

# 5. Retrieve rides where the fare amount is less than the average fare amount.

SELECT DISTINCT(ride_Id) 
FROM rides
WHERE fare_amount < (
						SELECT AVG(fare_amount) 
						FROM rides
					);

/* 6. Calculate the average rating of drivers who have driven rides
	with both 'Credit Card' and 'Cash' payment methods. */

SELECT Driver_Id, Driver_Name, AVG(rating) AS Average_ratings 
FROM drivers
WHERE driver_Id IN (
					SELECT DISTINCT(Driver_Id) 
					FROM rides 
					WHERE payment_Method IN ("Credit Card", "Cash")
				   )
GROUP BY driver_id;

								# OR 

SELECT d.Driver_Id, d.driver_name, ROUND(AVG(d.rating),2) AS Average_Ratings 
FROM drivers AS d JOIN rides AS r
ON d.driver_id = r.driver_id
WHERE r.payment_method IN ("Credit Card", "Cash")
GROUP BY d.driver_id, d.driver_name
ORDER BY d.driver_id;

# 7. List the top 3 passengers with the highest total spending.
SELECT DISTINCT(Passenger_Id), Passenger_Name, Total_Spent 
FROM passangers
ORDER BY Total_Spent DESC;

SELECT p.passenger_id, p.passenger_name, ROUND(SUM(r.fare_amount),2) AS total_spending
FROM Passangers AS p JOIN Rides AS r 
ON p.passenger_id = r.passenger_id
GROUP BY p.passenger_id
ORDER BY total_spending DESC;

# 8. Calculate the average fare amount for rides taken during different months of the year.

SELECT MONTHNAME(STR_TO_DATE(ride_timestamp,"%m/%d/%Y %H:%i")) AS Month_Name, 
	   ROUND(AVG(Fare_Amount),2) AS Average_fare_amount 
FROM Rides  								
GROUP BY Month_Name
ORDER BY Month_Name;

# 9. Identify the most common pair of pickup and dropoff locations.

SELECT Pickup_Location, dropoff_location, COUNT(*) AS Count_of_Locations
FROM Rides
GROUP BY Pickup_Location, dropoff_location
ORDER BY Count_of_Locations DESC;

/* 10. Calculate the total earnings for each driver and order them 
	by earnings in descending order. */

SELECT driver_id, Driver_Name, SUM(earnings) AS Total_earnings
FROM drivers
GROUP BY driver_id, Driver_Name
ORDER BY Total_earnings DESC;

# 11. List the passengers who have taken rides on their signup date.

SELECT p.passenger_id, p.passenger_Name, COUNT(p.passenger_id) AS Times_Trips
FROM passangers AS p JOIN rides AS r
ON p.passenger_id = r.passenger_id
WHERE 
DATE(STR_TO_DATE(p.signup_date, "%m/%d/%Y")) 
				= 
DATE(STR_TO_DATE(r.ride_timestamp, "%m/%d/%Y"))
GROUP BY p.passenger_id, p.passenger_Name
ORDER BY passenger_id;


/* 12. Calculate the average earnings for each driver 
	and order them by earnings in descending order. */

SELECT driver_id, AVG(earnings) AS Average_earnings
FROM drivers
GROUP BY driver_id
ORDER BY Average_earnings DESC;

# 13. Retrieve rides with distances less than the average ride distance.

SELECT DISTINCT(ride_id) 
FROM rides
WHERE ride_distance < (SELECT AVG(ride_distance) FROM rides);

# 14. List the drivers who have completed the least number of rides.

SELECT Driver_id 
FROM drivers
ORDER BY total_rides;

SELECT Driver_id, COUNT(Driver_id) AS Total_Rides 
FROM Rides
GROUP BY Driver_Id
ORDER BY Total_rides;

/* 15. Calculate the average fare amount for rides taken by passengers 
	who have taken at least 20 rides. */

SELECT ROUND(AVG(Fare_amount),2) AS Average_Fare_Amount FROM Rides
WHERE Passenger_Id IN (
					   SELECT passenger_id 
					   FROM rides 
					   GROUP BY passenger_id 
                       HAVING passenger_id >=20
                      );

# 16. Identify the pickup location with the highest average fare amount.

SELECT Pickup_Location, ROUND(AVG(Fare_Amount),2) AS Average_Fare_Amount 
FROM Rides
GROUP BY Pickup_Location
ORDER BY Average_Fare_Amount DESC
LIMIT 1;

# 17. Calculate the average rating of drivers who completed at least 100 rides.

SELECT ROUND(AVG(Rating),2) AS Average_rating 
FROM Drivers
WHERE Total_Rides >= 100;

# 18. List the passengers who have taken rides from at least 5 different pickup locations.

SELECT 
	Passenger_Id, 
	COUNT(DISTINCT(Pickup_Location)) AS No_of_diffrent_Pickup_Location 
FROM Rides
GROUP BY Passenger_Id
HAVING No_of_diffrent_Pickup_Location >=5;

# 19. Calculate the average fare amount for rides taken by passengers with ratings above 4.
SELECT ROUND(AVG(fare_Amount),2) AS Average_Fare_Amount 
FROM rides
WHERE passenger_id IN (
						SELECT passenger_id 
						FROM passangers 
						WHERE rating > 4
					  );

# 20. Retrieve rides with the shortest ride duration in each pickup location.

SELECT pickup_location, MIN(Ride_Duration) AS Least_Ride_Duration
FROM Rides
GROUP BY pickup_location; 


# Adavance Level


# 1.List the drivers who have driven rides in all pickup locations.

SELECT Driver_Id, COUNT(DISTINCT(Pickup_Location)) AS Dis_Pickup_Location
FROM Rides
GROUP BY Driver_Id
HAVING Dis_Pickup_Location = (SELECT COUNT(DISTINCT(Pickup_Location)) FROM Rides);

# 2.Calculate the average fare amount for rides taken by passengers who have spent more than 300 in total.

SELECT ROUND(AVG(Fare_Amount),2) AS Avgerage_Fare_Amount 
FROM Rides
WHERE Passenger_Id IN (
						SELECT Passenger_Id 
						FROM passengers
						WHERE Total_Spent > 300
					  );

# 3.List the bottom 5 drivers based on their average earnings.

SELECT Driver_Id, AVG(Earnings) AS Average_Earnings 
FROM drivers
GROUP BY Driver_Id
ORDER BY Average_Earnings
LIMIT 5;

/* 4.Calculate the sum fare amount for rides taken by passengers who have taken rides 
    in different payment methods.*/

SELECT ROUND(SUM(Fare_Amount),2) AS Total_Fare_Amount 
FROM Rides
WHERE Passenger_Id IN (
SELECT Passenger_Id FROM Rides 
GROUP BY Passenger_Id 
HAVING COUNT(Payment_Method) > 1);

# 5.Retrieve rides where the fare amount is significantly above the average fare amount.

SELECT * 
FROM Rides
WHERE Fare_Amount > (
						(
							SELECT AVG(Fare_Amount) AS Average_Fare_Amount 
							FROM Rides
						) 
						* 1.3
					)
ORDER BY Fare_Amount;

# 6.List the drivers who have completed rides on the same day they joined.

SELECT Join_Date FROM Drivers;
SELECT D.Driver_Id, Driver_Name
FROM Drivers AS D JOIN Rides AS R
ON D.Driver_Id = R.Driver_Id
WHERE DATE(STR_TO_DATE(D.Join_Date,"%d/%m/%Y")) = DATE(STR_TO_DATE(R.ride_timestamp,"%d/%m/%Y %H:%i"))
GROUP BY D.Driver_Id, Driver_Name
ORDER BY D.Driver_Id;

/* 7.Calculate the average fare amount for rides taken by passengers 
	who have taken rides in different payment methods.*/

SELECT ROUND(AVG(Fare_Amount),2) AS Average_Fare_Amount FROM Rides
WHERE Passenger_Id IN (
					   SELECT Passenger_Id 
					   FROM Rides 
					   GROUP BY Passenger_Id 
                       HAVING COUNT(Payment_Method) > 1
                      );
                       

/* 8.Identify the pickup location with the highest percentage increase
   in average fare amount compared to the overall average fare.*/

SELECT 
	Pickup_Location, 
	(
	 ROUND((((AVG(Fare_Amount)-(SELECT AVG(Fare_Amount) FROM Rides))/
	 (SELECT AVG(Fare_Amount) FROM Rides))*100),2) 
    ) AS percentage_Increase_in_Average_Fair_Amount 
FROM Rides
GROUP BY Pickup_Location
ORDER BY percentage_Increase_in_Average_Fair_Amount DESC;

# 9.Retrieve rides where the dropoff location is the same as the pickup location.

SELECT Ride_Id 
FROM Rides
WHERE dropoff_location = Pickup_Location;

# 10.Calculate the average rating of drivers who have driven rides with varying pickup locations.

SELECT ROUND(AVG(Rating),2) AS Average_rating 
FROM Drivers
WHERE Driver_Id IN (
					SELECT Driver_Id FROM Rides
					GROUP BY Driver_Id 
                    HAVING COUNT(Pickup_location) > 1
                   );
