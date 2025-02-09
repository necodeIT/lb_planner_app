# Assets 🎨

This directory holds all the static files used across the app, organized in a module-based structure for easy navigation and maintenance.

## Structure Overview

Each module in the app has its own dedicated folder within the `assets` directory. This makes it straightforward to find and manage assets related to specific features or sections of the app.

### Example Structure

```plaintext
assets/
│
├── auth/
│   ├── background.svg
│   └── login_icon.png
│
├── home/
│   ├── banner.jpg
│   └── profile_icon.svg
│
└── settings/
    ├── gear_icon.svg
    └── background.png
```

- **`auth/`**: Contains all assets related to the authentication module (e.g., login screens, signup, etc.).
- **`home/`**: Assets for the home module, including banners, icons, and backgrounds.
- **`settings/`**: Images and icons used in the settings module.

## Adding New Assets

1. **Organize by Module**: Place new assets in the appropriate module folder. If the module doesn't exist, create a new folder following the naming convention.

2. **Naming Conventions**: Use clear and descriptive names for files, separating words with underscores (`_`) and avoiding spaces or special characters.

   Example: `user_profile_picture.svg`, `login_background.png`

3. **Update flutter_gen**: After adding or removing assets, run `flutter pub run build_runner build` to regenerate the asset references in Dart code.
   - If you're creating a new asset folder, make sure to add it to the `pubspec.yaml` file under `assets` to generate the asset references.

        ```yaml
            flutter:
                assets:
                    - assets/auth/
                    - assets/home/
                    - assets/settings/
                    - assets/new_module/ # Add the new module folder here
        ```

## Accessing Assets in Code

Thanks to `flutter_gen`, you can easily reference assets in your Dart code without manually defining paths. Use the generated asset references like this:

```dart
import 'package:lb_planner/gen/assets.gen.dart';

// Example usage
Image.asset(Assets.auth.background.path);
```

## Theming SVGs

Below is a table that outlines the hex color codes used in the SVGs within this folder and the corresponding theme variables they will be replaced with at runtime based on the currently active theme.

| Hex Code   | Replaced with                | Description                                           |
|------------|------------------------------|-------------------------------------------------------|
| `#FF5733`  | `ColorScheme.primary`         | Main color of the app's theme.                        |
| `#FFC300`  | `ColorScheme.secondary`       | Accents and highlights that complement the primary.   |
| `#FF5733`  | `ColorScheme.secondaryVariant` | Lighter or alternate shade of the secondary color.   |
| `#DAF7A6`  | `ColorScheme.surface`         | Surfaces like cards and sheets.                       |
| `#900C3F`  | `ColorScheme.error`           | Error messages and error state indications.           |
| `#581845`  | `ColorScheme.onPrimary`       | Text and icons on top of the primary color.           |
| `#1F618D`  | `ColorScheme.onSecondary`     | Text and icons on top of the secondary color.         |
| `#17202A`  | `ColorScheme.onSurface`       | Text and icons on top of surfaces.                    |
| `#F1C40F`  | `ColorScheme.onError`         | Text and icons on top of error color surfaces.        |
| `#000000`  | `TextTheme.bodyNormal.color`  | Normal text color.                                    |
| `#0037ff`  | `Theme.scaffoldBackgroundColor`| Background color of the app.                         |
| `#00ff40`  | `Theme.dividerColor`          | Color of dividers between elements.                   |