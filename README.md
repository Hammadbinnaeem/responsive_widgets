# Flutter Widgets & Utilities 📱💻

This repository contains a collection of reusable **Flutter widgets** and utility classes designed to streamline development across both **mobile** and **desktop** platforms. The goal is to provide highly customizable, responsive, and state-managed components using `flutter_riverpod` to help developers focus on building feature-rich Flutter apps faster.

## 📋 What's Included?
- **Responsive UI components**: Widgets that adapt dynamically to different screen sizes (mobile, tablet, desktop).
- **State management with Riverpod**: Pre-configured `ConsumerStatefulWidget` and `ConsumerState` implementations to help manage app state.
- **UI templates**: Base classes and layout patterns that support responsive design.
- **Common utilities**: Code snippets and helper functions for handling layout, alignment, scrolling, and more.

## ✨ Key Features:
- **Mobile & Desktop Support**: Each widget adapts to different screen sizes and device types.
- **Easy Customization**: Extend base widgets and override common methods for layout, app bars, side panels, and more.
- **Optimized for Flutter Web**: Widgets designed to work seamlessly across both Flutter mobile and web platforms.
- **Riverpod for State Management**: Utilize the power of `flutter_riverpod` to keep your app’s state predictable and easy to manage.

## 🚀 Getting Started:
1. Clone this repository.
2. Import the necessary widgets and base classes into your Flutter project.
3. Extend or modify the components to fit your app’s requirements.

### Example Usage

```dart
import 'package:your_project/widgets/base_consumer_stateful.dart';

// Example usage:
class YourScreen extends BaseConsumerStatefull {
  @override
  Widget buildBody(BuildContext context, WidgetRef ref) {
    return Center(
      child: Text("Hello, responsive world!"),
    );
  }
}
