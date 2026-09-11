import 'package:flutter/material.dart';

import 'routine_list_page.dart';

void main() => runApp(const RoutineManagerApp());

class RoutineManagerApp extends StatelessWidget {
  const RoutineManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '루틴 매니저',
      theme: ThemeData(colorSchemeSeed: Colors.black),
      home: const RoutineListPage(),
    );
  }
}
