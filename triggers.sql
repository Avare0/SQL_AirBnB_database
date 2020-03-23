CREATE TRIGGER new_user_info_check BEFORE INSERT ON users
FOR EACH ROW 
BEGIN
	IF NEW.name IS NULL OR 
	   NEW.sex_id NOT IN (SELECT id FROM sex_types) OR
	   NEW.surname IS NULL OR 
	   NEW.user_type_id NOT IN (SELECT id FROM user_types) OR 
	   NEW.hometown_id NOT IN (SELECT id FROM cities) OR 
	   NEW.country_id NOT IN (SELECT id FROM countries) OR 
	   NEW.photo_id NOT IN (SELECT id FROM photos) OR 
	   NEW.identity_status_id NOT IN (SELECT id FROM identity_status) THEN 
	   SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Invalid information";
	  END IF;
END//

CREATE TRIGGER new_house_info_check BEFORE INSERT ON house_info
FOR EACH row
BEGIN
	IF NEW.name IS NULL OR 
	   NEW.owner_id NOT IN (SELECT id FROM users) OR
	   NEW.city_id NOT IN (SELECT id FROM cities) OR 
	   NEW.country_id NOT IN (SELECT id FROM countries) OR 
	   NEW.house_type_id NOT IN (SELECT id FROM house_types) OR 
	   NEW.guests_amount < 1 OR 
	   NEW.bed_amount < 1 OR 
	   NEW.bathroom_amount < 1 OR 
	   NEW.price < 0 OR 
	   NEW.adress IS NULL THEN 
	   SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Invalid information";
	  END IF;
END//

CREATE TRIGGER new_order_check BEFORE INSERT ON orders
FOR EACH ROW 
BEGIN 
	IF NEW.house_id NOT IN (SELECT id form house_info) OR 
	   NEW.user_id NOT IN (SELECT id FROM users) OR 
	   NEW.date_from > NEW.date_till OR 
	   NEW.total_price < 1 OR 
	   NEW.order_status_id NOT IN (SELECT id FROM order_statuses) THEN 
	   SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Invalid information";
	  END IF;
END//