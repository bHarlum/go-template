# Default target
all: build

# Build the Docker image
build:
	@echo "Building Docker image..."
	docker-compose build

# Run the Docker container
run:
	@echo "Running Docker container..."
	docker-compose up -d app

# Stop the Docker container
stop:
	@echo "Stopping Docker container..."
	docker-compose down

# Clean up Docker resources
clean: stop
	@echo "Cleaning up..."
	docker-compose rm -f
	docker-compose rmi -f

db:
	@echo "Running Flyway migrations..."
	docker-compose run --rm flyway
	@echo "Generating SQL code..."
	docker-compose run --rm sqlc

# Generate SQL code using sqlc
sqlc:
	@echo "Generating SQL code..."
	docker-compose run --rm sqlc

# Run Flyway migrations
migrate:
	@echo "Running Flyway migrations..."
	docker-compose run --rm flyway

# Display help information
help:
	@echo "Makefile commands:"
	@echo "build  - Build the Docker image"
	@echo "run    - Run the Docker container"
	@echo "stop   - Stop and remove the Docker container"
	@echo "clean  - Stop the container and remove the Docker image"
	@echo "sqlc   - Generate SQL code using sqlc"
	@echo "migrate - Run Flyway migrations"
	@echo "help   - Display this help message"
	@echo "db     - Run Flyway migrations and generate SQL code"
	@echo "gen-migration - Generate a new migration file"

# Development-related targets

# Define the target to run the Bash script
gen-migration:
	@./scripts/gen-migration-file.sh