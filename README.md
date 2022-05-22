# POS 2.0 

This project stared out as a grade 12 school project. It used to use MS Access databases but has since been converted to support MYSQL.
I decided to release this application as open source software and will in my free time continue to try and improve it. 

Right now this system supports windows only (Driver Requirements). You can try and run it on linux using WINE but no support can be guaranteed for that. 

If you have any suggestions on how to improve the application let me know and we can work on improving the application together. Please note I am no expert programmer and am still learning a lot everyday.

-------------

Here is a list of basic features the program has so far : 
- Stock Management
- Basic Transactions Records
- Slip Printing of Transactions
- Admin and Sales users
- HTML Web Based Reports
- Employee management 
- Re-loadable Gift Cards
- Transaction records Linked to Employee ID.

The above list is not an all round list and some functionality might change as the software is continually developed.

We are working an getting decent instructions for the installation of the software and building releases with the a setup file.

---------------------------
Basic Install Instruction. 
- Upload the SQL File to your Mysql database so that you can have the default database tables created 
- Download the setup file from our release section. 
- Connect the Database and Application on first run.
- Default username and password for Admin account is Admin (Username) and admin (Password). We highly recommend you change this after first login.


--------------------------
For the ease of disclosure the setup will create the following folders for the application to work. It will also install the MYSQL driver needed for the software to function correctly. 

- POS 2.0 Folder in Program Files containing the Binary for the application
- POS 2.0 Folder in APPDATA that will contain the HTML Reports as well as the connection information for your database.
- It use to use the windows registry for storing certain information but I have since decided to move away from that approach as I don't like messing with the windows registry 