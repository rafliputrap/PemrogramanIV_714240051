import 'dart:ui' show Color;
import 'package:flutter/foundation.dart';

import 'contact.dart';

/// Penyimpanan sementara (in-memory) untuk daftar kontak.
/// Dibuat sekali di shell aplikasi sehingga data tetap ada saat pindah halaman.
class ContactStore extends ChangeNotifier {
  final List<Contact> _items = [];
  int _nextId = 1;

  List<Contact> get items => List.unmodifiable(_items);
  int get count => _items.length;

  void add({
    required String name,
    required String phone,
    required DateTime date,
    required Color color,
    required String filePath,
    required String fileName,
  }) {
    _items.add(Contact(
      id: _nextId++,
      name: name,
      phone: phone,
      date: date,
      color: color,
      filePath: filePath,
      fileName: fileName,
    ));
    notifyListeners();
  }

  /// Mengganti isi kontak dengan [id] yang sama, tanpa menambah kontak baru.
  void update(Contact updated) {
    final i = _items.indexWhere((c) => c.id == updated.id);
    if (i == -1) return;
    _items[i] = updated;
    notifyListeners();
  }

  void remove(int id) {
    _items.removeWhere((c) => c.id == id);
    notifyListeners();
  }
}
