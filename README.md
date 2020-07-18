# WIP: Rails + TailwindCSS

Simple boilerplate using Rails 6 and TailwindCSS.

Also includes some additional:
* `dotenv`
* `mongoid`
* `redis`
* `sidekiq`

## Used libraries
* [MongoDB](https://www.mongodb.com/): document persistence for faster initial development
* [TailwindCSS](http://tailwindcss.com/): a utility-first CSS framework (not premade components)
* [Sidekiq-cron](https://github.com/ondrejbartas/sidekiq-cron): cron jobs used for notifying customers of their reservations

## Requirements
* Rails 6
* [Docker](https://www.docker.com/)
* [docker-compose](https://docs.docker.com/compose/)

## Setup
Install dependencies:
```
bundle install
```
