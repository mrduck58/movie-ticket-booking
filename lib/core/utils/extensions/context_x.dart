import 'package:flutter/material.dart';

extension ContextX on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get text => Theme.of(this).textTheme;
  Size get size => MediaQuery.of(this).size;
}

// cách dùng
// context.text.bodyMedium
// context.size.width