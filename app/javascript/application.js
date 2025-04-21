// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import { Application } from "@hotwired/stimulus"

// Initialize Stimulus
const application = Application.start()
window.Stimulus = application

// Import React application
import "./application/index.jsx"
