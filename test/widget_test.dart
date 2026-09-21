import 'package:flutter_test/flutter_test.dart';
import 'package:fit_routine_expense/main.dart';

void main() {
  testWidgets('FitRoutineExpenseApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const FitRoutineExpenseApp());
    expect(find.text('FitRoutine & Expense'), findsOneWidget);
  });
}
