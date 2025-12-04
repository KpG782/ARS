# 🚗 ARS (Auto Repair Services) - Complete Development Guide

> **Competition Goal:** Win 100,000 PHP | **Timeline:** 6 months | **Architecture:** Single Flutter App + Admin Web Portal

---

## 📋 Table of Contents

1. [Project Overview](#project-overview)
2. [Architecture Decision](#architecture-decision)
3. [Tech Stack](#tech-stack)
4. [Project Structure](#project-structure)
5. [Setup Instructions](#setup-instructions)
6. [Development Roadmap](#development-roadmap)
7. [Feature Implementation Guide](#feature-implementation-guide)
8. [Legal & Compliance](#legal-compliance)
9. [Testing Strategy](#testing-strategy)
10. [Deployment Guide](#deployment-guide)

---

## 🎯 Project Overview

**ARS** is an on-demand auto repair service platform connecting car owners with verified mechanics in the Philippines. Think "Grab for Mechanics."

### Key Features
- 👤 **Customer Side:** Find mechanics, book services, track in real-time, pay securely
- 🔧 **Mechanic Side:** Receive requests, manage jobs, navigate to customers, get paid
- 👨‍💼 **Admin Portal:** Manage users, verify mechanics, analytics, dispute resolution

### Target Users
- **Customers:** 10,000+ in first year
- **Mechanics:** 500+ verified professionals
- **Geographic Focus:** Metro Manila → National rollout

---

## 🏗️ Architecture Decision

### ✅ FINAL ARCHITECTURE: Single App + Admin Web

```
┌─────────────────────────────────────┐
│   ARS Mobile App (Flutter)          │
│   • Customer Features               │
│   • Mechanic Features               │
│   • Shared Components               │
└─────────────────────────────────────┘
                 +
┌─────────────────────────────────────┐
│   ARS Admin Portal (Next.js)        │
│   • Desktop Dashboard               │
│   • Analytics & Reports             │
└─────────────────────────────────────┘
```

**Why Single App?**
- ✅ 60% less development time
- ✅ Shared features (chat, payment, tracking)
- ✅ Users can become mechanics later
- ✅ Industry standard (Grab, Uber model)
- ✅ Fits 100k PHP budget

---

## 🛠️ Tech Stack

### Mobile App (Flutter)
```yaml
Framework: Flutter 3.x
Language: Dart 3.x
Architecture: Feature-First Clean Architecture
State Management: BLoC (flutter_bloc)
```

### Backend (Supabase)
```yaml
Database: PostgreSQL
Auth: Supabase Auth
Storage: Supabase Storage
Real-time: PostgreSQL triggers
Functions: Supabase Edge Functions
```

### Admin Portal (Next.js)
```yaml
Framework: Next.js 14
Language: TypeScript
UI: Tailwind CSS + shadcn/ui
Backend: Same Supabase instance
```

### AI Integration
```yaml
Primary: Google Gemini API
Fallback: OpenAI GPT-4
Use Cases: Diagnosis, recommendations, chatbot
```

### Payment
```yaml
Gateway: PayMongo
Methods: GCash, Card, Bank Transfer
```

### Key Packages
```yaml
# State Management
flutter_bloc: ^8.1.3
equatable: ^2.0.5

# Backend
supabase_flutter: ^2.0.0

# Dependency Injection
get_it: ^7.6.4
injectable: ^2.3.2

# Functional Programming
dartz: ^0.10.1

# Maps & Location
google_maps_flutter: ^2.5.0
geolocator: ^10.1.0

# Chat
stream_chat_flutter: ^7.0.0

# Payments
paymongo: ^1.0.0

# AI
google_generative_ai: ^0.2.0
```

---

## 📁 Project Structure

```
ars_app/
├── lib/
│   ├── core/                           # Shared across all features
│   │   ├── config/
│   │   │   ├── theme/
│   │   │   │   ├── app_theme.dart
│   │   │   │   ├── app_colors.dart
│   │   │   │   └── app_text_styles.dart
│   │   │   └── routes/
│   │   │       ├── app_router.dart
│   │   │       └── route_guards.dart
│   │   ├── constants/
│   │   │   ├── app_constants.dart
│   │   │   ├── api_constants.dart
│   │   │   └── asset_constants.dart
│   │   ├── error/
│   │   │   ├── failures.dart
│   │   │   └── exceptions.dart
│   │   ├── network/
│   │   │   ├── network_info.dart
│   │   │   └── api_client.dart
│   │   ├── usecases/
│   │   │   └── usecase.dart
│   │   ├── utils/
│   │   │   ├── validators.dart
│   │   │   ├── formatters.dart
│   │   │   ├── extensions.dart
│   │   │   └── logger.dart
│   │   └── widgets/
│   │       ├── custom_button.dart
│   │       ├── custom_textfield.dart
│   │       ├── loading_indicator.dart
│   │       └── error_widget.dart
│   │
│   ├── features/
│   │   │
│   │   ├── authentication/             # Feature 1: Auth (Shared)
│   │   │   ├── data/
│   │   │   │   ├── datasources/
│   │   │   │   │   ├── auth_remote_datasource.dart
│   │   │   │   │   └── auth_local_datasource.dart
│   │   │   │   ├── models/
│   │   │   │   │   └── user_model.dart
│   │   │   │   └── repositories/
│   │   │   │       └── auth_repository_impl.dart
│   │   │   ├── domain/
│   │   │   │   ├── entities/
│   │   │   │   │   └── user_entity.dart
│   │   │   │   ├── repositories/
│   │   │   │   │   └── auth_repository.dart
│   │   │   │   └── usecases/
│   │   │   │       ├── login_usecase.dart
│   │   │   │       ├── register_usecase.dart
│   │   │   │       ├── logout_usecase.dart
│   │   │   │       └── check_auth_status_usecase.dart
│   │   │   └── presentation/
│   │   │       ├── bloc/
│   │   │       │   ├── auth_bloc.dart
│   │   │       │   ├── auth_event.dart
│   │   │       │   └── auth_state.dart
│   │   │       ├── pages/
│   │   │       │   ├── splash_page.dart
│   │   │       │   ├── onboarding_page.dart
│   │   │       │   ├── role_selection_page.dart
│   │   │       │   ├── login_page.dart
│   │   │       │   └── register_page.dart
│   │   │       └── widgets/
│   │   │           ├── auth_form_widget.dart
│   │   │           └── social_login_buttons.dart
│   │   │
│   │   ├── user_profile/              # Feature 2: Profile (Shared)
│   │   │   ├── data/
│   │   │   ├── domain/
│   │   │   └── presentation/
│   │   │
│   │   ├── customer_home/             # Feature 3: Customer Dashboard
│   │   │   ├── data/
│   │   │   ├── domain/
│   │   │   └── presentation/
│   │   │       └── pages/
│   │   │           └── customer_home_page.dart
│   │   │
│   │   ├── mechanic_home/             # Feature 4: Mechanic Dashboard
│   │   │   ├── data/
│   │   │   ├── domain/
│   │   │   └── presentation/
│   │   │       └── pages/
│   │   │           └── mechanic_home_page.dart
│   │   │
│   │   ├── vehicle_management/        # Feature 5: Vehicles (Customer)
│   │   │   ├── data/
│   │   │   ├── domain/
│   │   │   └── presentation/
│   │   │
│   │   ├── mechanic_finder/           # Feature 6: Find Mechanics (Customer)
│   │   │   ├── data/
│   │   │   ├── domain/
│   │   │   └── presentation/
│   │   │
│   │   ├── service_booking/           # Feature 7: Booking (Customer)
│   │   │   ├── data/
│   │   │   ├── domain/
│   │   │   └── presentation/
│   │   │
│   │   ├── service_requests/          # Feature 8: Requests (Mechanic)
│   │   │   ├── data/
│   │   │   ├── domain/
│   │   │   └── presentation/
│   │   │
│   │   ├── job_management/            # Feature 9: Jobs (Mechanic)
│   │   │   ├── data/
│   │   │   ├── domain/
│   │   │   └── presentation/
│   │   │
│   │   ├── real_time_tracking/        # Feature 10: Tracking (Shared)
│   │   │   ├── data/
│   │   │   ├── domain/
│   │   │   └── presentation/
│   │   │
│   │   ├── chat_messaging/            # Feature 11: Chat (Shared)
│   │   │   ├── data/
│   │   │   ├── domain/
│   │   │   └── presentation/
│   │   │
│   │   ├── payment_processing/        # Feature 12: Payments (Shared)
│   │   │   ├── data/
│   │   │   ├── domain/
│   │   │   └── presentation/
│   │   │
│   │   ├── rating_review/             # Feature 13: Reviews (Shared)
│   │   │   ├── data/
│   │   │   ├── domain/
│   │   │   └── presentation/
│   │   │
│   │   ├── notifications/             # Feature 14: Notifications (Shared)
│   │   │   ├── data/
│   │   │   ├── domain/
│   │   │   └── presentation/
│   │   │
│   │   └── ai_assistant/              # Feature 15: AI Features
│   │       ├── data/
│   │       │   ├── datasources/
│   │       │   │   └── ai_remote_datasource.dart
│   │       │   └── repositories/
│   │       │       └── ai_repository_impl.dart
│   │       ├── domain/
│   │       │   ├── entities/
│   │       │   │   ├── ai_diagnosis_entity.dart
│   │       │   │   └── ai_suggestion_entity.dart
│   │       │   ├── repositories/
│   │       │   │   └── ai_repository.dart
│   │       │   └── usecases/
│   │       │       ├── diagnose_issue_usecase.dart
│   │       │       ├── suggest_services_usecase.dart
│   │       │       └── estimate_cost_usecase.dart
│   │       └── presentation/
│   │           ├── bloc/
│   │           ├── pages/
│   │           │   └── ai_diagnosis_page.dart
│   │           └── widgets/
│   │
│   ├── injection_container.dart        # Dependency Injection
│   └── main.dart                       # App Entry Point
│
├── test/                               # Unit & Widget Tests
├── integration_test/                   # Integration Tests
├── assets/                             # Images, Fonts, etc.
│   ├── images/
│   ├── icons/
│   └── fonts/
├── android/                            # Android Config
├── ios/                                # iOS Config
├── web/                                # Web Config (Admin redirect)
├── .env                                # Environment Variables
├── pubspec.yaml                        # Dependencies
└── README.md                           # This file
```

---

## 🚀 Setup Instructions

### Prerequisites
```bash
# Check Flutter installation
flutter doctor -v

# Required versions
Flutter: 3.16.0 or higher
Dart: 3.2.0 or higher
```

### Step 1: Clone & Setup
```bash
# Create project
flutter create --org com.ars ars_app
cd ars_app

# Open in VSCode
code .
```

### Step 2: Install Dependencies

Copy this to `pubspec.yaml`:
```yaml
name: ars_app
description: Auto Repair Services Application
publish_to: 'none'
version: 1.0.0+1

environment:
  sdk: '>=3.2.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter
  
  # State Management
  flutter_bloc: ^8.1.3
  equatable: ^2.0.5
  
  # Dependency Injection
  get_it: ^7.6.4
  injectable: ^2.3.2
  
  # Backend
  supabase_flutter: ^2.0.0
  
  # Functional Programming
  dartz: ^0.10.1
  
  # Network
  http: ^1.1.0
  internet_connection_checker: ^1.0.0+1
  
  # Local Storage
  shared_preferences: ^2.2.2
  
  # Maps & Location
  google_maps_flutter: ^2.5.0
  geolocator: ^10.1.0
  geocoding: ^2.1.1
  
  # Chat
  stream_chat_flutter: ^7.0.0
  
  # AI
  google_generative_ai: ^0.2.0
  
  # UI
  cupertino_icons: ^1.0.2
  flutter_svg: ^2.0.9
  cached_network_image: ^3.3.0
  
  # Utils
  intl: ^0.19.0
  uuid: ^4.2.1

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0
  build_runner: ^2.4.6
  injectable_generator: ^2.4.1
  mockito: ^5.4.4

flutter:
  uses-material-design: true
  
  assets:
    - assets/images/
    - assets/icons/
```

Then run:
```bash
flutter pub get
```

### Step 3: Create Folder Structure
```bash
# Core
mkdir -p lib/core/config/theme
mkdir -p lib/core/config/routes
mkdir -p lib/core/constants
mkdir -p lib/core/error
mkdir -p lib/core/network
mkdir -p lib/core/usecases
mkdir -p lib/core/utils
mkdir -p lib/core/widgets

# Authentication Feature
mkdir -p lib/features/authentication/data/datasources
mkdir -p lib/features/authentication/data/models
mkdir -p lib/features/authentication/data/repositories
mkdir -p lib/features/authentication/domain/entities
mkdir -p lib/features/authentication/domain/repositories
mkdir -p lib/features/authentication/domain/usecases
mkdir -p lib/features/authentication/presentation/bloc
mkdir -p lib/features/authentication/presentation/pages
mkdir -p lib/features/authentication/presentation/widgets

# Other features (create as needed)
# mkdir -p lib/features/[feature_name]/data/...
```

### Step 4: Setup Supabase

1. Go to https://supabase.com
2. Create account & new project: `ars-app`
3. Wait 2-3 minutes for setup
4. Copy credentials from Settings → API

Create `.env` file:
```env
SUPABASE_URL=your_supabase_url_here
SUPABASE_ANON_KEY=your_supabase_anon_key_here
GOOGLE_MAPS_API_KEY=your_google_maps_key_here
GEMINI_API_KEY=your_gemini_api_key_here
PAYMONGO_PUBLIC_KEY=your_paymongo_public_key_here
```

### Step 5: Initialize Database Schema

Run this SQL in Supabase SQL Editor:

```sql
-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- User Roles Enum
CREATE TYPE user_role AS ENUM ('customer', 'mechanic', 'admin');
CREATE TYPE booking_status AS ENUM ('pending', 'accepted', 'in_progress', 'completed', 'cancelled');

-- Users Table (extends Supabase auth.users)
CREATE TABLE public.users (
  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  email TEXT NOT NULL UNIQUE,
  full_name TEXT NOT NULL,
  phone_number TEXT,
  role user_role NOT NULL DEFAULT 'customer',
  avatar_url TEXT,
  is_verified BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Customers Table
CREATE TABLE public.customers (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
  address TEXT,
  city TEXT,
  province TEXT,
  postal_code TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Mechanics Table
CREATE TABLE public.mechanics (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
  business_name TEXT,
  specialization TEXT[],
  certification_number TEXT,
  years_of_experience INTEGER,
  service_radius_km INTEGER DEFAULT 10,
  average_rating DECIMAL(3,2) DEFAULT 0.00,
  total_jobs_completed INTEGER DEFAULT 0,
  is_available BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Vehicles Table
CREATE TABLE public.vehicles (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  customer_id UUID NOT NULL REFERENCES public.customers(id) ON DELETE CASCADE,
  make TEXT NOT NULL,
  model TEXT NOT NULL,
  year INTEGER NOT NULL,
  plate_number TEXT UNIQUE,
  color TEXT,
  vin TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Services Table
CREATE TABLE public.services (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name TEXT NOT NULL,
  description TEXT,
  category TEXT NOT NULL,
  estimated_duration_minutes INTEGER,
  base_price DECIMAL(10,2),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Bookings Table
CREATE TABLE public.bookings (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  customer_id UUID NOT NULL REFERENCES public.customers(id),
  mechanic_id UUID REFERENCES public.mechanics(id),
  vehicle_id UUID NOT NULL REFERENCES public.vehicles(id),
  service_id UUID NOT NULL REFERENCES public.services(id),
  status booking_status DEFAULT 'pending',
  issue_description TEXT NOT NULL,
  ai_diagnosis TEXT,
  estimated_cost DECIMAL(10,2),
  final_cost DECIMAL(10,2),
  scheduled_date TIMESTAMP WITH TIME ZONE,
  started_at TIMESTAMP WITH TIME ZONE,
  completed_at TIMESTAMP WITH TIME ZONE,
  customer_location JSONB,
  mechanic_location JSONB,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Payments Table
CREATE TABLE public.payments (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  booking_id UUID NOT NULL REFERENCES public.bookings(id),
  amount DECIMAL(10,2) NOT NULL,
  payment_method TEXT NOT NULL,
  payment_status TEXT DEFAULT 'pending',
  paymongo_payment_id TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Reviews Table
CREATE TABLE public.reviews (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  booking_id UUID NOT NULL REFERENCES public.bookings(id),
  mechanic_id UUID NOT NULL REFERENCES public.mechanics(id),
  customer_id UUID NOT NULL REFERENCES public.customers(id),
  rating INTEGER CHECK (rating >= 1 AND rating <= 5),
  comment TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Enable Row Level Security
ALTER TABLE public.users ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.customers ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.mechanics ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.vehicles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.bookings ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.payments ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.reviews ENABLE ROW LEVEL SECURITY;

-- RLS Policies (Users can only see their own data)
CREATE POLICY "Users can view own data" ON public.users
  FOR SELECT USING (auth.uid() = id);

CREATE POLICY "Customers can view own data" ON public.customers
  FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Mechanics can view own data" ON public.mechanics
  FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can view own vehicles" ON public.vehicles
  FOR SELECT USING (
    customer_id IN (SELECT id FROM public.customers WHERE user_id = auth.uid())
  );

-- Create indexes for performance
CREATE INDEX idx_bookings_customer ON bookings(customer_id);
CREATE INDEX idx_bookings_mechanic ON bookings(mechanic_id);
CREATE INDEX idx_bookings_status ON bookings(status);
CREATE INDEX idx_mechanics_available ON mechanics(is_available);
```

### Step 6: Run the App
```bash
# Check everything is set up
flutter doctor

# Run on emulator/device
flutter run

# Or specify device
flutter run -d chrome  # Web
flutter run -d android # Android
flutter run -d ios     # iOS
```

---

## 📅 Development Roadmap

### **Phase 1: Foundation (Weeks 1-4)** 🏗️

#### Week 1: Project Setup
- [x] Create Flutter project
- [x] Setup folder structure
- [x] Install dependencies
- [x] Setup Supabase
- [x] Create database schema
- [ ] Setup CI/CD (GitHub Actions)

#### Week 2: Core Architecture
- [ ] Implement base classes (UseCase, Repository, Entity)
- [ ] Setup dependency injection (get_it + injectable)
- [ ] Create error handling
- [ ] Setup app theme & colors
- [ ] Create reusable widgets

#### Week 3-4: Authentication
- [ ] Login page UI
- [ ] Register page UI
- [ ] Role selection (Customer/Mechanic)
- [ ] Implement Auth BLoC
- [ ] Connect to Supabase Auth
- [ ] Implement auth repository
- [ ] Add form validation
- [ ] Add loading states

**Milestone 1:** User can register, login, and select role ✅

---

### **Phase 2: Customer Features (Weeks 5-10)** 👤

#### Week 5: Customer Dashboard
- [ ] Customer home page UI
- [ ] Bottom navigation
- [ ] Profile setup
- [ ] Vehicle management

#### Week 6-7: Mechanic Finder
- [ ] Google Maps integration
- [ ] Location permissions
- [ ] Display nearby mechanics
- [ ] Filter by specialization
- [ ] Mechanic profile view
- [ ] Rating display

#### Week 8-9: Booking System
- [ ] Service selection
- [ ] Issue description (text + photos)
- [ ] AI diagnosis integration
- [ ] Cost estimation
- [ ] Schedule booking
- [ ] Booking confirmation

#### Week 10: Tracking & Status
- [ ] Real-time location tracking
- [ ] Booking status updates
- [ ] ETA calculation
- [ ] Push notifications

**Milestone 2:** Customer can find mechanics and book services ✅

---

### **Phase 3: Mechanic Features (Weeks 11-14)** 🔧

#### Week 11: Mechanic Dashboard
- [ ] Mechanic home page UI
- [ ] Service request inbox
- [ ] Today's schedule
- [ ] Earnings overview

#### Week 12: Job Management
- [ ] Accept/reject bookings
- [ ] View job details
- [ ] Navigate to customer (Google Maps)
- [ ] Update job status
- [ ] Photo documentation

#### Week 13: Profile & Verification
- [ ] Mechanic profile setup
- [ ] Upload certifications
- [ ] ID verification
- [ ] Service area setup
- [ ] Availability toggle

#### Week 14: Earnings & Reviews
- [ ] Transaction history
- [ ] Payment tracking
- [ ] View customer reviews
- [ ] Performance analytics

**Milestone 3:** Mechanic can receive and complete jobs ✅

---

### **Phase 4: Shared Features (Weeks 15-18)** 🤝

#### Week 15: Chat System
- [ ] Setup Stream Chat
- [ ] Chat UI
- [ ] Real-time messaging
- [ ] Image sharing
- [ ] Push notifications

#### Week 16: Payment Integration
- [ ] PayMongo setup
- [ ] GCash integration
- [ ] Payment flow UI
- [ ] Escrow system
- [ ] Payment confirmation

#### Week 17: Rating & Reviews
- [ ] Rating UI (stars)
- [ ] Review submission
- [ ] Review display
- [ ] Average rating calculation
- [ ] Review moderation

#### Week 18: AI Assistant
- [ ] Google Gemini integration
- [ ] Issue diagnosis
- [ ] Service recommendations
- [ ] Cost estimation
- [ ] Chatbot for FAQs

**Milestone 4:** Core app complete with all essential features ✅

---

### **Phase 5: Admin Portal (Weeks 19-20)** 👨‍💼

#### Week 19: Next.js Setup
- [ ] Create Next.js project
- [ ] Setup Tailwind CSS
- [ ] Connect to Supabase
- [ ] Admin authentication

#### Week 20: Admin Dashboard
- [ ] User management
- [ ] Mechanic verification
- [ ] Booking analytics
- [ ] Transaction monitoring
- [ ] Dispute resolution

**Milestone 5:** Admin can manage platform ✅

---

### **Phase 6: Polish & Launch (Weeks 21-24)** 🚀

#### Week 21: Testing
- [ ] Unit tests
- [ ] Widget tests
- [ ] Integration tests
- [ ] User acceptance testing
- [ ] Bug fixes

#### Week 22: Optimization
- [ ] Performance optimization
- [ ] Reduce app size
- [ ] Optimize images
- [ ] Code refactoring
- [ ] Security audit

#### Week 23: Deployment Prep
- [ ] App store assets (screenshots, icons)
- [ ] Privacy policy
- [ ] Terms of service
- [ ] Marketing materials
- [ ] Demo video

#### Week 24: Launch
- [ ] Submit to Google Play
- [ ] Submit to App Store
- [ ] Deploy admin portal
- [ ] Marketing campaign
- [ ] Monitor analytics

**Milestone 6:** App live on stores! 🎉

---

## 🔨 Feature Implementation Guide

### How to Add a New Feature

Follow this pattern for EVERY feature:

#### 1. Create Feature Folder Structure
```bash
mkdir -p lib/features/[feature_name]/data/datasources
mkdir -p lib/features/[feature_name]/data/models
mkdir -p lib/features/[feature_name]/data/repositories
mkdir -p lib/features/[feature_name]/domain/entities
mkdir -p lib/features/[feature_name]/domain/repositories
mkdir -p lib/features/[feature_name]/domain/usecases
mkdir -p lib/features/[feature_name]/presentation/bloc
mkdir -p lib/features/[feature_name]/presentation/pages
mkdir -p lib/features/[feature_name]/presentation/widgets
```

#### 2. Domain Layer (Business Logic)

**Entity** (`domain/entities/[name]_entity.dart`):
```dart
import 'package:equatable/equatable.dart';

class BookingEntity extends Equatable {
  final String id;
  final String customerId;
  final String? mechanicId;
  final String status;
  final DateTime createdAt;

  const BookingEntity({
    required this.id,
    required this.customerId,
    this.mechanicId,
    required this.status,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, customerId, mechanicId, status, createdAt];
}
```

**Repository Interface** (`domain/repositories/[name]_repository.dart`):
```dart
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/booking_entity.dart';

abstract class BookingRepository {
  Future<Either<Failure, List<BookingEntity>>> getCustomerBookings(String customerId);
  Future<Either<Failure, BookingEntity>> createBooking(BookingEntity booking);
  Future<Either<Failure, BookingEntity>> updateBookingStatus(String bookingId, String status);
}
```

**Use Case** (`domain/usecases/[action]_usecase.dart`):
```dart
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/booking_entity.dart';
import '../repositories/booking_repository.dart';

class GetCustomerBookingsUseCase implements UseCase<List<BookingEntity>, String> {
  final BookingRepository repository;

  GetCustomerBookingsUseCase(this.repository);

  @override
  Future<Either<Failure, List<BookingEntity>>> call(String customerId) async {
    return await repository.getCustomerBookings(customerId);
  }
}
```

#### 3. Data Layer (Implementation)

**Model** (`data/models/[name]_model.dart`):
```dart
import '../../domain/entities/booking_entity.dart';

class BookingModel extends BookingEntity {
  const BookingModel({
    required super.id,
    required super.customerId,
    super.mechanicId,
    required super.status,
    required super.createdAt,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'],
      customerId: json['customer_id'],
      mechanicId: json['mechanic_id'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customer_id': customerId,
      'mechanic_id': mechanicId,
      'status': status,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
```

**Data Source** (`data/datasources/[name]_remote_datasource.dart`):
```