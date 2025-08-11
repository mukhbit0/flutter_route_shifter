# Contributing to Flutter Route Shifter

First off, thank you for considering contributing to `flutter_route_shifter`! We're thrilled that you're interested in making this package even better. Your contributions help us create beautiful, performant, and easy-to-use animations for the entire Flutter community.

This document provides guidelines for contributing to the project. Please read it to ensure a smooth and effective collaboration process.

## Code of Conduct

This project and everyone participating in it is governed by our [Code of Conduct](CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code. Please report unacceptable behavior to [mukhbit000@gmail.com](mailto:mukhbit000@gmail.com).

## How Can I Contribute?

There are many ways to contribute, and all of them are valuable. Here are a few ideas:

-   **🐛 Reporting Bugs:** Find a bug? Please report it!
-   **💡 Suggesting Enhancements:** Have an idea for a new feature or a better way to do something? We'd love to hear it.
-   **📝 Improving Documentation:** Find a typo or a confusing section in the `README.md` or code comments? Suggest a change.
-   **✨ Creating New Effects:** Design a cool new `RouteEffect` that others would find useful.
-   ** presets:** Add a new `preset` for a common animation pattern.
-   **✍️ Writing Tests:** Help us improve our test coverage to make the package more robust.
-   **🧑‍💻 Submitting Pull Requests:** If you're ready to contribute code, we welcome your pull requests.

## Your First Contribution

Unsure where to begin? A great place to start is by looking for issues tagged with `good first issue` or `help wanted`. These are issues that we've identified as good entry points for new contributors.

You can also start by improving the documentation. Documentation is one of the most important parts of a successful package, and even small improvements like fixing a typo can make a big difference.

## 🐛 Reporting Bugs

Before creating a bug report, please check the existing [GitHub Issues](https://github.com/mukhbit0/flutter_route_shifter/issues) to see if the bug has already been reported.

If you can't find an open issue addressing the problem, please [open a new one](https://github.com/mukhbit0/flutter_route_shifter/issues/new). Be sure to include a **title and clear description**, as much relevant information as possible, and a **minimal, reproducible code sample** demonstrating the expected behavior that is not occurring. A complete code sample allows us to quickly identify and fix the issue.

## 💡 Suggesting Enhancements

We're always looking for suggestions to make `flutter_route_shifter` better. If you have an idea, please [open a new issue](https://github.com/mukhbit0/flutter_route_shifter/issues/new) to start a discussion. This allows us to gather feedback and refine the idea before any code is written.

##  Pull Request Process

1.  **Fork the repository** and create your branch from `main`.
2.  **Install dependencies** by running `flutter pub get`.
3.  **Make your changes.** Please adhere to the coding style used throughout the project.
4.  **Add or update tests** for your changes. We value robust testing to maintain quality.
5.  **Ensure all tests pass** by running `flutter test`.
6.  **Format your code** by running `dart format .`.
7.  **Commit your changes** with a clear and descriptive commit message.
8.  **Push your branch** to your fork and **submit a pull request** to the `main` branch of the `flutter_route_shifter` repository.

Once you've submitted your pull request, a maintainer will review it as soon as possible. We may suggest some changes or improvements.

### Coding Style

-   We follow the official [Dart style guide](https://dart.dev/guides/language/effective-dart/style).
-   Use `dart format .` to automatically format your code before committing.
-   Add comments to your code where it's not self-explanatory.

## Development Setup

As outlined in the `README.md`, you can get started with development by running:

```bash
git clone [https://github.com/mukhbit0/flutter_route_shifter.git](https://github.com/mukhbit0/flutter_route_shifter.git)
cd flutter_route_shifter
flutter pub get
flutter test