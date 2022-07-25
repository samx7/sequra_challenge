# Sequra Backend Coding Challenge

## Author
Andrea Samaniego de la Fuente
July, 2022

## Requirements
* Ruby v2.7.3p183+
* Rails v7.0.3+
* Postgres v14.4+

## Configuration
### 1. Database
Currently system-wide Postgres is used, which can be installed (and automatically run) via normal OS package managers
* MacOS
```
brew install postgres@14
brew services start postgres@14
```

### 2. Rails Setup
#### 2.1 Install gems
```bash
bundle install
```
### 2.2 Setup Databases
```bash
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake db:seed
```

## Testing
To run all tests
```bash
bundle exec rails test
```

## Running a Developer Server
```bash
bundle exec rails server
```
