# Fleetblox Crew - Enhanced Technical Documentation

## 1. Project Overview

The Fleetblox Crew App is a Flutter-based mobile application designed for employees to manage their daily assigned tasks. The application supports both iOS and Android platforms and follows a modern, scalable architecture with enterprise-grade security and performance optimizations.

## 2. Technical Specifications

### Development Environment
- **Flutter Version**: 3.32.4
- **Dart SDK**: ^3.8.0
- **JDK Version**: 17.0.12
- **Android Studio**: Ladybug Feature Drop | 2024.2.2
- **Xcode**: Version 16.4
- **Swift Version**: Swift 5

### Local Project Setup
- Clone from git: https://github.com/AI-car-damage-recognition/Mobile-APP-Flutter.git
- Setup Flutter environment with fvm: https://fvm.app/documentation/getting-started/installation
- Follow the Environment Configuration below ⬇️

### Environment Configuration
The application supports multiple environments (Development and Production) with separate configurations:
- Environment variables stored in `env.dart`
- Required variables:
  - `AI_JWT_TOKEN`
  - `MAP_KEY`
  - `SENTRY_DSN`

## 3. Architecture & Project Structure

The project follows a **feature-first architecture** with clear separation of concerns and enterprise-grade patterns:

```
lib/
├── core/
│   ├── constants/        # App constants, API endpoints, assets
│   ├── l10n/             # Localization files and generated code
│   └── router/           # Routing configuration and bindings
├── features/             # Feature modules (business domains)
│   ├── auth/             # Authentication feature
│   ├── my_task/          # Task management feature
│   ├── inspection/       # Car inspection feature
│   └── ...               # Other business features
├── shared/               # Shared components and utilities
│   ├── api/              # API client, interceptors, exceptions
│   ├── enums/            # Application enums
│   ├── extensions/       # Dart extensions
│   ├── model/            # Shared data models
│   ├── repository/       # Repository interfaces and implementations
│   ├── services/         # Service layer with dependency injection
│   ├── tiles/            # Reusable UI tiles
│   ├── utils/            # Utility functions
│   └── widgets/          # Shared UI widgets
├── main.dart             # Application entry point
├── main_dev.dart         # Development environment entry point
├── main_prod.dart        # Production environment entry point
├── my_app.dart           # Common app configuration
└── env.dart              # Environment configuration
```

### Architecture Patterns

1. **Repository Pattern**: Clean separation between data sources and business logic
2. **Service Locator Pattern**: Dependency injection using GetIt
3. **Observer Pattern**: Reactive state management with GetX
4. **Interceptor Pattern**: HTTP request/response interception for auth and error handling

## 4. Key Dependencies & Implementation

### 1. State Management
- **Library**: GetX
- **Usage**: Controllers manage state and business logic across screens and services
- **Benefits**: Reactive programming, automatic memory management, simplified state management

### 2. UI Components
- **flutter_screenutil**: Responsive UI design with screen adaptation
- **google_fonts**: Custom typography implementation
- **flutter_svg**: Vector graphics rendering for car diagrams
- **cached_network_image**: Optimized image loading and caching

### 3. Authentication & Security
- **flutter_secure_storage**: Encrypted local storage for sensitive data
- **local_auth**: Biometric authentication (fingerprint/face ID)
- **jwt_decoder**: JWT token parsing and validation
- **Custom Auth Interceptor**: Automatic token refresh and session management

### 4. Firebase Integration
- **firebase_core**: Firebase initialization and configuration
- **firebase_messaging**: Push notification handling
- **Sentry Integration**: Error tracking and crash reporting

### 5. Maps & Location
- **google_maps_flutter**: Interactive map integration
- **location**: GPS and location services
- **permission_handler**: Runtime permission management

### 6. Networking & API
- **dio**: Advanced HTTP client with interceptors
- **connectivity_plus**: Network connectivity monitoring
- **socket_io_client**: Real-time WebSocket communication

### 7. Media & Files
- **camera**: Direct camera access for VIN and inspection photos
- **image_picker**: Gallery and camera image selection
- **file_picker**: Document and file handling

## 5. API & Network Architecture

### HTTP Client Implementation
```dart
class ApiClient {
  // Custom Dio configuration with interceptors
  // Automatic token management
  // Centralized error handling
  // Request/response logging
}
```

### Authentication Flow
1. **Token Management**: JWT access and refresh token handling
2. **Auto-Refresh**: Automatic token refresh on 401 responses
3. **Session Management**: Secure storage and session persistence
4. **Biometric Integration**: Optional biometric authentication

### Error Handling Strategy
- **Centralized Error Interceptor**: Unified error handling across all API calls
- **Sentry Integration**: Automatic error reporting and crash analytics
- **User-Friendly Messages**: Localized error messages for better UX
- **Retry Logic**: Automatic retry for network failures

### Real-Time Communication
- **WebSocket Integration**: Real-time task updates and notifications
- **Socket Reconnection**: Automatic reconnection with token refresh
- **Event Handling**: Structured event handling for different message types

## 6. Security Implementation

### 1. Code Obfuscation
- Production builds include code obfuscation
- Debug symbols management for crash reporting
- Split debug info for optimized builds

### 2. Secure Storage
- Encrypted local storage for sensitive data
- Secure token storage with automatic cleanup
- Biometric authentication integration

### 3. Network Security
- HTTPS enforcement for all API communications
- Certificate pinning (if implemented)
- Request/response encryption

### 4. Environment Protection
- Environment-specific configurations
- Sensitive data isolation
- Build-time environment validation

## 7. Performance Optimizations

### 1. Image Optimization
- Cached network images with placeholder support
- Image compression and format optimization
- Lazy loading for large image galleries

### 2. Memory Management
- Automatic memory management with GetX
- Efficient list rendering with pagination
- Resource cleanup in controllers

### 3. Network Optimization
- Request caching and deduplication
- Optimized API payload sizes
- Connection pooling and reuse

## 8. Localization & Internationalization

### Implementation
- **Flutter Localizations**: Built-in localization system
- **ARB Files**: Structured localization files
- **Generated Code**: Auto-generated localization classes
- **RTL Support**: Right-to-left language support

### Usage
```bash
# Generate localization files
flutter gen-l10n
```

## 9. Routing & Navigation

### GetX Routing Implementation
- **Centralized Route Management**: All routes defined in `router_paths.dart`
- **Dependency Injection**: Automatic controller injection with bindings
- **Deep Linking**: Support for deep link navigation
- **Route Guards**: Authentication and permission-based route protection

### Route Structure
```dart
class RouterPaths {
  static const String initializer = '/';
  static const String login = '/login';
  // ... other routes
}
```

## 10. Testing Strategy

### Current Testing
- **Manual Testing**: Comprehensive test cases via Google Sheets
- **UI Testing**: Widget testing for critical user flows
- **Integration Testing**: End-to-end testing for key features

## 11. Build & Deployment

### Android Build Commands
```bash
# Development Build
flutter build apk --flavor dev --target lib/main_dev.dart

# Production Build (Recommended with obfuscation)
flutter build apk --flavor prod --obfuscate --split-debug-info=./debug --target-platform android-arm,android-arm64 -t ./lib/main_prod.dart

# Production App Bundle (Recommended for Play Store)
flutter build appbundle --flavor prod --obfuscate --split-debug-info=./debug --release --target-platform android-arm,android-arm64 -t ./lib/main_prod.dart
```

### iOS Build Commands
```bash
# Staging Build
flutter build ipa --flavor dev --obfuscate --split-debug-info -t ./lib/main_dev.dart

# Production Build
flutter build ipa --flavor prod --obfuscate --split-debug-info -t ./lib/main_prod.dart
```

## 12. Core Features

### 1. Authentication
- Login with username & password
- Biometric authentication (fingerprint/face ID)
- Forgot password with OTP verification
- Secure session management

### 2. Task Management
- Real-time task notifications (push + WebSocket)
- Task filtering (Pending, In-progress, Completed, Reported issues)
- Advanced search functionality
- Priority-based task organization
- Date-based task filtering

### 3. Inspection Features
- VIN verification with AI-powered image processing
- Car exterior inspection with damage detection
- Customizable damage reports
- Visual damage mapping on car diagrams
- Severity assessment and reporting

### 4. Communication
- Real-time chat with task assignees
- File attachment support
- Message history and search
- Push notification integration

### 5. Profile Management
- Personal information management
- License and credential storage
- Password change with OTP verification
- Biometric settings configuration

## 13. Monitoring & Analytics

### Error Tracking
- **Sentry Integration**: Comprehensive error tracking and crash reporting
- **Debug Symbols**: Proper debug symbol management for production builds
- **Performance Monitoring**: App performance metrics and monitoring

### Analytics
- **User Behavior**: Feature usage analytics
- **Performance Metrics**: App performance and crash analytics
- **Business Metrics**: Task completion and efficiency metrics

## 14. Future Enhancements

### Technical Improvements
1. **Automated Testing**: Comprehensive test coverage
2. **Performance Optimization**: Advanced caching and optimization
3. **Offline Support**: Offline-first architecture
4. **Microservices**: Backend service decomposition

### Feature Enhancements
1. **AI Integration**: Enhanced AI-powered features
2. **Real-time Collaboration**: Multi-user real-time features
3. **Advanced Analytics**: Business intelligence and reporting
4. **Integration APIs**: Third-party system integrations

## 15. Maintenance & Support

### Code Quality
- **Static Analysis**: Automated code quality checks
- **Code Review**: Peer review process
- **Documentation**: Comprehensive code documentation
- **Refactoring**: Regular code refactoring and optimization

### Support Process
- **Issue Tracking**: Structured issue management
- **Release Management**: Version control and release planning
- **User Support**: Technical support and troubleshooting
- **Performance Monitoring**: Continuous performance monitoring

---

This enhanced documentation provides a comprehensive overview of the Fleetblox Crew App's technical architecture, implementation details, and best practices for maintenance and future development. 