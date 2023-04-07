#CISC 332 Final Project Implementation
######Created by Ahoura Radpey
This is the implementation/demo part of the final  project for CMPE 332 - Database Management Systems W23.

The web page, built using HTML, CSS, JS, and PHP, accesses a MySQL database containing information about a branch of restaurants, and implements four functional requirements (as per the outline):

1. List all the orders made on a particular date.  The user should be asked for a  date and you will list the first and last name of the customer, the items ordered, the total amount of the order, the tip, and the name of the delivery person who delivered the order.
2. Provide a way to add a new customer to the database.  You will need to ask for all the customer information.  You should check to ensure that the customer doesn't already exist in the database.  An account should be created for them with $5.00 credit.
3. Create a table that shows dates on which orders were placed along with the number of orders on that date.
4. Allow the user to choose an employee and show their schedule for Monday to Friday.  Do not show the schedule for Saturday or Sunday, even if the employee works on those days.  For this functionality, you must retrieve all the employees and display them somehow on your web page so that the user can choose from those listed.

##Instructions:

1. Download and install XAMPP
2. Navigate to /XAMPP/htdocs folder, and clone "cisc332-project" repository into it
3. Start XAMPP MySQL Database and Apache Web Server
4. Create a new database called restaurantDB
5. Copy text contained in restaurantDB.txt into the SQL query box
6. Navigate to the RestaurantDB website, the homepage is restaurant.html
7. Navigate through with links
