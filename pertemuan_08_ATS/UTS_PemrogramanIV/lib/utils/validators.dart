/// Aturan validasi sesuai soal. Mengembalikan pesan error, atau null jika valid.
class Validators {
  Validators._();

  static final RegExp _lettersAndSpaces = RegExp(r'^[A-Za-z ]+$');
  static final RegExp _capitalWord = RegExp(r'^[A-Z][A-Za-z]*$');
  static final RegExp _phone = RegExp(r'^62[0-9]{6,11}$');

  /// Nama: minimal 2 kata, hanya huruf & spasi, tiap kata diawali huruf kapital.
  /// Spasi di awal/akhir diabaikan.
  static String? name(String? value) {
    final text = (value ?? '').trim();
    if (text.isEmpty) return 'Nama wajib diisi';
    if (!_lettersAndSpaces.hasMatch(text)) {
      return 'Nama hanya boleh berisi huruf dan spasi';
    }
    final words = text.split(RegExp(r' +'));
    if (words.length < 2) return 'Nama minimal terdiri dari dua kata';
    if (!words.every(_capitalWord.hasMatch)) {
      return 'Setiap kata harus diawali huruf kapital';
    }
    return null;
  }

  /// Telepon: hanya digit, diawali 62 (tanpa +), total 8-13 digit.
  static String? phone(String? value) {
    final text = value ?? '';
    if (text.isEmpty) return 'Nomor telepon wajib diisi';
    if (!RegExp(r'^[0-9]+$').hasMatch(text)) {
      return 'Nomor telepon hanya boleh berisi angka 0-9 (tanpa +)';
    }
    if (!text.startsWith('62')) return 'Nomor telepon harus diawali 62';
    if (!_phone.hasMatch(text)) {
      return 'Panjang nomor telepon harus 8-13 digit (termasuk 62)';
    }
    return null;
  }

  static String? date(DateTime? value) =>
      value == null ? 'Tanggal wajib dipilih' : null;

  static String? file(String? path) =>
      (path == null || path.isEmpty) ? 'Berkas wajib dipilih' : null;
}
