# Monash Code Challenge
---
Language: Swift 

The coding challenge for the Monash university app using the API `http://demo3299092.mockable.io/schedules` to query the list of courses in a week, parking available slots and the timetable of buses from and to Monash university campus. It was built by using **Xcode 11.3**

The project also runs unit testing to test the functions that have used in the project, which can be found in `CodingChallengeTests`

## Setup instructions
To install the appication 
* Open **CodingChallenge.xcodeproj** in the directory `/CodingChallenge`
* Run the application with Xcode to build the application.

## Solutions 

### Define the JSON 
The JSON will include the information `week`, `student`, `schedules`, `parkings`, `stops`.  

| Fields           | Description|           
| -------------- |:-------------:|
| week            |  the current week    | 
| student        |  student information |  
| schedules    |  list of course schedules|   
| parkings      |   list of course parking places  |   
| stops      |   list of course stops  |   
```
{
    "week" : 8,
    "student" : {
        "id": "305491",
        "name": "Kier"
    },
    "schedules": [
        {
            "start_time": "2020-03-13T10:00:00",
            "end_time": "2020-03-13T12:00:00",
            "course": "FIT1031",
            "class": "Lecture 01",
            "lecturer": "Arun",
            "room": "S4",
            "campus": "13 College Walk, Clayton"
        }
    ],
    "parkings": [
        {
            "name": "Clayton live feed",
            "slot": 645
        }
    ],
    "stops" : [
        {
            "departure" : "Clayton",
            "arrival": "Caufield",
            "predicted_arrival_date": "2020-03-13T06:04:05"
        }
    ]
}

```

### Following MVP design architecture

The default MVC architecture that Apple supports for iOS is good for a small project, but it is very hard to test because of the complicated ViewController. So, I use the MVP architecture to separate the coupling of the ViewController class into View class (ViewController) and Presenter class. The Presenter will handle the business logic, in this case, it loads the schedule data and then binding the data to the UI through `Delegation` pattern. Likewise, any errors that may happen while handling the business logic will be displayed as an alert view.


### Request and Deserialize JSON
The `APIRequest.swift` has been implemented to call the request deserialize the JSON response into `Timetable` instance. To decode the JSON, I have used Swift `Decodable` protocol. The model looks like this
```
// MARK: - Timetable
struct Timetable: Decodable {
    let week: Int
    let student: Student
    let schedules: [Schedule]
    let parkings: [Parking]
    let stops: [Stop]
}

// MARK: - Student
struct Student: Codable {
    let id, name: String
}

// MARK: - Schedule
struct Schedule: Decodable {
    let startTime, endTime, course, scheduleClass: String
    let lecturer, room, campus: String

    enum CodingKeys: String, CodingKey {
        case startTime = "start_time"
        case endTime = "end_time"
        case course
        case scheduleClass = "class"
        case lecturer, room, campus
    }
}

struct Parking: Decodable {
    let name: String
    let slot: Int
}


// MARK: - Stop
struct Stop: Decodable {
    let departure, arrival: String
    let predictedArrivalDate: String

    enum CodingKeys: String, CodingKey {
        case departure, arrival
        case predictedArrivalDate = "predicted_arrival_date"
    }
}

```
### Implement SystemService with Dendency Injection (DI)
The system service may contain the System Date, System Version. The purpose of this class is to improve the extendability and testability of the application. The users can now use the service in any places. Moreover, they can extend it to use for other purposes. 



### Unit testing
I have operated unit testing for the public functions of the application. For testing the failure case of URL request, I have created a MockFailSession which returns 500 status code. 
