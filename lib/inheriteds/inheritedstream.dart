import 'package:flutter/material.dart';

import 'package:frideos/frideos.dart';

import '../models/data.dart';

class InheritedStreamedDataProvider extends InheritedWidget {
  final StreamedValue<Data> data;

  InheritedStreamedDataProvider({
    Widget child,
    this.data,
  }) : super(child: child);

  @override
  bool updateShouldNotify(InheritedStreamedDataProvider oldWidget) =>
      data.value != oldWidget.data.value;

  static InheritedStreamedDataProvider of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(InheritedStreamedDataProvider);
}

