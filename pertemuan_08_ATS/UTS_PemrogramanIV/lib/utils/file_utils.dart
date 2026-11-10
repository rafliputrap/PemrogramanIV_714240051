/// Bantuan untuk mengenali berkas gambar yang dapat dipratinjau.
bool isPreviewableImage(String nameOrPath) {
  final lower = nameOrPath.toLowerCase();
  return lower.endsWith('.jpg') ||
      lower.endsWith('.jpeg') ||
      lower.endsWith('.png');
}
