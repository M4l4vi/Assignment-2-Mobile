# 🎓 Student Courses App

A complete Flutter application for managing student courses with Firebase authentication and Firestore real-time database integration.

## ✨ Features

### 🔐 Authentication
- Email/Password Sign Up with name registration
- Email/Password Login
- Secure session management with automatic routing
- Logout functionality

### 📚 Course Management
- Add courses with name, code, and description
- View all courses in real-time
- Delete courses with confirmation dialog
- Real-time data synchronization with Firestore
- User-specific course filtering

### 🎨 UI/UX
- Material Design 3 interface
- Responsive layouts for all screen sizes
- Intuitive navigation between screens
- User-friendly error messages
- Loading states for async operations

## 🏗️ Project Structure

```
lib/
├── main.dart              # App entry point with Firebase init & routing
├── login_screen.dart      # Login screen (email + password)
├── register_screen.dart   # Registration screen (name + email + password)
└── courses_screen.dart    # Courses management & display
```

## 📱 Screens

### Login Screen
- Email input field
- Password input field
- Login button
- Link to "Sign Up"

### Register Screen
- Full name input field
- Email input field
- Password input field
- Sign Up button
- Link back to Login

### Courses Screen
- Welcome message with user email
- Add course form (name, code, description)
- Real-time courses list
- Delete course with confirmation
- Logout button

## 🗄️ Database Structure

### Firestore Collections

#### `users` Collection
```
users/
└── {uid}
    ├── name: string
    ├── email: string
    ├── uid: string
    └── createdAt: timestamp
```

#### `courses` Collection
```
courses/
└── {courseId}
    ├── userId: string (reference to user)
    ├── name: string
    ├── code: string
    ├── description: string
    └── createdAt: timestamp
```

## 🔒 Firestore Security Rules

```firestore
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{uid} {
      allow read, write: if request.auth.uid == uid;
    }
    match /courses/{courseId} {
      allow create: if request.auth != null && request.resource.data.userId == request.auth.uid;
      allow read: if request.auth != null && resource.data.userId == request.auth.uid;
      allow update, delete: if request.auth != null && resource.data.userId == request.auth.uid;
    }
  }
}
```

## 🚀 Getting Started

### Prerequisites
- Flutter 3.9.2 or higher
- Firebase project
- iOS/Android development environment

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd flutter_application_1
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase**
   
   **Option A: Using FlutterFire CLI (Recommended)**
   ```bash
   flutter pub global activate flutterfire_cli
   flutterfire configure
   ```
   
   **Option B: Manual Configuration**
   - Go to [Firebase Console](https://console.firebase.google.com)
   - Create a new project or select existing
   - Update Firebase credentials in `lib/main.dart`:
     ```dart
     const firebaseOptions = FirebaseOptions(
       apiKey: 'YOUR_API_KEY',
       appId: 'YOUR_APP_ID',
       messagingSenderId: 'YOUR_MESSAGING_SENDER_ID',
       projectId: 'YOUR_PROJECT_ID',
       authDomain: 'YOUR_AUTH_DOMAIN',
       databaseURL: 'YOUR_DATABASE_URL',
       storageBucket: 'YOUR_STORAGE_BUCKET',
     );
     ```

4. **Setup Firebase Services**
   - Enable **Authentication** (Email/Password)
   - Create **Firestore Database**
   - Deploy security rules (see section above)

5. **Run the app**
   ```bash
   flutter run
   ```

## 📦 Dependencies

```yaml
flutter: SDK ^3.9.2
firebase_core: ^3.15.2       # Firebase initialization
firebase_auth: ^5.3.2        # Authentication
cloud_firestore: ^5.3.2      # Real-time database
cupertino_icons: ^1.0.8      # iOS icons
```

## 🧪 Testing

### Test Sign Up Flow
1. Click "Sign Up" button
2. Fill in: Name, Email, Password (6+ characters)
3. Click "Sign Up"
4. Should redirect to Courses screen

### Test Login Flow
1. Enter email and password
2. Click "Login"
3. Should redirect to Courses screen

### Test Course Management
1. Add course with name, code, description
2. Course appears instantly in list
3. Click delete button to remove course
4. Confirm deletion in dialog

### Test Logout
1. Click logout button in app bar
2. Should redirect to Login screen

## 🐛 Troubleshooting

### Firebase Options Error
**Error:** `FirebaseOptions cannot be null when creating the default app`

**Solution:** 
- Get Firebase credentials from Firebase Console
- Update `lib/main.dart` with real credentials

### Permission Denied on Firestore
**Error:** `Permission denied for collection "courses"`

**Solution:**
- Go to Firestore → Rules
- Deploy the security rules provided above
- Click "Publish"

### Courses Not Showing
**Error:** Courses added but not displaying

**Solution:**
- Verify Firestore security rules are deployed
- Check that `userId` is correctly stored in courses
- Try adding a new course and refresh

### iOS Build Fails
**Error:** `GoogleService-Info.plist not found`

**Solution:**
- Download `GoogleService-Info.plist` from Firebase
- Add to Xcode Runner target (not just file system)

### Android Build Fails
**Error:** `google-services.json not found`

**Solution:**
- Ensure file is at `android/app/google-services.json`
- Run `flutter clean && flutter pub get`

## 📋 API Reference

### Authentication

#### Register User
```dart
await FirebaseAuth.instance.createUserWithEmailAndPassword(
  email: 'user@example.com',
  password: 'password123',
);
```

#### Login User
```dart
await FirebaseAuth.instance.signInWithEmailAndPassword(
  email: 'user@example.com',
  password: 'password123',
);
```

#### Logout
```dart
await FirebaseAuth.instance.signOut();
```

### Course Operations

#### Add Course
```dart
await FirebaseFirestore.instance.collection('courses').add({
  'userId': user.uid,
  'name': 'Course Name',
  'code': 'COURSE101',
  'description': 'Course Description',
  'createdAt': FieldValue.serverTimestamp(),
});
```

#### Read Courses
```dart
FirebaseFirestore.instance
    .collection('courses')
    .where('userId', isEqualTo: user.uid)
    .snapshots();
```

#### Delete Course
```dart
await FirebaseFirestore.instance
    .collection('courses')
    .doc(courseId)
    .delete();
```

## 📱 Supported Platforms

- ✅ Android
- ✅ iOS
- ✅ Web
- ✅ macOS
- ✅ Windows
- ✅ Linux

## 🎯 Best Practices Implemented

- ✅ Proper async/await error handling
- ✅ BuildContext safety checks (`if (!mounted)`)
- ✅ Resource disposal in `dispose()`
- ✅ Input validation before operations
- ✅ User feedback via SnackBars
- ✅ Loading states for better UX
- ✅ Firestore security rules for data protection
- ✅ Zero code analysis issues

## 📚 Resources

- [Flutter Documentation](https://flutter.dev)
- [Firebase Flutter Setup](https://firebase.google.com/docs/flutter/setup)
- [Cloud Firestore Guide](https://firebase.google.com/docs/firestore)
- [Firebase Authentication](https://firebase.google.com/docs/auth)

## 📄 License

This project is provided as-is for educational purposes.

## 👤 Author

Student Courses App - A Flutter Firebase Project

## 🤝 Contributing

Contributions are welcome! Feel free to fork and submit pull requests.

## 📞 Support

For issues and questions:
1. Check the Troubleshooting section
2. Review Firebase documentation
3. Check Flutter logs: `flutter logs`

---

**Last Updated:** November 29, 2025  
**Framework:** Flutter 3.9.2+  
**Status:** ✅ Production Ready

