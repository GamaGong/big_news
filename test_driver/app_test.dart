import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('App lang test', () {
    final langPageButtonFinder = find.byValueKey('langSettings');
    final langTagFinder = find.byValueKey('langTag');
    final englishLocaleButtonFinder = find.byValueKey('🇺🇸');

    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test(
      'System Locale is selected',
      () async {
        await driver.tap(langPageButtonFinder);
        expect(await driver.getText(langTagFinder), 'sys');
      },
    );

    test(
      'Change locale',
      () async {
        await driver.tap(englishLocaleButtonFinder);
        expect(await driver.getText(langTagFinder), 'en');
      },
    );
  });
}
