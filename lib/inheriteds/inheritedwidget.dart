import 'package:flutter/material.dart';

import '../models/data.dart';

class InheritedDataProvider extends InheritedWidget {
  final Data data;

  InheritedDataProvider({
    Widget child,
    this.data,
  }) : super(child: child);

  @override
  bool updateShouldNotify(InheritedDataProvider oldWidget) => data != oldWidget.data;

  static InheritedDataProvider of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(InheritedDataProvider);
}
