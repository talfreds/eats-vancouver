# 🍜 Eats Vancouver

> Discover new restaurants, happy hours & social deals in Vancouver, BC — built with Flutter Web.

![Flutter](https://img.shields.io/badge/Flutter-3.x-blue?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.x-blue?logo=dart)
![Material 3](https://img.shields.io/badge/Material-3-coral?logo=materialdesign)

---

## ✨ Features

| Feature | Description |
|---|---|
| **New Spots** | Freshly opened Vancouver restaurants with review sentiment |
| **Happy Hours** | Curated happy hour deals across neighbourhoods |
| **Social Deals** | Instagram & TikTok promotions discoverable in-app |
| **Vibe Check™** | AI-aggregated sentiment summaries per venue |
| **Photo Gallery** | Horizontal scroll of crowd-sourced restaurant photos |
| **Share** | Native sharing via `share_plus` |
| **Mock Auth** | Simulated Google Sign-In (no Firebase key required) |

---

## 🏗 Directory Structure

```
lib/
├── main.dart                          # App entry point
├── app.dart                           # Root widget (MaterialApp.router)
├── core/
│   ├── router/app_router.dart         # go_router configuration
│   └── theme/app_theme.dart           # Custom Material 3 theme
├── features/
│   ├── auth/
│   │   ├── providers/auth_provider.dart
│   │   └── screens/auth_screen.dart
│   ├── discovery/
│   │   ├── models/restaurant.dart     # Data models
│   │   ├── providers/discovery_provider.dart
│   │   ├── repositories/mock_places_repository.dart
│   │   └── screens/discovery_screen.dart
│   └── detail/
│       └── screens/detail_screen.dart
└── shared/
    └── widgets/bouncy_button.dart     # Micro-animation button
```

---

## 🚀 Quick Start (GitHub Codespaces)

### 1. Open in Codespaces

Click **Code → Open with Codespaces** on the repository homepage. The devcontainer will install Flutter automatically.

### 2. Install dependencies

```bash
flutter pub get
```

### 3. Run the web server

```bash
flutter run -d web-server --web-hostname 0.0.0.0 --web-port 8080
```

### 4. Preview in browser

- Codespaces will detect port **8080** and offer to open a browser preview.
- Or navigate to the **Ports** tab → click the 🌐 globe icon next to port 8080.

---

## 🛠 Tech Stack

| Layer | Technology |
|---|---|
| Framework | Flutter 3.x + Dart 3.x |
| UI | Material 3 with custom `AppTheme` |
| Fonts | Google Fonts – Nunito |
| State | flutter_riverpod 2.x |
| Routing | go_router 13.x |
| Sharing | share_plus 9.x |
| Data | `MockPlacesRepository` (no API key needed) |

---

## 🗺 Colour Palette

| Role | Hex |
|---|---|
| Coral (primary) | `#FF6B6B` |
| Sunny (tertiary) | `#FFD93D` |
| Teal (secondary) | `#4ECDC4` |
| Cream (surface) | `#FFF8F0` |
| Charcoal (text) | `#2D2D2D` |

---

## 📦 Upgrading to Real APIs

1. Add your `GOOGLE_PLACES_API_KEY` / `YELP_FUSION_API_KEY` to `.env` or Codespaces secrets.
2. Implement `GooglePlacesRepository` / `YelpRepository` that implement `PlacesRepository`.
3. Swap `MockPlacesRepository` → real repository in `placesRepositoryProvider`.
4. Initialize Firebase with `FlutterFire CLI` and replace the mock `AuthNotifier`.

---

## 🧪 Running Tests

```bash
flutter test
```

---

*Built with ❤️ for Vancouver foodies.*
