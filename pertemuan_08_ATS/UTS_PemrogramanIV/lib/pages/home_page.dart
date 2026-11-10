import 'package:flutter/material.dart';

import '../config/profile.dart';
import '../models/contact_store.dart';

class HomePage extends StatelessWidget {
  final ContactStore store;
  final VoidCallback onOpenContacts;

  const HomePage({super.key, required this.store, required this.onOpenContacts});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const SizedBox(height: 16),
          CircleAvatar(
            radius: 48,
            backgroundColor: scheme.primaryContainer,
            child: Icon(Icons.contacts, size: 48, color: scheme.primary),
          ),
          const SizedBox(height: 20),
          Text('Selamat Datang di Aplikasi Kontak',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text('UTS Pemrograman IV',
              style: TextStyle(color: Colors.grey.shade700)),
          const SizedBox(height: 24),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _InfoRow(icon: Icons.person, label: 'Nama', value: Profile.name),
                  const Divider(),
                  _InfoRow(icon: Icons.badge, label: 'NPM', value: Profile.npm),
                  const Divider(),
                  _InfoRow(icon: Icons.school, label: 'Kelas', value: Profile.kelas),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Membuktikan data tetap ada saat berpindah halaman.
          ListenableBuilder(
            listenable: store,
            builder: (context, _) => Card(
              child: ListTile(
                leading: const Icon(Icons.people),
                title: Text('${store.count} kontak tersimpan'),
                subtitle: const Text('Ketuk untuk membuka Daftar Kontak'),
                trailing: const Icon(Icons.chevron_right),
                onTap: onOpenContacts,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _InfoRow({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 12),
        SizedBox(width: 56, child: Text(label)),
        Expanded(
          child: Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }
}
