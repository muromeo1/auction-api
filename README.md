# Auction

A token based api for an Auction system.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development.

### Prerequisites

Things you need to install the project.

```
Postgres 	>= 12.14
Ruby 		== 3.2.0
Rails		== 7.0.4
```

#### Guide to install:

- [Ruby and Rails](https://gorails.com/setup/ubuntu/20.04)
- [PostgreSQL](https://www.postgresql.org/download/linux/ubuntu/)

### Installing and Running

How to setup the environment:

1 - Clone the project

```
git clone git@github.com:muromeo1/auction-interview.git
```

2 - Change config/database.yml to your postgres username and password

```yml
default: &default
  adapter: postgresql
  encoding: unicode
  host: localhost
  username: postgres
  password: postgres
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
```

3 - Setup database

```
rails db:create
rails db:migrate
```

4 - Run the project

```
rails s
```

Good to go!

## Endpoints
https://documenter.getpostman.com/view/25778360/2s935sohZ2

## Steps to use
1) Create an user
2) Copy your generated token
3) Place a bid (paste your token in authoriztion header)
4) Check highest bid so far

## Author

**Murilo Romeo** - *Ruby on Rails developer* - [muromeo1](https://github.com/muromeo1)
