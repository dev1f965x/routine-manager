import 'package:flutter_test/flutter_test.dart';

import 'package:routine_manager/models/routine.dart';

void main() {
  final monday = DateTime(2026, 9, 7, 21);
  final tuesday = DateTime(2026, 9, 8, 7);
  final thursday = DateTime(2026, 9, 10, 12);

  test('a new routine starts its streak at 1', () {
    final routine = const Routine(name: 'run').completedAt(monday);
    expect(routine.streak, 1);
    expect(routine.isDoneOn(monday), isTrue);
    expect(routine.isDoneOn(tuesday), isFalse);
  });

  test('completing on consecutive days extends the streak', () {
    final routine = const Routine(
      name: 'run',
    ).completedAt(monday).completedAt(tuesday);
    expect(routine.streak, 2);
    expect(routine.streakOn(tuesday), 2);
  });

  test('missing a whole day breaks the streak', () {
    final routine = const Routine(name: 'run').completedAt(monday);
    expect(routine.streakOn(tuesday), 1);
    expect(routine.streakOn(thursday), 0);
    expect(routine.completedAt(thursday).streak, 1);
  });

  test('round-trips through a database row', () {
    final routine = Routine(id: 3, name: 'read', streak: 4, lastDoneAt: monday);
    final restored = Routine.fromMap(routine.toMap());
    expect(restored.id, 3);
    expect(restored.name, 'read');
    expect(restored.streak, 4);
    expect(restored.lastDoneAt, monday);
  });
}
