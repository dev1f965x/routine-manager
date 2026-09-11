import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:routine_manager/main.dart';

void main() {
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  setUp(() async {
    await databaseFactory.deleteDatabase(
      join(await getDatabasesPath(), 'routines.db'),
    );
  });

  testWidgets('shows the title and the empty state', (tester) async {
    // Database I/O needs real async, which the default fake clock never advances.
    await tester.runAsync(() async {
      await tester.pumpWidget(const RoutineManagerApp());
      await Future<void>.delayed(const Duration(milliseconds: 300));
    });
    await tester.pump();

    expect(find.text('루틴 매니저'), findsOneWidget);
    expect(find.text('아직 추가된 루틴이 없습니다.'), findsOneWidget);
  });
}
