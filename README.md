# 🌍 Location Selector App

This Flutter project demonstrates a country and state selection form using the BLoC architecture
pattern.
Users can select a country, then a state based on that country, and submit the data to proceed to
the next page.

---

## 📦 Features

- Fetch countries and states from remote API using `Dio`
- State management with `BLoC`
- Clean architecture with `Data Source`, `Repository`, `Domain`, and `Presentation` layers
- Form submission logic
- Unit tests for BLoC, repository, and data source layers
- Environment configuration using `.env`

---

## 🏗️ Project Structure

```bash
lib/
├── main.dart
├── core/
│ └── network/
│ │ └── network_service.dart
│ └── di/
│ │ └── service_locator.dart
├── feature/
│ └── home/
│ │ ├── data/
│ │ │ ├── models/
│ │ │ │ ├── country_response.dart
│ │ │ │ └── state_response.dart
│ │ │ └── sources/
│ │ │ │ └── location_data_source.dart
│ │ │ │ └── repositories/
│ │ │ │ │ └── location_repository_impl.dart
│ │ │ ├── domain/
│ │ │ │ ├── models/
│ │ │ │ │ ├── country_data.dart
│ │ │ │ │ └── state_data.dart
│ │ │ │ └── repositories/
│ │ │ │ │ └── location_repository.dart
│ │ └── presentation/
│ │ │ ├── bloc/
│ │ │ │ ├── home_bloc.dart
│ │ │ │ ├── home_event.dart
│ │ │ │ └── home_state.dart
│ │ │ └── data/
│ │ │ │ └── home_data.dart
│ │ │ └── pages/
│ │ │ │ └── home_page.dart
│ │ │ └── widgets/
│ │ │ │ └── custom_dropdown_widget.dart
│ │ │ │ └── error_view_widget.dart
│ └── summary/
│ │ └── data/
│ │ │ └── summary_data.dart
│ │ └── presentation/
│ │ │ └── pages/
│ │ │ │ └── summary_page.dart
```

---

### 🛠️ Approach

1. State Management:  
   Using BLoC (Business Logic Component) for managing the state of the application. This ensures a
   clear separation of concerns and makes the app scalable and testable.
2. Dependency Injection:  
   Utilizing GetIt as a service locator for managing dependencies. This simplifies the
   initialization and access of services like repositories, data sources, and BLoC instances.
3. Networking:  
   Using Dio for making HTTP requests. It provides powerful features like interceptors, request
   cancellation, and custom headers.
4. Environment Configuration:  
   Managing environment-specific variables (e.g., API keys, base URLs) with flutter_dotenv. This
   allows secure and flexible configuration.
5. Clean Architecture:  
   Following the Clean Architecture principles:
    - Data Layer: Handles API calls and data models.
    - Domain Layer: Contains business logic and repository interfaces.
    - Presentation Layer: Manages UI and state using BLoC.
6. Testing:
   Writing unit tests for BLoC, repositories, and data sources to ensure reliability and
   maintainability.

---

## 🚀 Getting Started

### ✅ Prerequisites

- `.env` file with the following keys:
    - `BASE_URL`: https://api.example.com
    - `API_KEY`: your-api-key

### 🛠️ Install Dependencies

```bash
flutter pub get
```

### 🔧 Run the App

```bash
flutter run
```

### 🧪 Run Tests

```bash
flutter test
```
