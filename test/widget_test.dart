import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:routine_manager/main.dart';

void main() {
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  testWidgets('App shows the title and empty state', (WidgetTester tester) async {
    await tester.pumpWidget(const RoutineManagerApp());
    await tester.pump();

    expect(find.text('루틴 매니저'), findsOneWidget);
    expect(find.text('아직 추가된 루틴이 없습니다.'), findsOneWidget);
  });
}
