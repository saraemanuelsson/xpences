# Xpences - Spending Tracker

A web app that allows a user to track their spending.

### How to run Xpences

To run this app you will need Ruby, Postgres and Sinatra to be installed on your device. Please carry out the following commands in your terminal:

createdb xpences [⏎]
psql -d xpences -f db/xpences.sql [⏎]
psql -d xpences -f db/xpences.sql [⏎]
ruby db/seeds.rb [⏎]
ruby app.rb

Sinatra will now use your device as a local server for the app to run. In your preferred web browser paste the following link into the address bar and begin using the app. http://localhost:4567/

To terminate sinatra in the terminal, either press control^c or exit the terminal and terminate the process.
