import 'package:flutter/material.dart';
import 'input_validation.dart';
import 'input_form.dart';
import 'advanced_form.dart';

class DynamicBottomNavbar extends StatefulWidget {
  const DynamicBottomNavbar({super.key});

  @override
  State<DynamicBottomNavbar> createState() => _DynamicBottomNavbarState();
}

class _DynamicBottomNavbarState extends State<DynamicBottomNavbar> {
  int _currentPageIndex = 0;

  final List<Widget> _pages = <Widget>[
    const MyInput(),
    const MyFormValidation(),
    const MyInputForm(),
    const AdvancedForm(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentPageIndex,
        onTap: onTabTapped,
        backgroundColor: Colors.blueAccent,
        selectedItemColor: Colors.yellow,
        unselectedItemColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.task_alt_outlined),
            label: 'Latihan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.input_outlined),
            label: 'Form Validation',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dynamic_form_rounded),
            label: 'Form Input',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.phone_iphone_rounded),
            label: 'Advanced Form',
          ),
        ],
      ),
    );
  }
}

// Widget Halaman 1: Latihan
class MyInput extends StatefulWidget {
  const MyInput({super.key});

  @override
  State<MyInput> createState() => MyInputState();
}

class MyInputState extends State<MyInput> {
  final TextEditingController _controller = TextEditingController();
  bool lightOn = false;
  String? language;
  bool agree = false;

  void showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Input Widget')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: 'Write your name here...',
                  labelText: 'Your Name',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                child: const Text('Submit'),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text('Hello, ${_controller.text}'),
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 20),
              const Divider(),
              Switch(
                value: lightOn,
                onChanged: (bool value) {
                  setState(() {
                    lightOn = value;
                  });
                  showSnackbar(lightOn ? 'Light On' : 'Light Off');
                },
              ),
              const Divider(),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RadioListTile<String>(
                    title: const Text('Dart'),
                    value: 'Dart',
                    groupValue: language,
                    onChanged: (String? value) {
                      setState(() {
                        language = value;
                        showSnackbar('Bahasa dipilih: $language');
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text('Kotlin'),
                    value: 'Kotlin',
                    groupValue: language,
                    onChanged: (String? value) {
                      setState(() {
                        language = value;
                        showSnackbar('Bahasa dipilih: $language');
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text('Swift'),
                    value: 'Swift',
                    groupValue: language,
                    onChanged: (String? value) {
                      setState(() {
                        language = value;
                        showSnackbar('Bahasa dipilih: $language');
                      });
                    },
                  ),
                ],
              ),
              const Divider(),
              CheckboxListTile(
                title: const Text('Agree / Disagree'),
                value: agree,
                onChanged: (bool? value) {
                  setState(() {
                    agree = value!;
                    showSnackbar(agree ? 'Setuju' : 'Tidak Setuju');
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}