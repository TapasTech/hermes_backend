## Hermes
[![Build Status](https://travis-ci.org/TapasTech/hermes_backend.svg?branch=master)](https://travis-ci.org/TapasTech/hermes_backend) [![Code Climate](https://codeclimate.com/github/TapasTech/hermes_backend/badges/gpa.svg)](https://codeclimate.com/github/TapasTech/hermes_backend) [![Test Coverage](https://codeclimate.com/github/TapasTech/hermes_backend/badges/coverage.svg)](https://codeclimate.com/github/TapasTech/hermes_backend/coverage)

A Q&A Community supported by data.

Backend Graphql Server

### Ruby version

+ ruby: ~> 2.3.0
+ rails: ~> 5.0.0

### System dependencies

+ PostgreSQL: ~> 9.4

### Configuration

+ config/database.yml

### Database creation

```sh
bundle exec rails db:create
```

### Database initialization

```sh
bundle exec rails db:setup
```

### How to run the test suite

```sh
rspec
```

### Deployment instructions

Set variables in 'config/deploy/#{environment}.rb'

* Initialize

```sh
bundle exec mina #{environment} setup
```

and follow the instructions

* Update

```sh
bundle exec mina #{environment} deplay
```

### See also

+ [GraphQL Spec](http://facebook.github.io/graphql/)
+ [graphql-ruby](https://github.com/rmosolgo/graphql-ruby)
+ [graphql-mutable_type](https://github.com/TapasTech/graphql-mutable_type)