import 'package:flutter/material.dart';

import 'db/database.dart';
import 'models/routine.dart';

class RoutineListPage extends StatefulWidget {
  const RoutineListPage({super.key});

  @override
  State<RoutineListPage> createState() => _RoutineListPageState();
}

class _RoutineListPageState extends State<RoutineListPage> {
  final _db = RoutineDatabase.instance;
  final _nameController = TextEditingController();
  List<Routine>? _routines;

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _refresh() async {
    final routines = await _db.readAll();
    if (mounted) setState(() => _routines = routines);
  }

  Future<void> _add() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;
    _nameController.clear();
    await _db.insert(Routine(name: name));
    await _refresh();
  }

  Future<void> _complete(Routine routine) async {
    await _db.update(routine.completedAt(DateTime.now()));
    await _refresh();
  }

  Future<void> _delete(Routine routine) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('"${routine.name}" 삭제'),
        content: const Text('연속 기록도 함께 사라집니다.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('삭제'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;

    await _db.delete(routine.id!);
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
                    controller: _nameController,
                    decoration: const InputDecoration(
                      hintText: '루틴 이름',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _add(),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(onPressed: _add, child: const Text('추가')),
              ],
            ),
          ),
          Expanded(child: _buildList()),
        ],
      ),
    );
  }

  Widget _buildList() {
    final routines = _routines;
    if (routines == null) {
      return const Center(child: CircularProgressIndicator());
    }
    if (routines.isEmpty) {
      return const Center(child: Text('아직 추가된 루틴이 없습니다.'));
    }

    final now = DateTime.now();
    return ListView.builder(
      itemCount: routines.length,
      itemBuilder: (context, index) {
        final routine = routines[index];
        final done = routine.isDoneOn(now);
        return ListTile(
          title: Text(routine.name),
          subtitle: Text('🔥 ${routine.streakOn(now)}일 연속'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FilledButton.tonal(
                onPressed: done ? null : () => _complete(routine),
                child: Text(done ? '완료 ✓' : '완료'),
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline),
                tooltip: '삭제',
                onPressed: () => _delete(routine),
              ),
            ],
          ),
        );
      },
    );
  }
}
