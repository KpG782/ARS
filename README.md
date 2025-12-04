# 🚗 ARS - Auto Repair Services

> On-demand mechanic platform connecting car owners with verified mechanics in the Philippines.

[![Flutter](https://img.shields.io/badge/Flutter-3.16+-02569B?logo=flutter)](https://flutter.dev)
[![Supabase](https://img.shields.io/badge/Supabase-Backend-3ECF8E?logo=supabase)](https://supabase.com)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

## 🎯 Overview

**ARS** is a "Grab for Mechanics" platform enabling:
- 👤 **Customers**: Find mechanics, book services, track real-time
- 🔧 **Mechanics**: Receive requests, manage jobs, get paid
- 👨‍💼 **Admins**: Verify mechanics, monitor platform

**Target**: 10,000+ customers, 500+ mechanics in Metro Manila

---

## 🏗️ Architecture

### Single App Design
```
┌────────────────────────────┐
│  ARS Mobile (Flutter)      │
│  - Customer Features       │
│  - Mechanic Features       │
│  - Shared Components       │
└────────────────────────────┘
         +
┌────────────────────────────┐
│  Admin Portal (Next.js)    │
│  - Dashboard & Analytics   │
└────────────────────────────┘
```

**Why?** 60% faster development, shared codebase, scalable.

---

## 🛠️ Tech Stack

| Layer | Technology |
|-------|-----------|
| **Mobile** | Flutter 3.x + Dart 3.x |
| **Backend** | Supabase (PostgreSQL) |
| **State** | BLoC Pattern |
| **Maps** | Google Maps API |
| **Chat** | Stream Chat |
| **AI** | Google Gemini |
| **Payment** | PayMongo (GCash) |
| **Admin** | Next.js 14 + TypeScript |

---

## 📁 Project Structure

```
lib/
├── core/                    # Shared utilities
│   ├── config/             # Theme, routes
│   ├── error/              # Error handling
│   └── widgets/            # Reusable UI
│
├── features/               # Feature modules
│   ├── authentication/
│   ├── customer_home/
│   ├── mechanic_home/
│   ├── service_booking/
│   ├── real_time_tracking/
│   ├── chat_messaging/
│   ├── payment_processing/
│   └── ai_assistant/
│
└── main.dart
```

Each feature follows **Clean Architecture**:
```
feature/
├── data/         # Models, API calls
├── domain/       # Business logic
└── presentation/ # UI (BLoC + Pages)
```

---

## 🚀 Quick Start

### Prerequisites
```bash
flutter doctor -v
# Flutter 3.16+ | Dart 3.2+
```

### Installation

1. **Clone & Install**
```bash
git clone https://github.com/yourusername/ars_app.git
cd ars_app
flutter pub get
```

2. **Environment Setup**

Create `.env`:
```env
SUPABASE_URL=your_url_here
SUPABASE_ANON_KEY=your_key_here
GOOGLE_MAPS_API_KEY=your_key_here
GEMINI_API_KEY=your_key_here
```

3. **Database Setup**

- Create Supabase project at [supabase.com](https://supabase.com)
- Run SQL schema from `database/schema.sql`
- Enable Row Level Security

4. **Run**
```bash
flutter run
```

---

## 📦 Key Dependencies

```yaml
# State Management
flutter_bloc: ^8.1.6
get_it: ^7.7.0         # DI
injectable: ^2.6.0

# Backend
supabase_flutter: ^2.10.3

# Features
google_maps_flutter: ^2.14.0
stream_chat_flutter: ^7.2.2
google_generative_ai: ^0.2.3
geolocator: ^10.1.1

# Utils
dartz: ^0.10.1         # Functional programming
equatable: ^2.0.7      # Value equality
```

---

## 🗓️ Development Roadmap

### Phase 1: Foundation (Weeks 1-4)
- ✅ Project setup
- ✅ Database schema
- 🔄 Authentication system
- 🔄 Core architecture

### Phase 2: Customer Features (Weeks 5-10)
- 📋 Dashboard & profile
- 📋 Mechanic finder (maps)
- 📋 Booking system
- 📋 Real-time tracking

### Phase 3: Mechanic Features (Weeks 11-14)
- 📋 Job management
- 📋 Navigation to customer
- 📋 Profile & verification
- 📋 Earnings tracking

### Phase 4: Shared Features (Weeks 15-18)
- 📋 Chat messaging
- 📋 Payment (PayMongo)
- 📋 Ratings & reviews
- 📋 AI assistant

### Phase 5: Admin Portal (Weeks 19-20)
- 📋 Next.js dashboard
- 📋 User management
- 📋 Analytics

### Phase 6: Launch (Weeks 21-24)
- 📋 Testing & optimization
- 📋 App store submission
- 📋 Marketing

---

## 🧪 Testing

```bash
# Unit tests
flutter test

# Integration tests
flutter test integration_test

# Coverage
flutter test --coverage
```

---

## 🚢 Deployment

### Mobile Apps
```bash
# Android
flutter build apk --release
flutter build appbundle

# iOS
flutter build ipa
```

### Admin Portal
```bash
cd admin_portal
npm run build
vercel deploy
```

---

## 📱 Features

### For Customers
- 🔍 Find nearby mechanics on map
- 📅 Book services with AI diagnosis
- 📍 Track mechanic in real-time
- 💬 Chat with mechanic
- 💳 Pay via GCash/Card
- ⭐ Rate & review

### For Mechanics
- 📬 Receive service requests
- ✅ Accept/reject jobs
- 🗺️ Navigate to customer
- 📸 Document repairs
- 💰 Track earnings
- 📊 View performance stats

### For Admins
- ✅ Verify mechanics
- 👥 Manage users
- 📊 View analytics
- 🚨 Handle disputes

---

## 🔐 Security

- Row Level Security (RLS) in Supabase
- JWT authentication
- Encrypted payments via PayMongo
- API key protection with `.env`

---

## 🤝 Contributing

1. Fork the repository
2. Create feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add AmazingFeature'`)
4. Push to branch (`git push origin feature/AmazingFeature`)
5. Open Pull Request

**Code Style**: Follow [Effective Dart](https://dart.dev/guides/language/effective-dart)

---

## 📄 License

This project is licensed under the MIT License - see [LICENSE](LICENSE) file.

---

## 📞 Contact

**Developer**: Your Name  
**Email**: your.email@example.com  
**GitHub**: [@yourusername](https://github.com/yourusername)


---

## ⭐ Show Your Support

Give a ⭐️ if this project helped you!

---

**Built with ❤️ using Flutter**