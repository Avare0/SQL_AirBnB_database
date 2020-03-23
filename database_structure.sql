DROP DATABASE IF EXISTS airbnb;
CREATE DATABASE airbnb;
USE airbnb;
CREATE TABLE users ( 
	id int UNSIGNED AUTO_INCREMENT  PRIMARY KEY,
	name VARCHAR(50) NOT NULL,
	sex_id int UNSIGNED,
	surname VARCHAR(50) NOT NULL,
	user_type_id int UNSIGNED NOT NULL, -- whether user is a house owner or a guest or maybe even both
	hometown_id int UNSIGNED NOT null,
	country_id int UNSIGNED NOT NULL,
	reg_date DATETIME DEFAULT NOW(),
	photo_id int UNSIGNED DEFAULT NULL,
	phone_number varchar(20) UNIQUE,
	identity_status_id int UNSIGNED NOT NULL DEFAULT 1
);
CREATE TABLE sex_types (
	id int UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY key,
	sex varchar(1)
);
INSERT INTO sex_types(sex) VALUES ('m'),('f');
CREATE TABLE user_types (
	id int UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	name varchar(20) NOT NULL
);
INSERT INTO user_types(name) VALUES ('Guest'), ('Owner'), ('Guest and owner');

CREATE TABLE identity_status (
	id int UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	status varchar(20)
);
INSERT INTO identity_status(status) VALUES ('Not confirmed'), ('Confirmed'), ('Requested');

CREATE TABLE user_bookmarks ( -- Apartments or houses that user wants to add to his/her bookmarks
	id int UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	user_id int UNSIGNED NOT NULL,
	house_id int UNSIGNED NOT NULL
);









CREATE TABLE testimonials ( 
	id int unsigned AUTO_INCREMENT  PRIMARY KEY,
	target_type_id int UNSIGNED NOT NULL,
	target_id int UNSIGNED NOT NULL,
	from_user_id int UNSIGNED,
	post_date datetime DEFAULT now(),
	user_text text NOT NULL,
	rating int UNSIGNED NOT NULL,
	hidden_text text -- special airbnb feature that allows reviewer to write a message in the testimonial that can only be seen by the review target
);

CREATE TABLE target_type (
	id int UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	target_type varchar(20) NOT NULL UNIQUE
);
INSERT INTO target_type(target_type) VALUES ('User'), ('House');





CREATE TABLE messages (
	id int unsigned AUTO_INCREMENT  PRIMARY KEY,
	to_user_id int UNSIGNED NOT NULL,
	from_user_id int UNSIGNED NOT NULL,
	msg_text text,
	msg_date datetime DEFAULT now(),
	report_type_id int UNSIGNED DEFAULT NULL -- in airbnb u can report message for spam,cheating etc. 
);

CREATE TABLE report_types (
	id int UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	reason text NOT null  -- airbnb allows u to write ur own reason for a report so this table will start with default reasons of reporting offered by the service 
); --  and the others will be users` own reasons
INSERT INTO report_types(reason) VALUES ('Abuse'), ('Cheating or spam');






CREATE TABLE house_info (
	id int UNSIGNED AUTO_INCREMENT  PRIMARY KEY,
	name varchar(100) NOT NULL,
	owner_id int UNSIGNED NOT NULL,
	country_id int UNSIGNED NOT NULL,
	city_id int UNSIGNED NOT NULL,
	house_type_id int UNSIGNED NOT NULL,
	description text,
	guests_amount int UNSIGNED NOT NULL,
	bed_amount int UNSIGNED NOT NULL,
	bathroom_amount int UNSIGNED NOT NULL,
	price int UNSIGNED NOT NULL,
	adress varchar(200),
	rules text
);

CREATE TABLE house_types (
	id int UNSIGNED AUTO_INCREMENT  PRIMARY KEY,
	house_type varchar(20) NOT NULL UNIQUE
);
INSERT INTO house_types(house_type) VALUES ('Guesthouse'), ('Apartment'), ('Flat'), ('Room');

CREATE TABLE other_owners (
	id int unsigned AUTO_INCREMENT  PRIMARY KEY,
	user_id int UNSIGNED NOT NULL,
	house_id int UNSIGNED NOT NULL
);

CREATE TABLE advantages (
	id int unsigned AUTO_INCREMENT  PRIMARY KEY,
	house_id int UNSIGNED NOT NULL,
	advantage_type_id int UNSIGNED NOT NULL
);

CREATE TABLE advantage_types(
	id int UNSIGNED AUTO_INCREMENT  PRIMARY KEY,
	header text NOT null,
	body text NOT null
);
INSERT INTO advantage_types(header, body) VALUES 
('Perfect cleanliness', 'Majority of guest underline that apartment is clean') , 
('Experienced owner','Owners with a lot of experience'),
('Cheap price and good conditions', 'One of the best variants to chose in the region'),
('Best location', 'Building is situated near the supermarket'),
('Parking available', 'Parking inside the building');


CREATE TABLE beds(
	id int unsigned AUTO_INCREMENT  PRIMARY KEY,
	house_id int UNSIGNED NOT NULL,
	bed_type_id int UNSIGNED NOT NULL,
	amount int UNSIGNED NOT NULL
);

CREATE TABLE bed_types (
	id int UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	name varchar(20) UNIQUE
);
INSERT INTO bed_types(name) VALUES ('Sofa bed'),('Single bed'), ('Bed');

CREATE TABLE facilities (
	id int unsigned AUTO_INCREMENT  PRIMARY KEY,
	house_id int UNSIGNED NOT NULL,
	facility_type_id int unsigned NOT NULL
);

CREATE table facility_types (
	id int UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	facility_type varchar(20)
);
INSERT INTO facility_types(facility_type) VALUES ('Wi-Fi'), ('Conditioner'), ('Parking'), ('Kitchen'), ('Washing machine'), ('TV'), ('First Aid Kit');

CREATE TABLE available_dates (
	id int unsigned AUTO_INCREMENT  PRIMARY KEY,
	house_id int UNSIGNED NOT NULL,
	date_from datetime NOT NULL,
	date_till datetime NOT NULL
);




CREATE TABLE countries (
	id int UNSIGNED AUTO_INCREMENT  PRIMARY KEY,
	country_name varchar(50) NOT NULL UNIQUE
);
CREATE TABLE cities (
	id int UNSIGNED AUTO_INCREMENT  PRIMARY KEY,
	country_id int UNSIGNED NOT NULL,
	city_name varchar(100) NOT NULL
);




CREATE TABLE orders (
	id int UNSIGNED AUTO_INCREMENT  PRIMARY KEY,
	house_id int UNSIGNED NOT NULL,
	user_id int UNSIGNED NOT NULL,
	date_from datetime NOT NULL,
	date_till datetime NOT NULL,
	total_price int UNSIGNED NOT NULL,
	order_status_id int UNSIGNED NOT NULL
);

CREATE TABLE order_statuses (
	id int UNSIGNED AUTO_INCREMENT  PRIMARY KEY,
	status varchar(100)
);
INSERT INTO order_statuses (status) VALUES ('Confirmed by the owner and waiting for payment'), ('Confirmed and payed'), ('Waiting for confirmation from the owner');

CREATE TABLE guest_list (
	id int unsigned AUTO_INCREMENT  PRIMARY KEY,
	order_id int UNSIGNED NOT NULL,
	user_id int UNSIGNED NOT NULL
);





CREATE TABLE photos (
	id int UNSIGNED AUTO_INCREMENT  PRIMARY KEY,
	photo_link varchar(100),
	target_type_id int UNSIGNED NOT NULL,
	target_id int UNSIGNED NOT NULL
);

CREATE TABLE photo_target_types (
	id int UNSIGNED AUTO_INCREMENT  PRIMARY KEY,
	name varchar(20)
);
INSERT INTO photo_target_types(name) VALUES ('House'), ('Profile'), ('Attachment');


ALTER TABLE users
	ADD CONSTRAINT users_user_type_id_fk
	FOREIGN key(user_type_id) REFERENCES user_types(id),
	ADD CONSTRAINT users_sex_id_fk
	FOREIGN key(sex_id) REFERENCES sex_types(id),
	ADD CONSTRAINT users_hometown_id_fk
	FOREIGN key(hometown_id) REFERENCES cities(id),
	ADD CONSTRAINT users_country_id_fk
	FOREIGN key(country_id) REFERENCES countries(id),
	ADD CONSTRAINT users_photo_id_fk
	FOREIGN key(photo_id) REFERENCES photos(id),
	ADD CONSTRAINT users_identity_status_id_fk
	FOREIGN key(identity_status_id) REFERENCES identity_status(id);

ALTER TABLE user_bookmarks
	ADD CONSTRAINT user_bookmarks_user_id_fk
	FOREIGN key(user_id) REFERENCES users(id),
	ADD CONSTRAINT user_bookmarks_house_id_fk
	FOREIGN KEY(house_id) REFERENCES house_info(id);

ALTER TABLE testimonials 
	ADD CONSTRAINT testimonials_target_type_id_fk
	FOREIGN key(target_type_id) REFERENCES target_type(id),
	ADD CONSTRAINT testimonials_target_id_fk
	FOREIGN key(target_id) REFERENCES users(id),
	ADD CONSTRAINT testimonials_by_user_id_fk
	FOREIGN key(from_user_id) REFERENCES users(id);

ALTER TABLE messages 
	ADD CONSTRAINT messages_to_user_id_fk
	FOREIGN key(to_user_id) REFERENCES users(id),
	ADD CONSTRAINT messages_from_user_id_fk
	FOREIGN key(from_user_id) REFERENCES users(id),
	ADD CONSTRAINT messages_report_type_id_fk
	FOREIGN key(report_type_id) REFERENCES report_types(id);

ALTER TABLE house_info 
	ADD CONSTRAINT house_info_owner_id_fk
	FOREIGN key(owner_id) REFERENCES users(id),
	ADD CONSTRAINT house_info_country_id_fk
	FOREIGN key(country_id) REFERENCES countries(id),
	ADD CONSTRAINT house_info_city_id_fk
	FOREIGN key(city_id) REFERENCES cities(id),
	ADD CONSTRAINT house_info_house_type_id_fk
	FOREIGN key(house_type_id) REFERENCES house_types(id);

ALTER TABLE other_owners 
	ADD CONSTRAINT other_owners_user_id_fk
	FOREIGN key(user_id) REFERENCES users(id),
	ADD CONSTRAINT other_owners_house_id_fk
	FOREIGN key(house_id) REFERENCES house_info(id);

ALTER TABLE advantages 
	ADD CONSTRAINT advantages_house_id_fk
	FOREIGN key(house_id) REFERENCES house_info(id),
	ADD CONSTRAINT advantages_advantage_type_id_fk
	FOREIGN key(advantage_type_id) REFERENCES advantage_types(id);

ALTER TABLE beds 
	ADD CONSTRAINT beds_house_id_fk
	FOREIGN key(house_id) REFERENCES house_info(id),
	ADD CONSTRAINT beds_bed_type_id_fk
	FOREIGN key(bed_type_id) REFERENCES bed_types(id);

ALTER TABLE facilities
	ADD CONSTRAINT facilities_house_id_fk
	FOREIGN key(house_id) REFERENCES house_info(id),
	ADD CONSTRAINT facilities_facility_type_id_fk
	FOREIGN key(facility_type_id) REFERENCES facility_types(id);

ALTER TABLE available_dates 
	ADD CONSTRAINT available_dates_house_id_fk
	FOREIGN key(house_id) REFERENCES house_info(id);	

ALTER TABLE cities
	ADD CONSTRAINT cities_country_id_fk
	FOREIGN key(country_id) REFERENCES countries(id);

ALTER TABLE orders
	ADD CONSTRAINT orders_house_id_fk
	FOREIGN key(house_id) REFERENCES house_info(id),
	ADD CONSTRAINT orders_user_id_fk
	FOREIGN key(user_id) REFERENCES users(id),
	ADD CONSTRAINT orders_order_status_id_fk
	FOREIGN key(order_status_id) REFERENCES order_statuses(id);

ALTER TABLE guest_list 
	ADD CONSTRAINT guest_list_order_id_fk
	FOREIGN key(order_id) REFERENCES orders(id),
	ADD CONSTRAINT guest_list_user_id_fk
	FOREIGN key(user_id) REFERENCES users(id);

ALTER TABLE photos 
	ADD CONSTRAINT photos_target_type_id_fk
	FOREIGN key(target_type_id) REFERENCES photo_target_types(id);



CREATE INDEX guests_amount_idx ON house_info(guests_amount); -- to offer users fast search based on guests amount
CREATE INDEX bed_amount_idx ON house_info(bed_amount); -- to offer users fast search based on beds amount
CREATE INDEX price_idx ON house_info(price); -- to offer users fast search based on price
CREATE INDEX adress_idx ON house_info(adress); -- to offer users fast search based on location

CREATE INDEX date_from_idx ON available_dates(date_from);
CREATE INDEX date_till_idx ON available_dates(date_till);

CREATE INDEX name_idx ON users(name);
CREATE INDEX surname_idx ON users(surname);
CREATE INDEX phone_idx ON users(phone_number);

CREATE INDEX post_date_idx ON testimonials(post_date); -- to sort by testimonial date
