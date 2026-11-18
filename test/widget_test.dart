import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:edupu_desktop/main.dart';

void main() {
  testWidgets('EdupuDesktopApp smoke test', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1280, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const EdupuDesktopApp());
    expect(find.textContaining('Portal Pembelajaran Digital'), findsOneWidget);
    expect(find.text('Masuk ke Dasbor Sistem'), findsOneWidget);
  });
}
