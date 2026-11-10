import 'package:flutter/material.dart';

class MyInputForm extends StatefulWidget {
  const MyInputForm({super.key});

  @override
  State<MyInputForm> createState() => MyInputFormState();
}

class MyInputFormState extends State<MyInputForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerNama = TextEditingController();

  final List<Map<String, String>> _myDataList = [];
  Map<String, String>? editedData;

  @override
  void dispose() {
    _controllerEmail.dispose();
    _controllerNama.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) return 'Email wajib diisi';
    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email)) {
      return 'Tolong inputkan email yang valid!';
    }
    return null;
  }

  String? _validateNama(String? value) {
    if (value == null || value.trim().length < 3) {
      return 'Minimal 3 karakter';
    }
    return null;
  }

  void _addData() {
    final name = _controllerNama.text.trim();
    final email = _controllerEmail.text.trim();
    final data = <String, String>{
      'name': name,
      'email': email,
    };

    setState(() {
      if (editedData != null) {
        editedData!['name'] = name;
        editedData!['email'] = email;
        editedData = null;
      } else {
        _myDataList.add(data);
      }
      _controllerNama.clear();
      _controllerEmail.clear();
    });
  }

  void _editData(Map<String, String> data) {
    setState(() {
      _controllerEmail.text = data['email']!;
      _controllerNama.text = data['name']!;
      editedData = data;
    });
  }

  void _deleteData(Map<String, String> data) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Data'),
          content: const Text('Yakin ingin menghapus data ini?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _myDataList.remove(data);
                  if (identical(editedData, data)) {
                    editedData = null;
                    _controllerNama.clear();
                    _controllerEmail.clear();
                  }
                });
                Navigator.of(context).pop();
              },
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Form Input')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _controllerEmail,
                    validator: _validateEmail,
                    decoration: const InputDecoration(labelText: 'Email'),
                  ),
                  TextFormField(
                    controller: _controllerNama,
                    validator: _validateNama,
                    decoration: const InputDecoration(labelText: 'Name'),
                  ),
                  ElevatedButton(
                    child: Text(editedData != null ? "Update" : "Submit"),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _addData();
                      }
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text('List Data', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: _myDataList.length,
                itemBuilder: (context, index) {
                  final data = _myDataList[index];
                  return ListTile(
                    title: Text(data['name'] ?? ''),
                    subtitle: Text(data['email'] ?? ''),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _editData(data),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deleteData(data),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}