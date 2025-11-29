// Firebase Configuration Template
// Replace all YOUR_* values with actual credentials from Firebase Console

const firebaseConfig = {
  'apiKey': 'YOUR_API_KEY',
  'appId': 'YOUR_APP_ID',
  'messagingSenderId': 'YOUR_MESSAGING_SENDER_ID',
  'projectId': 'YOUR_PROJECT_ID',
  'authDomain': 'YOUR_PROJECT_ID.firebaseapp.com',
  'databaseURL': 'https://YOUR_PROJECT_ID.firebaseio.com',
  'storageBucket': 'YOUR_PROJECT_ID.appspot.com',
  'measurementId': 'YOUR_MEASUREMENT_ID',
};

// How to get these values:
// 1. Go to Firebase Console (https://console.firebase.google.com)
// 2. Select your project
// 3. Click "Project Settings" (gear icon)
// 4. Go to "Your apps" section
// 5. For Web app, copy the config object
// 6. For Android/iOS, use google-services.json or GoogleService-Info.plist

// Apply these values to lib/main.dart in the firebaseOptions constant
