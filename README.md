# Projex

### What?
> "Projex is a project for a university class, specifically CPE540 for the first semester of the academic year 2022/2023, we were instructed to create a full stack application for project tracking. This project is intended as a simulation for a "real world" case wherein a customer asks for an application and we as students have to form ourselves into teams of 8, split ourselves into groups within those teams, and work on individual tasks, and in the end we have to submit a fully-working application compelete with system architecture, uml and er considerations and diagrams." - Team 2

### Who?
We are team #2 of the class, the members are:

> **Ahmad ALMomani** - _socials_

> **Hashem Alayan** - _socials_

> **ALMotasem ALAdwan** - _socials_

> **Omar ALZoubi** - _socials_

> **Husni AbedAlsalam** - _socials_

> **Abedel Rahman Khader** - _socials_

> **Feras Hamdan** - _socials_

### Where?
The documentaion is going to be stored on **_github_** and on our public **_google drive_**, which can be found [here](https://drive.google.com/drive/folders/10edTz8_eHYdAUtCdXscKBvrBYNMmBp1P).

## In this repository
This repository contains the client application for Projex, we use _**flutter+dart**_ for UI and business logic.

## Build instructions
    1. Clone this repository
    2. cd <projex_folder>
    *3. dart pub global activate flutterfire_cli
    *4. flutterfire configure
    5. flutter pub get
    6. add assets/env.dat file with the following
        GOOGLE_CLIENT_ID=<THE_CLIENT_ID_FOR_OUR_PROJECT>

        To get the client id go to the firebase console https://console.firebase.google.com/project/projex-app
        -> Authentication -> Sign-in method
        -> Sign-in providers -> Google -> WebSDK configuration -> Web client ID

        copy the string and paste it after the "=" without the "< >" brackets
        
    7. flutter pub run build_runner build
    8. flutter build <platform>[ios,android,web]

    * Requires the firebase-cli tool https://firebase.flutter.dev/docs/overview#using-the-flutterfire-cli
    

## Contribution
> Contribution to the project is limited to team members only. fork this repository and submit pull requests.


