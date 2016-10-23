Local PostgreSQL Installation Instructions

This file is best viewed with Word Wrap turned on...

-------------------------------------------------------------------------------

Windows - www.postgresql.org/download/

Follow the link for Windows and you download the latest version (Win x86-64 - Windows 64-bit). Currently (03.14.16) 9.5.1 is the latest and greatest version.

-------------------------------------------------------------------------------

Linux - www.postgresql.org/download/

Follow the link for your flavor of Linux which will have the command to install postgreSQL. 

*NOTE: You should first check and see if you already have PostgreSQL installed and many of the Linux distros already have this.

-------------------------------------------------------------------------------

Mac OS X - www.postgresql.org/download

Follow the link for several options to install postgreSQL.

The option I use on Mac OS X is the postgres.app. Super easy to install and turn the server on and off.

-------------------------------------------------------------------------------
At this point you have postgreSQL installed and running. 

To create the database the best way is to utilize the psql command line tool. Most installs will create a login of "postgres" or it might be your login for this machine.

Start psql and see if you are connecting to the database. You will see a prompt that is typically database

Once you are connected to the database with psql you will issue the following commands to create a database, connect to that database, create the tables, extensions and functions (aka stored procedures) and then populate them.

First lets see what logins are currently present.

postgres# \du

This will list all users. If you see one you can use then skip the next step.

postgres# CREATE ROLE shelterconnect WITH PASSWORD 'findm3ab3d' LOGIN CREATEDB;

This will create a role that can login and create databases.

Now we need to create the database. First lets see what databases are out there.

postgres#\l

This will list all databases.

postgres# CREATE DATABASE shelter_connect OWNER shelterconnect;

This owner is the role you create above. Now we need to connect to the database.

postres# /c shelter_connect

As you can see by looking at the prompt we are now connected this new database.

shelter_connect# 

Now we can create the tables, extensions and functions by running the following scripts. These should be in github.

On my machine this is the command and path to run.

- Step #1 - Create the tables, extensions and populate same...

shelter_connect# \i /Users/jreed/Development/ShelterConnect/database_setup/setup_populate_db.sql

- Step #2 - Create the function to return closest shelter(s). NOTE: If you did not create the login above "shelterconnect" you will need to edit the script, last line.

shelter_connect# \i /Users/jreed/Development/ShelterConnect/database_setup/build_sc_update_shelter.sql

- Step #3 - Create the function to update a shelter. NOTE: If you did not create the login above "shelterconnect" you will need to edit the script, last line.

shelter_connect# \i /Users/jreed/Development/ShelterConnect/database_setup/build_sc_update_shelter.sql

At this point you should be setup. You can get a postgreSQL client like pgAdmin3 or dataGrip and attach to the database and run queries and test things, etc.





