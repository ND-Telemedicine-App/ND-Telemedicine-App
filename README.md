
# ND-Telemedicine-App

ND-Telemedicine-App is an mobile app project built with Flutter and Java Spring Boot. We manage the work flow on Jira and communicate through our Discord server. The documents of the technologies mentioned below:

* **Flutter**: https://docs.flutter.dev/ 
* **Spring Boot**: https://docs.spring.io/spring-boot/docs/current/reference/htmlsingle/
* **Jira**: [https://septteam4.atlassian.net/jira/software/projects/SEPTT4S/boards/3/roadmap?shared=&atlOrigin=eyJpIjoiMDVlMGZkZGM1OTY0NGIxMDk0ZjhmZDg0NDFlZjlkMzUiLCJwIjoiaiJ9](https://septteam4.atlassian.net/jira/software/projects/SEPTT4S/boards/3/roadmap?shared=&atlOrigin=eyJpIjoiMDVlMGZkZGM1OTY0NGIxMDk0ZjhmZDg0NDFlZjlkMzUiLCJwIjoiaiJ9)
* **Discord**: https://discord.gg/VJKmADxT

## Getting Started

ND-Telemedicine-App is a mobile application that can be used by anyone, allowing patients  to signup  
add their health information and make a profile, book an appointment with GP through  
calendar, text chat with Doctor, and  view their prescribed medicine. User also can add their  
status such fever, pain and so on.  Doctors(or GP)  can add their availabilities, chat with their  
client, prescribe  and manage  medicine, and view their patients’ health status  . The app can  
have super admin user to manage both type of users.

## How to Use 

**Step 1:**

Download or clone this repo by using the link below:

```
https://github.com/ND-Telemedicine-App/ND-Telemedicine-App.git
```

**Step 2:**

Go to project root and execute the following command in console to get the required dependencies: 

```
flutter pub get 
```

**Step 3:**

This project uses `inject` library that works with code generation, execute the following command to generate files:

```
flutter packages pub run build_runner build --delete-conflicting-outputs
```

or watch command in order to keep the source code synced automatically:

```
flutter packages pub run build_runner watch
```


## ND-Telemedicine-App Features:

* Sign In
* Sign Up
* Forgot Password
* Medical Info
* Personal Info
* Home
* List Doctors
* List Patients
* Prescription
* Booking Appointment
* User Notifications
* Chat
* Admin Dashboard
* Set Busy Time


### Libraries & Tools Used

* [Booking Calendar](https://pub.dev/packages/booking_calendar)
* [Cupertino Icons](https://pub.dev/packages/cupertino_icons)
* [Http](https://pub.dev/packages/http) 
* [Syncfusion Flutter Calendar](https://pub.dev/packages/syncfusion_flutter_calendar) 
* [Duration Picker](https://pub.dev/packages/duration_picker)


### Folder Structure
Here is the core folder structure which flutter provides.

```
nd-telemedicine-app/
|- android
|- build
|- ios
|- lib
|- test
```

Here is the folder structure we have been using in this project

```
lib/
|- api/
|- models/
|- screens/
|- services/
|- utils/
|- widgets/
|- main.dart
```

Now, lets dive into the lib folder which has the main code for the application.

```
1- api- Contains API functions to get and post.
2- models - Model of specific class as in Spring Boot backend.
3- screens - Contains all the screens of the app.
4- services —  Contains services of the app.
5- util — Contains the utilities/common functions of your application.
6- widgets — Contains the common widgets for your applications. For example, Button, TextField etc.
7- main.dart - This is the starting point of the application. All the application level configurations are defined in this file i.e, theme, routes, title, orientation etc.
```




## Conclusion
 If you liked ourwork, don’t forget to ⭐ star the repo to show your support.

