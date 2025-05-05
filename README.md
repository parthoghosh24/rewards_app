# Thanx Rewards app

## Introduction
This app is the result of the exercise given as part of the 
developer interview.

## Project structure
It is as follows:
* **backend** - Contains the backend rails api app
* **frontend** - Contains the frontend react+vite app
* **docker-compose.yml** - Docker compose file for running the app
* **README.md** - This
* **rewards.sh** - Driver script


## System requirements
This app has been developed in MacOS (Sequoia 15.4.1). Since it is dockerized, it should run in linux and hopefully in windows, but on safer side please try to run it in a mac.

## Prerequisites
* `Docker desktop app` and `docker-compose` should be installed from [here](https://www.docker.com/products/docker-desktop/) and via a package manager respectively (for e,g, in mac, we can do `brew install docker-compose` if we have homebrew installed)

## Setup
* Change the permissions of `rewards.sh` using `chmod 755 ./rewards.sh`.
* Just run `./rewards.sh setup` from the root folder.

## Guide
* The frontend runs at http://localhost:3001 whereas the backend runs at http://localhost:3000
    *  Please authorize first before accessing any of the APIs as most of them (except signup and login) needs Access token for authentication.
    * To get access token, perform login if already registed. If not, then register first.
    * Once login is done, the access token could be accessed from the `authorization` response header. Copy the whole `Bearer <token>`.
    * Then paste it in the authorize to authorize in the API doc. Then the APIs could be accessed.  

* API docs could be accessed from http://localhost:3000/api-docs/index.html

* Various options of the runner script (`rewards.sh`) are as follows:
    * **setup** - As mentioned above, it installs and then run the app. It can be also used to reinstall the app in case any issue arises.
    * **start** - This starts the stopped containers
    * **stop** - This stops the containers
    * **console** - This provides access to backend rails console
    * **frontend:test** - This runs frontend tests
    * **backend:test** - This runs backend tests


## Things missed (or could have been Better)
* **Rails master key** - Ideally, we should not put `master.key` in our version control as that is intended for production setting. But kept it inside VC for this project as our app runs in localhost (development mode).
* **UI** - Frontend is not my strongest suit and thus I believe UI of the app is not up to the mark. Feels like a school project.
* **Frontend code** - Although Typescript has been used, but it has not been used properly in the code (there are ambiguous type issue which I was not able to resolve).
* **Frontend test** - I could not add more tests than what I have added given the time constraint.
* **Backend tests** - Some tests have been marked pending because I was not able to make them pass given the time constraint.
* **Logout in API docs** - The logout api doc is not functioning correctly.
* **Missed some tests in Backend** - Missed some tests in backend, especially related to controllers, serializers and concerns.
* **Code cleanup** - Code could have been more cleaner in general.
* **Docker configs** - Again, docker is not my strongest suit. I took help from internet to setup the docker so I am sure it is not perfect.








