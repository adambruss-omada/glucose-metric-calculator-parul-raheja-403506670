# Glucose Metric Calculator

A Ruby on Rails application with React frontend for computing glucose metrics.

## Prerequisites

- Ruby 3.1.3
- Rails 7.1.5
- Node.js 18 or higher
- Yarn package manager
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

2. Install Ruby dependencies:
```bash
bundle install
```

3. Install JavaScript dependencies:
```bash
yarn install
```

4. Build JavaScript assets:
```bash
yarn build
```

5. Set up the database:
```bash
bundle exec rails db:create db:setup db:seed
```

6. Start the development server:
```bash
bin/dev
```

The application will be available at `http://localhost:3000`

## Development

### Frontend Development

The application uses React for the frontend with esbuild for bundling. Key files and directories:

- `app/javascript/application.js` - Main JavaScript entry point
- `app/javascript/application/` - React components directory
- `app/assets/builds/` - Compiled JavaScript assets

#### Building JavaScript Assets

For development with automatic rebuilding:
```bash
yarn build:watch
```

The watch mode will automatically rebuild your JavaScript assets whenever you make changes to your React components or JavaScript files.

### Testing

The project uses RSpec for testing. To run the test suite:

```bash
bundle exec rspec
```

### Docker Support

[Add Docker setup instructions here]

## Features

- Ruby on Rails 7.1.5
- React frontend with esbuild bundling
- SQLite3 database
- RSpec for testing
- Factory Bot for test data generation
- Docker support for containerization

## Technology Stack

- **Backend**: Ruby on Rails 7.1.5
- **Frontend**: React 19
- **Database**: SQLite3
- **JavaScript Bundler**: esbuild
- **Testing**: RSpec, Factory Bot

## Contributing

1. Fork the repository
2. 
