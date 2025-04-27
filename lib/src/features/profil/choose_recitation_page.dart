import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // Assuming you have GoRouter set up

class ChooseRecitationPage extends StatefulWidget {
  const ChooseRecitationPage({super.key});

  @override
  _ChooseRecitationPageState createState() => _ChooseRecitationPageState();
}

class _ChooseRecitationPageState extends State<ChooseRecitationPage> {
  // Variable to track selected recitation
  String? _selectedRecitation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Récitation'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 64),
                const SizedBox(height: 32),
                const Text(
                  "Sélectionnez la récitation que vous souhaitez utiliser",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                // Warsh Option
                ListTile(
                  title: const Text('Warsh'),
                  leading: _selectedRecitation == 'warsh'
                      ? const Icon(Icons.check_circle, color: Colors.green)
                      : const Icon(Icons.circle_outlined, color: Colors.grey),
                  onTap: () {
                    setState(() {
                      _selectedRecitation = 'warsh';
                    });
                    context.goNamed(
                        'warsh'); // Assurez-vous que vous avez défini une route pour "warsh"
                  },
                  tileColor: Theme.of(context).primaryColor.withOpacity(0.1),
                ),
                const SizedBox(height: 16),
                // Hafs Option
                ListTile(
                  title: const Text('Hafs'),
                  leading: _selectedRecitation == 'hafs'
                      ? const Icon(Icons.check_circle, color: Colors.green)
                      : const Icon(Icons.circle_outlined, color: Colors.grey),
                  onTap: () {
                    setState(() {
                      _selectedRecitation = 'hafs';
                    });
                    context.goNamed(
                        'hafs'); // Assurez-vous que vous avez défini une route pour "hafs"
                  },
                  tileColor: Theme.of(context).primaryColor.withOpacity(0.1),
                ),
                const SizedBox(height: 32),
                // Footer text with copyright and links
              ],
            ),
          ),
        ),
      ),
    );
  }
}
