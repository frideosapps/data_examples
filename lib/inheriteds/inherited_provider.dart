import 'package:flutter/material.dart';

class InheritedProvider<T> extends InheritedWidget {
  final T inheritedData;  

  InheritedProvider({
    Widget child,
    this.inheritedData,
  }) : super(child: child);

  @override
  bool updateShouldNotify(InheritedProvider oldWidget) =>
      inheritedData != oldWidget.inheritedData;

  static T of<T>(BuildContext context) =>
      (context.dependOnInheritedWidgetOfExactType<InheritedProvider<T>>())
          .inheritedData;
}
