import 'package:flutter_test/flutter_test.dart';
import 'package:uts_pemrograman_iv/utils/validators.dart';

void main() {
  test('validasi nama', () {
    expect(Validators.name('Budi Santoso'), isNull);
    expect(Validators.name('  Budi   Santoso  '), isNull);
    expect(Validators.name('Budi'), isNotNull); // satu kata
    expect(Validators.name('budi Santoso'), isNotNull); // huruf kecil
    expect(Validators.name('Budi Santoso2'), isNotNull); // angka
    expect(Validators.name('   '), isNotNull);
  });

  test('validasi telepon', () {
    expect(Validators.phone('628123456789'), isNull);
    expect(Validators.phone('6212345'), isNotNull); // 7 digit
    expect(Validators.phone('62123456'), isNull); // 8 digit
    expect(Validators.phone('6212345678901'), isNull); // 13 digit
    expect(Validators.phone('62123456789012'), isNotNull); // 14 digit
    expect(Validators.phone('+628123456789'), isNotNull);
    expect(Validators.phone('081234567890'), isNotNull);
  });
}
