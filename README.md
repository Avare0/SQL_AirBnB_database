# AirBnB Database

## Description
AirBnB is a perfect platform to search flats, apartments and other living facilities and rent them all over the world.
## Database Tasks

  **1. Store information about:**

 - Users
 - Order
 - Living facilities
 - Testimonials
 - Messages

**2. Provide necessary SQL request(procedures/functions/views) for front-end**

## Database structure

There are 3 main parts of the database:
 **1. User information**
 ![enter image description here](https://i.imgur.com/QwEV1fD.png)
 **2. Living facility information**
![enter image description here](https://i.imgur.com/xaZbvIF.png)
 **4. Order information**
 ![enter image description here](https://i.imgur.com/rwSm4EH.png)

**Also there are secondary parts of the database that helps to communicate with customers and owners and review them:**
 - **Messages**
![enter image description here](https://i.imgur.com/t3VYrMu.png)
 - **Testimonials**
 ![enter image description here](https://i.imgur.com/3VX5E7b.png)

Another auxiliary structures:
For **users** table:
 - **user_types** -- represents whether user is a guest, householder or both
 ![enter image description here](https://i.imgur.com/3tvOJ1l.png)
 - **identity_status** -- user ID confirmation status
![enter image description here](https://i.imgur.com/fZSo2Ms.png)
 - **user_bookmarks**
![enter image description here](https://i.imgur.com/Iec3QEQ.png)
 - **sex_types**
![enter image description here](https://i.imgur.com/z8Nzic6.png)

For **house_info** table:
 - **advantages, advantage_types** -- advantages of the living facility
![enter image description here](https://i.imgur.com/PHGNg1O.png)
![enter image description here](https://i.imgur.com/U6nUMMC.png)
 - **beds, bed_types** -- types of beds, cause it`s an essential parameter for houses
![enter image description here](https://i.imgur.com/Y4Xsvrm.png)
![enter image description here](https://i.imgur.com/ycI88Ob.png)
 - **available_dates**
![enter image description here](https://i.imgur.com/S7QTIwk.png)
 - **house_types** -- whether living facility is a flat, house or guesthouse
 ![enter image description here](https://i.imgur.com/L0Y8FBO.png)
 - **facilities, facility_types**
![enter image description here](https://i.imgur.com/Ynm4X0X.png)
![enter image description here](https://i.imgur.com/CNg5zGM.png)
 - **other_owners** -- airbnb allows to choose a lot of owners of the house
![enter image description here](https://i.imgur.com/JXbHK0e.png)

For **messages** table: 

 - **report_types** -- message can be reported for spam, cheating etc.
![enter image description here](https://i.imgur.com/QIsTYdp.png)

For **orders** table:

 - **guest_list** -- other guests user ids
![enter image description here](https://i.imgur.com/kPV4HpH.png)
 - **order_statuses** -- whether order is confirmed by the householder, confirmed and payed or just paid
 ![enter image description here](https://i.imgur.com/ntSz5v2.png)

For **testimonials** table:

 - **target_type** -- Testimonials can be written for both: guests and houses(householders)
![enter image description here](https://i.imgur.com/lfCEgEZ.png)

For **photos** table:
 - **photo_target_types** -- photo can be uploaded for the profile, living facility gallery or as an attachment to the message
 ![enter image description here](https://i.imgur.com/Bchk3UE.png)

**Location** tables:
 - **countries**
![enter image description here](https://i.imgur.com/AsSNvxz.png)
 - **cities**
![enter image description here](https://i.imgur.com/an7MNlz.png)
## Database procedures and function
**Functions:**
 - **user_name(id)** - returns user`s full name
 - **house_name(id)** - returns house_name

**Procedures:**

 - **user_info(id)** - shows main information about the user
 - **user_testimonials(id)** - shows all user`s testimonials
 - **user_messages_to_someone(from_user_id, to_user_id)** - shows all user messages to someone
 - **last_user_messages(from_user_id, to_user_id)** - show user`s last message to all people he/her has ever written to(preview for the dialog on the messages main page)
 - **guests_for_order(order_id)** - shows all the guests for the certain order_id
 - **order_info(order_id)** - shows main information about the order
 - **user_orders(user_id)** - shows all user`s orders
 - **available_dates(house_id)** - shows all the available dates for living in the certain house
 - **other_house_owners(house_id)** - shows all secondary owners of the house
 - **house_facilities(house_id)** - shows all house facilities
 - **house_advantages(house_id)** - shows all house advantages
 - **house_beds(house_id)** - shows all house beds
 - **house_information(house_id)** - shows main information about living facility
 - **house_testimonials(house_id)** - shows testimonials for this house by the residents
 -  **search_house(city, house_type, guests, beds, bathrooms, price_amount)** - search using different parameters
 - **sort_by_price(city, house_type, guests, beds, bathrooms)** - sorting by price all the results
 - **cheapest_in_cities(countries)** - shows the cheapest variants in every city of the country
 - **most_expensive_in_cities(countries)** - shows the most expensive variants in every city of the country

## A few of words about data validity
In my opinion data validity have to be done on the frontend side as well as database security against SQL injection etc. So in this project there are a few triggers that validates the data.

