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

## Description
Disbursements are done weekly on Monday.
We disburse only orders which status is completed.
The disbursed amount has the following fee per order:
1% fee for amounts smaller than 50 €
0.95% for amounts between 50€ - 300€
0.85% for amounts over 300€

## Endpoint
Exposes the disbursements for a given merchant on a given week.
If no merchant is provided return for all of them.

```
@path [GET] /merchant/disbursements

@parameter (body)[integer](id)
@parameter (body, required)[date](week)
@response 200 merchant_disbursements (by week)
@response 400 Invalid parameters
@response 404 merchant not found
```

## Todo's
A lot can still be done to improve this code. Especially in the controller.
Look at code for specifics.

Would have also liked to add a programmed job to run the Worker each Monday.
