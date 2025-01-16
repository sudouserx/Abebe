# Abebe: A Flutter Package for Typing Speed Based Animation Control

Abebe is a Flutter package that adjusts the speed of an animation based on the user's typing speed. It uses the `Lottie` animation and modifies the animation's playback speed in real-time as characters are typed into a text field.

## Features

- Controls the speed of Lottie animations based on typing speed.
- Customizable animation speed multiplier.
- Supports dynamic and real-time animation updates.

## Installation

To use the `Abebe` package in your Flutter project, add the following dependency to your `pubspec.yaml` file:

```yaml
dependencies:
  abebe: ^1.0.0

## Getting started

Then, run the following command to install the package:

flutter pub get


## Usage

Here’s a simple example of how to use the Abebe package:

Import the package:

import 'package:abebe/abebe.dart';

Create a TextEditingController:

TextEditingController _controller = TextEditingController();

Use the Abebe widget:

Abebe(
  assetPath: 'assets/your_lottie_animation.json', // Path to your Lottie asset
  textController: _controller,
  speedMultiplier: 2, // Optional multiplier to adjust speed
)

Wrap it with a UI component:

    Scaffold(
      body: Column(
        children: [
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: 'Start typing...',
            ),
          ),
          Expanded(
            child: Abebe(
              assetPath: 'assets/animation.json',
              textController: _controller,
              speedMultiplier: 1,
            ),
          ),
        ],
      ),
    );

Parameters

    assetPath (required): The path to the Lottie asset you want to display.
    textController (required): The TextEditingController linked to the text field.
    speedMultiplier (optional): A multiplier to adjust the speed of the animation. Default is 1.

License

This package is open source and available under the MIT License. See the LICENSE file for more information.
Contributing

Feel free to fork the repository, make improvements, and submit pull requests. All contributions are welcome!
Support

For any issues or questions, feel free to open an issue in the GitHub repository or contact the maintainers.


You can save this entire content as a `README.md` file in your project repository.
```
