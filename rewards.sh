#!/bin/sh

arg1=$1

case $arg1 in
    "setup")
        echo -e "Seting up the app...\n"
        echo -e "Step 1 - Dropping docker instances if any\n"
        docker-compose down
        docker-compose rm -f
        echo -e "Step 2 - Building docker instances\n"
        docker-compose build --no-cache
        echo -e "Step 3 - Starting the builds\n"
        docker-compose up -d
        echo -e "Setup is complete. App is up and running. Visit http://localhost:3001 to access the app\n"
        ;;
    "stop")
        echo -e "Stopping the containers\n"
        docker-compose down
        ;;
    "start")
        echo -e "Start the containers\n"
        docker-compose up -d
        ;;
    "console")
        echo -e "Accessing backend app console\n"
        docker-compose exec backend rails console
        ;;
    "frontend:test")
        echo -e "Running frontend tests\n"
        docker-compose exec frontend npm run test
        ;;
    "backend:test")
        echo -e "Accessing backend app console\n"
        docker-compose exec -e RAILS_ENV=test backend rspec ./spec
        ;;    
    *)
        echo -n "Invalid option"
        ;;
esac            