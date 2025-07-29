# Pulse Check

A tiny uptime monitor inspired by Better Uptime - built in Rails & Vue with background jobs, monitoring logic, and real-time dashboards.

This is the backend API built with Ruby on Rails. It handles storing monitored URLs, pinging them on intervals via Sidekiq jobs, and exposing data for the frontend dashboard.

## 🌐 Live Demo

**App:** [https://pulse-check.fly.dev/](https://pulse-check.fly.dev/)

**Demo Account:**

- Email: `demo@example.com`
- Password: `password`

> ⚠️ **Note:** The app may be slow on first access since it's deployed on Fly.io with `min_machines_running = 0` and `auto_stop_machines = true` for both frontend and backend. The initial wait time is due to machines starting up.

## 🔗 Links

👉 Frontend repo: [pulse-check-frontend](https://github.com/MajdTaweel/pulse-check-frontend)
