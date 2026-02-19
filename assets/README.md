# Assets Folder Guide

## 📁 Folder Structure

```
assets/
├── images/           # General images (logo, backgrounds, placeholders)
│   └── categories/   # Category-specific icons/images
└── icons/           # Custom app icons
```

## 🖼️ Adding Images

### 1. Place your image files in the appropriate folder:
- **Logo**: `assets/images/logo.png`
- **Shop photos**: Use network URLs or place defaults in `assets/images/`
- **Category icons**: `assets/images/categories/food.png`, etc.
- **Custom icons**: `assets/icons/custom_icon.png`

### 2. Supported formats:
- PNG (recommended for logos and icons with transparency)
- JPG/JPEG (for photos)
- SVG (requires `flutter_svg` package)
- WebP (modern format, smaller file size)

### 3. Recommended sizes:
- **Logo**: 512x512px or 1024x1024px
- **Shop thumbnails**: 400x300px
- **Category icons**: 128x128px or 256x256px
- **Full shop images**: 1200x800px

### 4. After adding images, run:
```bash
flutter pub get
```

## 💡 Usage Examples

### Using Asset Images:
```dart
// Simple usage
Image.asset('assets/images/logo.png')

// With size
Image.asset(
  'assets/images/logo.png',
  width: 100,
  height: 100,
)

// Using AssetPaths constants
import 'package:m_link_project/core/constants/asset_paths.dart';
Image.asset(AssetPaths.logo)

// Using helper with error handling
ImageHelper.asset(AssetPaths.logo, width: 100, height: 100)
```

### Using Network Images (for shop photos):
```dart
// Simple usage
Image.network('https://example.com/shop-photo.jpg')

// With helper (includes loading & error handling)
ImageHelper.network(
  'https://example.com/shop-photo.jpg',
  width: 400,
  height: 300,
  fit: BoxFit.cover,
)
```

### In Shop Model:
```dart
Shop(
  id: '1',
  name: 'Campus Cafe',
  imageUrls: [
    'https://images.unsplash.com/photo-1...',  // Network image
    'https://images.unsplash.com/photo-2...',
  ],
  // ... other fields
)
```

## 🎨 Material Icons vs Custom Icons

The app currently uses Material Icons (built-in, no setup needed):
```dart
Icon(Icons.storefront_rounded)
Icon(Icons.school_rounded)
Icon(Icons.restaurant_rounded)
```

For custom icons, you can:
1. Use PNG images with `Image.asset()`
2. Use SVG with `flutter_svg` package
3. Create custom icon font

## 📦 Example Files Structure

```
assets/
├── images/
│   ├── logo.png                    # Your M-Link logo
│   ├── logo_white.png              # White version for dark backgrounds
│   ├── default_shop.png            # Placeholder for shops without photos
│   └── categories/
│       ├── food.png                # Food category icon
│       ├── coffee.png              # Coffee category icon
│       ├── stationary.png          # Stationary category icon
│       ├── services.png            # Services category icon
│       ├── fashion.png             # Fashion category icon
│       ├── tech.png                # Tech category icon
│       ├── health.png              # Health category icon
│       └── entertainment.png       # Entertainment category icon
└── icons/
    └── (custom icons if needed)
```

## 🌐 Using Free Image Resources

- **Unsplash**: https://unsplash.com (free high-quality photos)
- **Pexels**: https://pexels.com (free stock photos)
- **Flaticon**: https://flaticon.com (free icons, check license)
- **Icons8**: https://icons8.com (free icons and illustrations)

## 🔄 Hot Reload Note

After adding new assets:
1. Save `pubspec.yaml`
2. Run `flutter pub get`
3. Sometimes you need to restart the app (not just hot reload)
