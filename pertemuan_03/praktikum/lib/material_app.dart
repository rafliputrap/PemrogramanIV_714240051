import 'package:flutter/material.dart' as flutter;
import 'material_page.dart' as page;

class AppMaterial extends flutter.StatelessWidget {
  const AppMaterial({super.key});

  @override
  flutter.Widget build(flutter.BuildContext context) {
    return flutter.MaterialApp(
      debugShowCheckedModeBanner: true,
      home: const page.HomePage(),
    );
  }
}