import 'dart:ui' show Color;

/// Satu data kontak. Immutable; perubahan dilakukan lewat [copyWith].
class Contact {
  final int id;
  final String name;
  final String phone;
  final DateTime date;
  final Color color;
  final String filePath;
  final String fileName;

  const Contact({
    required this.id,
    required this.name,
    required this.phone,
    required this.date,
    required this.color,
    required this.filePath,
    required this.fileName,
  });

  Contact copyWith({
    String? name,
    String? phone,
    DateTime? date,
    Color? color,
    String? filePath,
    String? fileName,
  }) {
    return Contact(
      id: id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      date: date ?? this.date,
      color: color ?? this.color,
      filePath: filePath ?? this.filePath,
      fileName: fileName ?? this.fileName,
    );
  }
}
