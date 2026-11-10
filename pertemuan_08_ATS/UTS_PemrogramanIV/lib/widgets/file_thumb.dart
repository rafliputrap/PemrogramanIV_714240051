import 'dart:io';

import 'package:flutter/material.dart';

import '../utils/file_utils.dart';

/// Pratinjau gambar (JPG/JPEG/PNG) atau ikon dokumen untuk berkas lain.
class FileThumb extends StatelessWidget {
  final String path;
  final String name;
  final double size;
  final bool circle;

  const FileThumb({
    super.key,
    required this.path,
    required this.name,
    this.size = 48,
    this.circle = true,
  });

  @override
  Widget build(BuildContext context) {
    final fallback = Container(
      width: size,
      height: size,
      color: Colors.grey.shade300,
      child: Icon(Icons.insert_drive_file, size: size * 0.5, color: Colors.grey.shade700),
    );

    Widget child = fallback;
    if (isPreviewableImage(name)) {
      child = Image.file(
        File(path),
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => fallback,
      );
    }
    return circle
        ? ClipOval(child: child)
        : ClipRRect(borderRadius: BorderRadius.circular(8), child: child);
  }
}
