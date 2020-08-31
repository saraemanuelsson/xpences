# Xpences - Spending Tracker

A web app that allows a user to track their spending.

![homepage](https://user-images.githubusercontent.com/48181178/91712883-91a3e500-eb80-11ea-97be-df11819fa482.png)

![add-expense](https://user-images.githubusercontent.com/48181178/91712917-a41e1e80-eb80-11ea-8cc0-6927c332fe37.png)

![expenses](https://user-images.githubusercontent.com/48181178/91712924-a8e2d280-eb80-11ea-9983-36f3dd809f67.png)

![budget](https://user-images.githubusercontent.com/48181178/91712930-abddc300-eb80-11ea-8f60-06906156967a.png)

### How to run Xpences

To run this app you will need Ruby, Postgres and Sinatra to be installed on your device. Please carry out the following commands in your terminal:

createdb xpences [⏎]
psql -d xpences -f db/xpences.sql [⏎]
psql -d xpences -f db/xpences.sql [⏎]
ruby db/seeds.rb [⏎]
ruby app.rb

Sinatra will now use your device as a local server for the app to run. In your preferred web browser paste the following link into the address bar and begin using the app. http://localhost:4567/

To terminate sinatra in the terminal, either press control^c or exit the terminal and terminate the process.
