# FlightCentre
## App's Architecture
I have followed the MVVM(MODEL-VIEW-VIEWMODEL) design pattern which allows me to write separate modules, making the code much cleaner, reusable and independent. It also makes the debugging and testing simpler as I can test debug and modules(modularity) in isolation which guarantees that code does not break. 
I have got separate classes that perform their unique task such as the JSON data is absorbed and settled in a Struct which maintains all the specified fields. The view controller class calls the Struct, so It will call the API to set up the data, and then the view can use it for the display purpose in the Table View by setting up the cells with necessary data. On clicking up the cell, it will navigate to another screen with the data and showing the details of a flight.

## Challenges
At first, I did not realise that I needed to have the flights divided into date sections. Then I had to implement the sorting of the flights by date in the FlightListViewController class by creating a new Struct which holds the flight list by particular dates using filters. I could have done it in the Struct where the API data is set. The benefit is that the primary Struct data(API data) will be preserved if needed somewhere else, promoting reusability.

## Required Pod to run the project
Alamofire - https://cocoapods.org/pods/Alamofire
