# Abebe: A Flutter Package for Typing Speed Based Animation Control

![abebe](https://via.placeholder.com/728x90.png?text=Abebe+Logo)

[![Build Status](https://img.shields.io/github/workflow/status/sudouserx/Abebe/CI)](https://github.com/sudouserx/Abebe/actions)
[![License](https://img.shields.io/github/license/sudouserx/Abebe)](LICENSE)
[![Version](https://img.shields.io/pub/v/abebe)](https://pub.dev/packages/abebe)

Abebe is a Flutter package that dynamically adjusts the speed of a Lottie animation based on the user's typing speed. It provides real-time synchronization between typing activity and animation playback, creating a responsive and engaging user experience.

---

## Table of Contents
- [Features](#features)
- [Installation](#installation)
- [Getting Started](#getting-started)
- [Usage](#usage)
- [Parameters](#parameters)
- [Example](#example)
- [Testing](#testing)
- [License](#license)
- [Contributing](#contributing)
- [Support](#support)

---

## Features

- **Real-time Animation Control**: Adjusts animation speed based on typing speed.
- **Smooth Transitions**: Uses exponential decay for smooth speed changes.
- **Customizable Sensitivity**: Control how much the animation responds to typing speed.
- **Progress Preservation**: Maintains animation progress during speed changes.
- **Inactivity Reset**: Automatically resets to normal speed after 1 second of inactivity.
- **Comprehensive Testing**: Includes unit and widget tests for reliability.

---

## Installation

Add the `Abebe` package to your `pubspec.yaml` file:

```yaml
dependencies:
  abebe: ^1.1.0
```

Then, run the following command to install the package:

```sh
flutter pub get
```

---

## Getting Started

1. Import the package:

    ```dart
    import 'package:abebe/abebe.dart';
    ```

2. Add the `Lottie` package to your `pubspec.yaml` file (if not already added):

    ```yaml
    dependencies:
      lottie: ^2.0.0
    ```

3. Place your Lottie JSON file in the `assets` folder and update `pubspec.yaml`:

    ```yaml
    flutter:
      assets:
        - assets/sample.json
    ```

---

## Usage

Here’s a simple example of how to use the `Abebe` package:

```dart
import 'package:flutter/material.dart';
import 'package:abebe/abebe.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Abebe Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Abebe Example'),
      ),
      body: Column(
        children: [
          Abebe(
            assetPath: 'assets/sample.json',
            textController: _controller,
            animationController: _animationController,
            sensitivity: 0.3, // Adjust sensitivity here
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Type here to control the animation...',
                border: OutlineInputBorder(),
              ),
              autofocus: true,
            ),
          ),
        ],
      ),
    );
  }
}
```

---

## Parameters

| Parameter               | Description                                                                 |
|-------------------------|-----------------------------------------------------------------------------|
| `assetPath` (required)  | Path to the Lottie JSON file.                                               |
| `textController` (required) | `TextEditingController` linked to the text field.                       |
| `animationController` (required) | `AnimationController` to control the animation.                     |
| `sensitivity` (optional) | Controls how much the animation responds to typing speed. Default is `0.2`. |

---

## Example

For a complete example, check out the [example folder](example/) in the repository.

---

## Testing

The package includes comprehensive unit and widget tests. To run the tests:

```bash
flutter test test/abebe_test.dart
```

---

## License

This package is open source and available under the MIT License. See the [LICENSE](LICENSE) file for more information.

---

## Contributing

Contributions are welcome! Feel free to fork the repository, make improvements, and submit pull requests. Please ensure your code follows the project's coding standards and includes appropriate tests.

---

## Support

For any issues or questions, feel free to open an issue in the [GitHub repository](https://github.com/sudouserx/Abebe/issues) or contact the maintainers.