/// A daily routine and its completion streak.
class Routine {
  const Routine({
    this.id,
    required this.name,
    this.streak = 0,
    this.lastDoneAt,
  });

  factory Routine.fromMap(Map<String, Object?> map) {
    final lastDoneAt = map['lastDoneAt'] as String?;
    return Routine(
      id: map['id'] as int?,
      name: map['name'] as String,
      streak: map['streak'] as int,
      lastDoneAt: lastDoneAt == null ? null : DateTime.parse(lastDoneAt),
    );
  }

  final int? id;
  final String name;

  /// Consecutive days completed, as of [lastDoneAt].
  final int streak;
  final DateTime? lastDoneAt;

  Map<String, Object?> toMap() => {
    'id': id,
    'name': name,
    'streak': streak,
    'lastDoneAt': lastDoneAt?.toIso8601String(),
  };

  bool isDoneOn(DateTime day) =>
      lastDoneAt != null && _daysBetween(lastDoneAt!, day) == 0;

  /// The streak shown on [day]. Missing a whole day breaks it.
  int streakOn(DateTime day) =>
      lastDoneAt != null && _daysBetween(lastDoneAt!, day) <= 1 ? streak : 0;

  /// This routine after being completed at [now].
  Routine completedAt(DateTime now) =>
      Routine(id: id, name: name, streak: streakOn(now) + 1, lastDoneAt: now);
}

/// Whole calendar days from [from] to [to], ignoring the time of day.
int _daysBetween(DateTime from, DateTime to) {
  final start = DateTime.utc(from.year, from.month, from.day);
  final end = DateTime.utc(to.year, to.month, to.day);
  return end.difference(start).inDays;
}
