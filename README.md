# Ride-Share App (Frontend with Dummy Data)

This **Ride-Share App** is a test project built to evaluate and challenge my mobile development skills. The goal was to **complete the full frontend** of a ride-sharing platform using **dummy model data** while learning and implementing a new state management approach – **Cubit**. For UI I picked a design from dribble.com

The app provides the basic foundation of a real-world ride-hailing system, including user location detection, map integration, and structured navigation using `onGenerateRoute`.

---

## Project Goals

- Test how quickly and effectively I can build a complete app frontend.
- Learn and apply **Cubit** as a new state management solution.
- Integrate **Google Maps API** and **location services**.
- Experiment with **GetStorage** for simple local storage (first-time usage).
- Practice modular and scalable routing using `onGenerateRoute`.

---

## Features

### Routing & Navigation
- Structured routing using **`onGenerateRoute`** for clean and centralized route management.
- Named routes support for better scalability and route tracking.

### Google Maps Integration
- Map display using **Google Maps API**.
- User’s **current location fetched** via device location services.
- Initial map camera position based on live location.

### State Management
- Implemented **Cubit** from `flutter_bloc` for managing app states (e.g., map loading, user data).
- Organized Cubit logic in a scalable and testable way.

### Local Storage
- **GetStorage** used for the first time to persist **user credentials** locally in JSON format.
- Efficient way to simulate login and store minimal user session data.

### Dummy Data
- All user and ride data is simulated using **hardcoded model classes**.
- Useful for testing frontend workflows like map interactions, navigation, and data flow.

---

## Tech Stack

| Technology         | Usage                                 |
|--------------------|----------------------------------------|
| **Flutter**        | Cross-platform UI toolkit              |
| **Dart**           | Programming language                   |
| **Cubit (flutter_bloc)** | State management             |
| **GetStorage**     | Local storage for user data            |
| **Google Maps API**| Map rendering and location visualization |
| **Location Package**| Accessing current GPS location         |
| **onGenerateRoute**| App-wide navigation control            |

---
