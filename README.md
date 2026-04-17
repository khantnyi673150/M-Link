# M-Link Project

Flutter app for campus marketplace flows:
- Merchant registration/login
- Merchant shop profile creation/edit
- Merchant menu item management
- Student browsing by category and shop detail

## Firebase Setup (Required)

This app now uses Firebase Auth + Cloud Firestore for real accounts and data.

1. Install FlutterFire CLI (one-time):
```bash
dart pub global activate flutterfire_cli
```
2. Configure this project:
```bash
flutterfire configure
```
3. Ensure platform config files are generated/added:
- `android/app/google-services.json`
- `ios/Runner/GoogleService-Info.plist`
- `lib/firebase_options.dart` (optional if you choose to wire it)
4. Enable Firebase services in console:
- Authentication: Email/Password provider
- Cloud Firestore: create database

## Firestore Data Shape

Collection: `shops`
- `merchantId` (string)
- `name` (string)
- `category` (string)
- `description` (string)
- `priceRange` (string)
- `location` (string)
- `phone` (string)
- `imageUrls` (array of strings)
- `rating` (number)

Subcollection: `shops/{shopId}/menu`
- `name` (string)
- `description` (string)
- `price` (number)

## Example Firestore Rules

Use rules similar to this for owner-write/public-read behavior:

```txt
rules_version = '2';
service cloud.firestore {
	match /databases/{database}/documents {
		match /shops/{shopId} {
			allow read: if true;
			allow create, update, delete: if request.auth != null
				&& request.resource.data.merchantId == request.auth.uid;

			match /menu/{menuId} {
				allow read: if true;
				allow create, update, delete: if request.auth != null
					&& get(/databases/$(database)/documents/shops/$(shopId)).data.merchantId == request.auth.uid;
			}
		}
	}
}
```

## Run

```bash
flutter pub get
flutter run
```
