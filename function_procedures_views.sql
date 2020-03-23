delimiter //

CREATE PROCEDURE user_info(IN id_num INT) -- main info about the user
BEGIN
	SELECT users.name AS name,
		   users.surname AS surname,
		   sex_types.sex as 'sex',
		   countries.country_name AS country,
		   user_types.name AS 'user status',
		   cities.city_name AS 'hometown',
		   users.reg_date AS 'registration date',
		   photos.photo_link AS 'photo link',
		   users.phone_number AS phone,
		   identity_status.status AS 'identity confirmation'
	FROM users
	join sex_types on users.sex_id = sex_types.id
	JOIN user_types ON users.user_type_id = user_types.id 
	JOIN countries ON users.country_id = countries.id 
	JOIN cities ON users.hometown_id = cities.id 
	JOIN identity_status ON users.identity_status_id = identity_status.id 
	JOIN photos ON users.photo_id = photos.id AND photos.target_type_id = 2;
END//

CREATE FUNCTION user_name (id_num INT)
RETURNS VARCHAR(255) DETERMINISTIC
BEGIN
	SET @name = (SELECT name FROM users WHERE id_num = users.id);
	SET @surname = (SELECT surname FROM users WHERE id_num = users.id);
	RETURN CONCAT(@name, ' ', @surname); 
END//
CREATE PROCEDURE user_testimonials(IN user_numint)
BEGIN
	SELECT  user_name(from_user_id) AS 'User name'
			user_text AS 'Testimonial',
			post_date AS 'Post date',
			rating AS 'Rating'
	FROM testimonials WHERE target_id = user_num AND target_type_id = 1;			   
END//





CREATE PROCEDURE user_messages_to_someone(IN to_user INT UNSIGNED, IN from_user int UNSIGNED)
BEGIN
	SELECT user_name(from_user) AS 'Sender',
		   msg_text AS 'Message text',
		   msg_date AS 'Date' ,
		   user_name(to_user) AS 'Reciever'
		   FROM messages WHERE from_user_id = from_user;
END//

CREATE PROCEDURE last_user_messages(IN from_user int unsigned)
BEGIN
	SELECT DISTINCT 
	   first_value(user_name(from_user)) OVER(msg) AS 'Sender name',
	   first_value(msg_text) OVER(msg) AS 'Message text',
	   first_value(msg_date) OVER(msg) AS 'Message date',
	   first_value(user_name(to_user_id)) OVER (msg) AS 'Reciever name'
	   FROM messages
	   WHERE from_user_id = from_user
	  WINDOW msg AS (PARTITION BY to_user_id ORDER BY msg_date DESC);
END//







CREATE PROCEDURE guests_for_order (IN order_id)
BEGIN
	SELECT user_name(user_id) AS 'Name',
		   guest_list.order_id AS 'Order id'
	FROM guest_list WHERE guest_list.order_id = order_id ;
END//

CREATE PROCEDURE order_info (IN id)
BEGIN
	SELECT house_name(orders.house_id) AS 'House name',
		   user_name(house_info.owner_id) AS 'House owner name',
		   user_name(orders.user_id) AS 'User name',
		   date_from AS 'Arrival date',
		   date_till AS 'Departure date',
		   total_price AS 'Price',
		   COUNT(guest_list.id) + 1 AS 'People amount'
	FROM orders
	JOIN house_info ON orders.house_id = house_info.id
	JOIN guest_list ON guest_list.order_id = orders.id
	WHERE orders.id = id;
END//
CREATE PROCEDURE user_orders(IN id)
BEGIN
	SELECT house_name(orders.house_id) AS 'House name',
		   user_name(house_info.owner_id) AS 'House owner name',
		   user_name(orders.user_id) AS 'User name',
		   date_from AS 'Arrival date',
		   date_till AS 'Departure date',
		   total_price AS 'Price',
		   COUNT(guest_list.id) + 1 AS 'People amount'
	FROM orders
	JOIN house_info ON orders.house_id = house_info.id
	JOIN guest_list ON guest_list.order_id = orders.id
	WHERE orders.user_id = id;
END//





CREATE PROCEDURE available_dates(IN house_num int UNSIGNED)
BEGIN
	SELECT date_from AS 'Arrival date',
		   date_till AS 'Departure date'
	FROM available_dates WHERE house_id = house_num;
END//

CREATE FUNCTION house_name (id_num INT)
RETURNS VARCHAR(255) DETERMINISTIC
BEGIN
	SET @name = (SELECT name FROM house_info WHERE id_num = house_info.id);
	RETURN @name; 
END//
CREATE PROCEDURE other_house_owners(IN house_num int UNSIGNED)
BEGIN
	SELECT user_name(user_id) AS 'Other owners' FROM other_owners WHERE house_id = house_num;
END//

CREATE PROCEDURE house_facilities(IN house_num int UNSIGNED)
BEGIN
	SELECT facility_type FROM facility_types WHERE facility_types.id IN (SELECT facility_type_id FROM facilities WHERE house_id = house_num);
END//

CREATE PROCEDURE house_advantages(IN house_num int UNSIGNED)
BEGIN
	SELECT header, body FROM advantage_types WHERE advantage_types.id IN (SELECT advantage_type_id FROM advantages WHERE house_id = house_num);
END//
 
CREATE PROCEDURE house_beds(IN house_num int UNSIGNED)
BEGIN
	SELECT bed_types.name AS 'Bed type', amount, house_id FROM beds 
	JOIN bed_types ON bed_type_id = bed_types.id
	WHERE beds.house_id = house_num;
END//

CREATE PROCEDURE house_information(IN house_num INT)
BEGIN
	SELECT name,
		   user_name(owner_id) AS 'House owner name',
		   countries.country_name AS 'Country',
		   cities.city_name as 'City',
		   house_types.house_type AS 'House type',
		   description AS 'Description',
		   guests_amount AS 'Maximum amount of guests',
		   bed_amount AS 'Bed amount',
		   bathroom_amount AS 'Bathroom amount',
		   price AS 'Price',
		   adress AS 'Adress',
		   rules AS 'Rules'
	FROM house_info
	JOIN countries ON house_info.country_id = countries.id
	JOIN cities ON house_info.city_id = cities.id
	JOIN house_types ON house_type_id = house_types.id
	WHERE house_info.id = house_num;
END//


CREATE PROCEDURE house_testimonials(IN house_num int)
BEGIN
	SELECT  user_name(from_user_id) AS 'User name'
			user_text AS 'Testimonial',
			post_date AS 'Post date',
			rating AS 'Rating'
	FROM testimonials WHERE target_id = house_num AND target_type_id = 2;			   
END//


CREATE PROCEDURE search_house(IN city int, house_type int, guests int, beds int, bathrooms int, price_amount int)
BEGIN
	SELECT name,
		   user_name(owner_id) AS 'House owner name',
		   countries.country_name AS 'Country',
		   cities.city_name as 'City',
		   house_types.house_type AS 'House type',
		   description AS 'Description',
		   guests_amount AS 'Maximum amount of guests',
		   bed_amount AS 'Bed amount',
		   bathroom_amount AS 'Bathroom amount',
		   price AS 'Price',
		   adress AS 'Adress',
		   rules AS 'Rules'
	FROM house_info
	JOIN countries ON house_info.country_id = countries.id
	JOIN cities ON house_info.city_id = cities.id
	JOIN house_types ON house_type_id = house_types.id
	WHERE city_id = city AND house_type_id = house_type AND guests_amount >= guests AND bed_amount >= beds AND bathroom_amount >= bathroom AND price >= price_amount;
END//

CREATE PROCEDURE sort_by_price(IN city int, house_type int, guests int, beds int, bathrooms int,)
BEGIN
	SELECT name,
		   user_name(owner_id) AS 'House owner name',
		   countries.country_name AS 'Country',
		   cities.city_name as 'City',
		   house_types.house_type AS 'House type',
		   description AS 'Description',
		   guests_amount AS 'Maximum amount of guests',
		   bed_amount AS 'Bed amount',
		   bathroom_amount AS 'Bathroom amount',
		   price AS 'Price',
		   adress AS 'Adress',
		   rules AS 'Rules'
	FROM house_info
	JOIN countries ON house_info.country_id = countries.id
	JOIN cities ON house_info.city_id = cities.id
	JOIN house_types ON house_type_id = house_types.id
	WHERE city_id = city AND house_type_id = house_type AND guests_amount >= guests AND bed_amount >= beds AND bathroom_amount >= bathroom AND price >= price_amount
	ORDER BY price DESC;
END//

CREATE PROCEDURE cheapest_in_cities(IN country int)
BEGIN
	SELECT DISTINCT 
	   first_value(house_info.id) OVER(city) AS 'house_id',
	   first_value(house_info.price) OVER(city) AS 'price',
	   first_value(house_info.city_id) OVER(city) AS 'city_id'
	   FROM house_info
	   WHERE country_id = country
	  WINDOW city AS (PARTITION BY city_id ORDER BY house_info.price);
END//

CREATE PROCEDURE most_expensive_in_cities(IN country int)
BEGIN
	SELECT DISTINCT 
	   first_value(house_info.id) OVER(city) AS 'house_id',
	   first_value(house_info.price) OVER(city) AS 'price',
	   first_value(house_info.city_id) OVER(city) AS 'city_id'
	   FROM house_info
	   WHERE country_id = country
	  WINDOW city AS (PARTITION BY city_id ORDER BY house_info.price DESC);
END//


CREATE VIEW advantage_list AS 
SELECT * FROM advantage_types;

CREATE VIEW facilities_list AS 
SELECT * FROM facility_types;

CREATE VIEW identity_status_list AS 
SELECT * FROM identity_status;

CREATE VIEW report_types_list AS 
SELECT * FROM report_types;

CREATE VIEW country_list AS 
SELECT * FROM countries;

CREATE VIEW cities_list AS 
SELECT * FROM cities;