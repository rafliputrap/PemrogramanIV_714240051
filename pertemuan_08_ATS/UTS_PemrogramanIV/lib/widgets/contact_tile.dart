import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/contact.dart';
import 'file_thumb.dart';

class ContactTile extends StatelessWidget {
  final Contact contact;
  final bool selected;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ContactTile({
    super.key,
    required this.contact,
    required this.onEdit,
    required this.onDelete,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: selected ? 3 : 1,
      color: selected ? Theme.of(context).colorScheme.primaryContainer : null,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 10, 4, 10),
        child: Row(
          children: [
            FileThumb(path: contact.filePath, name: contact.fileName),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(contact.name,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(contact.phone),
                  Text(DateFormat('dd-MM-yyyy').format(contact.date)),
                  Text(contact.fileName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12, color: Colors.grey.shade700)),
                  const SizedBox(height: 6),
                  Container(
                    height: 8,
                    decoration: BoxDecoration(
                      color: contact.color,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              tooltip: 'Ubah',
              icon: const Icon(Icons.edit),
              onPressed: onEdit,
            ),
            IconButton(
              tooltip: 'Hapus',
              icon: const Icon(Icons.delete),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
