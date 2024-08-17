import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:upi/upi_payment_screen.dart';

void main() {
  testWidgets('UpiPaymentScreen UI Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: UpiPaymentScreen(),
    ));

    // Verify that the title text is displayed.
    expect(find.text('Qeventz UPI'), findsOneWidget);

    // Verify that Payee Name field is present.
    expect(find.text('Payee Name'), findsOneWidget);

    // Verify that Enter UPI ID field is present.
    expect(find.text('Enter UPI ID'), findsOneWidget);

    // Verify that Amount field is present.
    expect(find.text('Amount'), findsOneWidget);

    // Verify that Generate QR Code button is present.
    expect(find.text('Generate QR Code'), findsOneWidget);
  });
}
