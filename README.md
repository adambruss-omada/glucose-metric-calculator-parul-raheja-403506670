# Glucose Metric Calculator

A Ruby on Rails application for computing glucose metrics.

## Prerequisites

- Ruby 3.1.3
- Rails 7.1.5
- SQLite3
- Bundler
- Docker (optional)

## Setup

### Local Development Setup

1. Clone the repository:
```bash
git clone <repository-url>
cd glucose-metric-calculator
```

2. Install dependencies:
```bash
bundle install
```

3. Set up the database:
```bash
bundle exec rails db:create db:setup db:seed
```

4. Start the development server:
```bash
bundle exec rails s
```

The application will be available at `http://localhost:3000`

## Development

### Testing

The project uses RSpec for testing. To run the test suite:

```bash
bundle exec rspec
```

### Docker Support


## Features

- Ruby on Rails 7.1.5
- SQLite3 database
- RSpec for testing
- Factory Bot for test data generation
- Docker support for containerization

## Contributing

1. Fork the repository

