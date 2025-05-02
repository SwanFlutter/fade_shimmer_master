
# Fade Shimmer Master

A beautiful and customizable shimmer effect package for Flutter applications. This package provides various shimmer effects that can be used for loading states, creating beautiful animations, and enhancing user experience.

## Features

- Multiple shimmer effects (basic, round, rectangular, list, and grid)
- Customizable colors and themes
- Gradient support
- Directional shimmer effects
- Staggered animations
- Customizable border radius and shadows
- Predefined themes (light, dark, blue, purple, green)

## Getting started

Add the package to your `pubspec.yaml`:

```yaml

  fade_shimmer_master: ^0.0.1

```

```yaml

import 'package:fade_shimmer_master/fade_shimmer_master.dart';

```


![20250502_034501](https://github.com/user-attachments/assets/97143da9-f6d4-49a4-8b47-8f124cb4b6cf)



## Usage

### Basic Shimmer

```dart
FadeShimmerMaster(
  width: 200,
  height: 100,
  fadeTheme: FadeTheme.light,
  radius: 8,
)
```

### Round Shimmer

```dart
FadeShimmerMaster.round(
  size: 100,
  fadeTheme: FadeTheme.dark,
)
```

### Rectangular Shimmer

```dart
FadeShimmerMaster.rectangular(
  width: 200,
  height: 100,
  borderRadius: BorderRadius.circular(12),
  fadeTheme: FadeTheme.blue,
)
```

### List Shimmer

```dart
// Using static method
FadeShimmerMaster.list(
  itemCount: 5,
  itemHeight: 100,
  itemWidth: double.infinity,
  spacing: 16,
  fadeTheme: FadeTheme.purple,
  staggered: true,
)

// Or using the class directly
FadeShimmerList(
  itemCount: 5,
  itemHeight: 100,
  itemWidth: double.infinity,
  spacing: 16,
  fadeTheme: FadeTheme.purple,
  staggered: true,
)
```

### Grid Shimmer

```dart
// Using static method
FadeShimmerMaster.grid(
  itemCount: 6,
  itemHeight: 100,
  itemWidth: 100,
  crossAxisCount: 2,
  crossAxisSpacing: 16,
  mainAxisSpacing: 16,
  fadeTheme: FadeTheme.green,
  staggered: true,
)

// Or using the class directly
FadeShimmerGrid(
  itemCount: 6,
  itemHeight: 100,
  itemWidth: 100,
  crossAxisCount: 2,
  crossAxisSpacing: 16,
  mainAxisSpacing: 16,
  fadeTheme: FadeTheme.green,
  staggered: true,
)
```

### Custom Colors

```dart
FadeShimmerMaster(
  width: 200,
  height: 100,
  highlightColor: Colors.blue,
  baseColor: Colors.blue.shade100,
  radius: 8,
)
```

### Gradient Effect

```dart
FadeShimmerMaster(
  width: 200,
  height: 100,
  fadeTheme: FadeTheme.light,
  useGradient: true,
  shimmerDirection: ShimmerDirection.leftToRight,
)
```

### Custom Border and Shadow

```dart
FadeShimmerMaster(
  width: 200,
  height: 100,
  fadeTheme: FadeTheme.light,
  border: Border.all(color: Colors.grey),
  boxShadow: [
    BoxShadow(
      color: Colors.grey.withOpacity(0.5),
      spreadRadius: 2,
      blurRadius: 4,
      offset: Offset(0, 2),
    ),
  ],
)
```

## Additional Features

### Available Themes

```dart
enum FadeTheme {
  light,  // Light gray theme
  dark,   // Dark gray theme
  blue,   // Blue theme
  purple, // Purple theme
  green,  // Green theme
}
```

### Shimmer Directions

```dart
enum ShimmerDirection {
  leftToRight,
  rightToLeft,
  topToBottom,
  bottomToTop,
}
```

## Additional information

For more information about the package, you can:

- Check the example app in the `/example` folder
- File issues on GitHub
- Contribute to the package by submitting pull requests

The package is maintained and regularly updated. Feel free to reach out with any questions or suggestions!
