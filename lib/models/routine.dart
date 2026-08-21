class Routine {
  final int? id;
  final String name;
  final int streak;
  final DateTime? lastDoneAt;

  Routine({this.id, required this.name, this.streak = 0, this.lastDoneAt});

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'streak': streak,
      'lastDoneAt': lastDoneAt?.toIso8601String(),
    };
  }

  factory Routine.fromMap(Map<String, Object?> map) {
    return Routine(
      id: map['id'] as int?,
      name: map['name'] as String,
      streak: map['streak'] as int,
      lastDoneAt: map['lastDoneAt'] != null
          ? DateTime.parse(map['lastDoneAt'] as String)
          : null,
    );
  }

  bool get doneToday {
    if (lastDoneAt == null) return false;
    final now = DateTime.now();
    return lastDoneAt!.year == now.year &&
        lastDoneAt!.month == now.month &&
        lastDoneAt!.day == now.day;
  }
}
