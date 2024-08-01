init-network:
	docker network create weather_app_network

run-db: # Run the database
	docker compose up --build db

run-app-dev: # Run the app in development mode
	docker compose up --build app-dev

run-app-prod: # Run the app in production mode
	docker compose up --build app-prod

run-scheduler: # Run the scheduler
	docker compose up --build scheduler

stop: # Stop all the containers
	docker compose down

run-reset-db: # Run the database and reset the data
	docker compose down -v
	sudo rm -rf ./db_data