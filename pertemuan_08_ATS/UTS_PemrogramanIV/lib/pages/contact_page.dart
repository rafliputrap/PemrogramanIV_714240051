import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:intl/intl.dart';

import '../models/contact.dart';
import '../models/contact_store.dart';
import '../utils/validators.dart';
import '../widgets/contact_tile.dart';
import '../widgets/file_thumb.dart';

class ContactPage extends StatefulWidget {
  final ContactStore store;
  const ContactPage({super.key, required this.store});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  static const Color _defaultColor = Color(0xFF00BCD4);
  static final DateFormat _dateFormat = DateFormat('dd-MM-yyyy');

  final _formKey = GlobalKey<FormState>();
  final _fileKey = GlobalKey<FormFieldState<String>>();
  final _scrollController = ScrollController();
  final _nameC = TextEditingController();
  final _phoneC = TextEditingController();
  final _dateC = TextEditingController();

  DateTime? _date;
  Color _color = _defaultColor;
  String? _filePath;
  String? _fileName;
  int? _editingId; // null = mode tambah, selain itu = mode ubah

  bool get _isEditing => _editingId != null;

  @override
  void dispose() {
    _scrollController.dispose();
    _nameC.dispose();
    _phoneC.dispose();
    _dateC.dispose();
    super.dispose();
  }

  // ---------------------------------------------------------------- pickers

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked == null) return; // dibatalkan: pilihan lama dipertahankan
    setState(() {
      _date = picked;
      _dateC.text = _dateFormat.format(picked);
    });
  }

  Future<void> _pickColor() async {
    var temp = _color;
    final picked = await showDialog<Color>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Pick Your Color'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: temp,
            onColorChanged: (c) => temp = c,
            enableAlpha: false,
            labelTypes: const [ColorLabelType.rgb],
            pickerAreaHeightPercent: 0.7,
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(ctx, temp), child: const Text('Save')),
        ],
      ),
    );
    if (picked == null) return;
    setState(() => _color = picked);
  }

  Future<void> _pickFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(type: FileType.any);
      if (result == null || result.files.isEmpty) return; // dibatalkan
      final file = result.files.single;
      if (file.path == null) {
        _snack('Berkas tidak dapat diakses, coba pilih berkas lain', error: true);
        return;
      }
      if (!mounted) return;
      setState(() {
        _filePath = file.path;
        _fileName = file.name;
      });
      _fileKey.currentState?.didChange(file.path);
    } catch (e) {
      if (mounted) _snack('Gagal memilih berkas: $e', error: true);
    }
  }

  // ---------------------------------------------------------------- actions

  void _snack(String message, {bool error = false}) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.clearSnackBars();
    messenger.showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: error ? Colors.red.shade700 : Colors.green.shade600,
    ));
  }

  void _clearForm() {
    _formKey.currentState?.reset();
    _nameC.clear();
    _phoneC.clear();
    _dateC.clear();
    setState(() {
      _date = null;
      _color = _defaultColor;
      _filePath = null;
      _fileName = null;
      _editingId = null;
    });
  }

  void _submit() {
    final formOk = _formKey.currentState!.validate();
    final errors = <String?>[
      Validators.name(_nameC.text),
      Validators.phone(_phoneC.text),
      Validators.date(_date),
      Validators.file(_filePath),
    ].whereType<String>().toList();
    if (!formOk || errors.isNotEmpty) {
      _snack('Harap lengkapi semua form dengan benar:\n• ${errors.join('\n• ')}',
          error: true);
      return; // data tidak disimpan
    }

    final name = _nameC.text.trim().split(RegExp(r' +')).join(' ');
    final phone = _phoneC.text;

    if (_isEditing) {
      final old = widget.store.items.firstWhere((c) => c.id == _editingId);
      widget.store.update(old.copyWith(
        name: name,
        phone: phone,
        date: _date,
        color: _color,
        filePath: _filePath,
        fileName: _fileName,
      ));
      _snack('Data berhasil diperbarui');
    } else {
      widget.store.add(
        name: name,
        phone: phone,
        date: _date!,
        color: _color,
        filePath: _filePath!,
        fileName: _fileName!,
      );
      _snack('Data berhasil ditambahkan');
    }
    _clearForm();
  }

  void _startEdit(Contact c) {
    _formKey.currentState?.reset(); // hapus pesan error lama
    setState(() {
      _editingId = c.id;
      _date = c.date;
      _color = c.color;
      _filePath = c.filePath;
      _fileName = c.fileName;
    });
    _nameC.text = c.name;
    _phoneC.text = c.phone;
    _dateC.text = _dateFormat.format(c.date);
    _fileKey.currentState?.didChange(c.filePath);
    if (_scrollController.hasClients) {
      _scrollController.animateTo(0,
          duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    }
  }

  Future<void> _confirmDelete(Contact c) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hapus kontak?'),
        content: Text('Kontak "${c.name}" akan dihapus.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Batal')),
          TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Hapus')),
        ],
      ),
    );
    if (ok != true || !mounted) return;
    if (_editingId == c.id) _clearForm();
    widget.store.remove(c.id);
    _snack('Data berhasil dihapus');
  }

  // ------------------------------------------------------------------- build

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildForm(),
          const SizedBox(height: 24),
          Text('List Contact',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          ListenableBuilder(
            listenable: widget.store,
            builder: (context, _) {
              final items = widget.store.items;
              if (items.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.all(24),
                  child: Text('Belum ada kontak', textAlign: TextAlign.center),
                );
              }
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: items.length,
                itemBuilder: (context, i) {
                  final c = items[i];
                  return ContactTile(
                    contact: c,
                    selected: c.id == _editingId,
                    onEdit: () => _startEdit(c),
                    onDelete: () => _confirmDelete(c),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (_isEditing)
            const Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Text('Mode ubah kontak',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          TextFormField(
            controller: _phoneC,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              labelText: 'Phone Number',
              hintText: '628123456789',
              border: OutlineInputBorder(),
            ),
            validator: Validators.phone,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _nameC,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              labelText: 'Name',
              hintText: 'Contoh: Budi Santoso',
              border: OutlineInputBorder(),
            ),
            validator: Validators.name,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _dateC,
            readOnly: true,
            onTap: _pickDate,
            decoration: const InputDecoration(
              labelText: 'Date',
              hintText: 'dd-MM-yyyy',
              border: OutlineInputBorder(),
              suffixIcon: Icon(Icons.calendar_today),
            ),
            validator: (_) => Validators.date(_date),
          ),
          const SizedBox(height: 16),
          const Text('Color', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Container(
            height: 72,
            decoration: BoxDecoration(
              color: _color,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.black12),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: TextButton.icon(
              onPressed: _pickColor,
              icon: const Icon(Icons.palette),
              label: const Text('Pick Color'),
            ),
          ),
          const SizedBox(height: 8),
          const Text('Pick Files', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          FormField<String>(
            key: _fileKey,
            validator: (_) => Validators.file(_filePath),
            builder: (state) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    FilledButton.tonalIcon(
                      onPressed: _pickFile,
                      icon: const Icon(Icons.attach_file),
                      label: const Text('Pick File'),
                    ),
                    const SizedBox(width: 12),
                    if (_filePath != null) ...[
                      FileThumb(
                          path: _filePath!, name: _fileName ?? '', size: 40, circle: false),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(_fileName ?? '',
                            maxLines: 2, overflow: TextOverflow.ellipsis),
                      ),
                    ] else
                      const Expanded(child: Text('Belum ada berkas dipilih')),
                  ],
                ),
                if (state.hasError)
                  Padding(
                    padding: const EdgeInsets.only(top: 6, left: 4),
                    child: Text(state.errorText!,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.error, fontSize: 12)),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (_isEditing) ...[
                OutlinedButton(onPressed: _clearForm, child: const Text('Cancel')),
                const SizedBox(width: 8),
              ],
              FilledButton(
                onPressed: _submit,
                child: Text(_isEditing ? 'Update' : 'Submit'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
