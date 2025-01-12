# Colors for terminal output
BOLD := $(shell tput bold)
NORMAL := $(shell tput sgr0)
GREEN := $(shell tput setaf 2)
RED := $(shell tput setaf 1)

.PHONY: help install update clean lint format spec build run gen tidy shell setup recreate

help:
	@echo "$(BOLD)Available commands:$(NORMAL)"
	@echo "$(GREEN)make install$(NORMAL)        - Install all dependencies"
	@echo "$(GREEN)make update$(NORMAL)         - Update dependencies"
	@echo "$(GREEN)make clean$(NORMAL)          - Remove build artifacts"
	@echo "$(GREEN)make lint$(NORMAL)           - Check code style with golangci-lint"
	@echo "$(GREEN)make format$(NORMAL)         - Format code with gofmt"
	@echo "$(GREEN)make spec$(NORMAL)           - Run specs"
	@echo "$(GREEN)make build$(NORMAL)          - Build the Go binary"
	@echo "$(GREEN)make run$(NORMAL)            - Run the application"
	@echo "$(GREEN)make example$(NORMAL)        - Run application example"
	@echo "$(GREEN)make gen$(NORMAL)            - Generate project using goa"
	@echo "$(GREEN)make implementation$(NORMAL) - Generate project shell implementation"
	@echo "$(GREEN)make tidy$(NORMAL)           - Clean up go.mod and go.sum"
	@echo "$(GREEN)make shell$(NORMAL)          - Start an interactive shell"
	@echo "$(GREEN)make setup$(NORMAL)          - Initialize project structure"
	@echo "$(GREEN)make recreate$(NORMAL)       - Clean and reinstall dependencies"

install:
	@echo "$(BOLD)Installing dependencies...$(NORMAL)"
	go mod download
	@echo "$(GREEN)Dependencies installed!$(NORMAL)"

update:
	@echo "$(BOLD)Updating dependencies...$(NORMAL)"
	go get -u ./...
	go mod tidy
	@echo "$(GREEN)Dependencies updated!$(NORMAL)"

clean:
	@echo "$(BOLD)Cleaning project...$(NORMAL)"
	rm -rf ./bin ./build ./dist
	find . -type f -name '*.test' -delete
	find . -type f -name '*.out' -delete
	find . -type f -name '*.log' -delete
	@echo "$(GREEN)Clean complete!$(NORMAL)"

lint:
	@echo "$(BOLD)Running linter...$(NORMAL)"
	golangci-lint run ./... || (echo "$(RED)Linting failed!$(NORMAL)" && exit 1)
	@echo "$(GREEN)Linting passed!$(NORMAL)"

format:
	@echo "$(BOLD)Formatting code...$(NORMAL)"
	gofmt -s -w .
	goimports -w .
	@echo "$(GREEN)Formatting complete!$(NORMAL)"

spec:
	@echo "$(BOLD)Running tests...$(NORMAL)"
	go test ./... -cover || (echo "$(RED)Tests failed!$(NORMAL)" && exit 1)
	@echo "$(GREEN)Tests passed!$(NORMAL)"

build:
	@echo "$(BOLD)Building project...$(NORMAL)"
	go build -o bin/argos ./cmd/argos && go build -o bin/argos-cli ./cmd/argos-cli
	@echo "$(GREEN)Build complete! Binary located at ./bin/app$(NORMAL)"

run: build
	@echo "$(BOLD)Running application...$(NORMAL)"
	./bin/argos

example:
	@echo "$(BOLD)Running examples...$(NORMAL)"
	./bin/argos-cli --url="http://localhost:8000" argos multiply --a 9 --b 6
	./bin/argos-cli --url="grpc://localhost:8080" argos multiply --message '{"a": 1, "b": 2}'

gen:
	@echo "$(BOLD)Generating project...$(NORMAL)"
	goa gen argos/design
	@echo "$(GREEN)Generation complete! Generated at ./gen$(NORMAL)"

implementation:
	@echo "$(BOLD)Generating implementation shell...$(NORMAL)"
	goa example argos/design
	@echo "$(GREEN)Implementation shell generation complete!$(NORMAL)"

tidy:
	@echo "$(BOLD)Tidying up go.mod and go.sum...$(NORMAL)"
	go mod tidy
	@echo "$(GREEN)Tidy complete!$(NORMAL)"

shell:
	@echo "$(BOLD)Starting interactive shell...$(NORMAL)"
	bash

setup: clean
	@echo "Creating project structure..."
	mkdir -p bin
	mkdir -p build
	mkdir -p dist
	mkdir -p cmd pkg internal
	mkdir -p tests
	mkdir -p configs
	touch cmd/main.go
	touch {bin,build,dist,cmd,pkg,internal,tests,configs}/.keep
	@echo "$(GREEN)Project structure created successfully!$(NORMAL)"

recreate: clean install
	@echo "$(GREEN)Environment recreated successfully!$(NORMAL)"
