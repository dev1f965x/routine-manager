import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'db/database.dart';
import 'models/routine.dart';

void main() {
  // sqflite는 원래 Android/iOS용이라, Windows/Linux 데스크톱에서 테스트하려면
  // FFI 기반 구현으로 교체해줘야 함. 모바일에서는 이 분기를 안 타서 그대로 동작.
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux)) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
  runApp(const RoutineManagerApp());
}

class RoutineManagerApp extends StatelessWidget {
  const RoutineManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Routine Manager',
      theme: ThemeData(colorSchemeSeed: Colors.black, useMaterial3: true),
      home: const RoutineListPage(),
    );
  }
}

class RoutineListPage extends StatefulWidget {
  const RoutineListPage({super.key});

  @override
  State<RoutineListPage> createState() => _RoutineListPageState();
}

class _RoutineListPageState extends State<RoutineListPage> {
  List<Routine> _routines = [];
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  Future<void> _refresh() async {
    final routines = await RoutineDatabase.instance.readAll();
    setState(() => _routines = routines);
  }

  Future<void> _addRoutine() async {
    final name = _controller.text.trim();
    if (name.isEmpty) return;
    await RoutineDatabase.instance.create(Routine(name: name));
    _controller.clear();
    await _refresh();
  }

  Future<void> _completeRoutine(Routine routine) async {
    if (routine.doneToday || routine.id == null) return;
    await RoutineDatabase.instance.complete(
      routine.id!,
      routine.streak + 1,
      DateTime.now(),
    );
    await _refresh();
  }

  Future<void> _deleteRoutine(Routine routine) async {
    if (routine.id == null) return;
    await RoutineDatabase.instance.delete(routine.id!);
    await _refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('루틴 매니저')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: '루틴 이름',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _addRoutine(),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(onPressed: _addRoutine, child: const Text('추가')),
              ],
            ),
          ),
          Expanded(
            child: _routines.isEmpty
                ? const Center(child: Text('아직 추가된 루틴이 없습니다.'))
                : ListView.builder(
                    itemCount: _routines.length,
                    itemBuilder: (context, index) {
                      final routine = _routines[index];
                      return ListTile(
                        title: Text(routine.name),
                        subtitle: Text('🔥 ${routine.streak}일 연속'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            FilledButton.tonal(
                              onPressed: routine.doneToday
                                  ? null
                                  : () => _completeRoutine(routine),
                              child: Text(routine.doneToday ? '완료 ✓' : '완료'),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete_outline),
                              onPressed: () => _deleteRoutine(routine),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
