import 'package:flutter/cupertino.dart';

extension RouteExtension on BuildContext {
  /// Pushes a new route onto the navigator stack.
  Future<T?> push<T extends Object?>(Widget page) {
    return Navigator.of(this).push(
      CupertinoPageRoute<T>(
        builder: (context) => page,
      ),
    );
  }

  /// Pops the current route off the navigator stack.
  void pop<T extends Object?>([T? result]) {
    Navigator.of(this).pop(result);
  }

}