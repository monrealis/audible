# Audible Library Loader

Loads personal Audible library (from OpenAudible file) into PostgreSQL database for querying support.

Instructions:
* `prepare.sh`
* `docker-compose build --no-cache`
* `docker-compose up`
* Login to `localhost:5432` (`postgres`/``)
* Query `select * from books`
