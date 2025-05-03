import 'package:flutter/material.dart';
import 'package:khatma/src/features/authentication/presentation/widgets/footer_links.dart';
import 'package:khatma_ui/constants/app_sizes.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({super.key});

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  String _message = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Us'),
        centerTitle: true,
      ),
      floatingActionButton: const FooterLinks(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                gapH64,
                CircleAvatar(
                  backgroundColor: Theme.of(context).disabledColor,
                  radius: 50,
                  backgroundImage: AssetImage(
                    'assets/khatma.png', // Add your logo in assets
                  ),
                ),
                gapH64,

                // Name field
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Your Name',
                    hintText: 'Enter your name',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _name = value;
                    });
                  },
                ),
                const SizedBox(height: 16),

                // Email field
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your email address',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _email = value;
                    });
                  },
                ),
                const SizedBox(height: 16),

                // Message field
                TextField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    labelText: 'Message',
                    hintText: 'Write your message',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _message = value;
                    });
                  },
                ),
                const SizedBox(height: 24),

                // Submit button
                ElevatedButton(
                  onPressed: () {
                    // Handle contact form submission logic
                    if (_formKey.currentState!.validate()) {
                      // Process the data, perhaps send an email or log it
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Message sent')),
                      );
                    }
                  },
                  child: const Text('Send Message'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                ),
                gapH24,

                // Divider with "Or" in the center
                Row(
                  children: const [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text('Or',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
                gapH24,

                // Contact via social links (e.g., Google)
                ElevatedButton.icon(
                  onPressed: () {
                    // Handle external contact method (e.g., Google)
                  },
                  icon: const Icon(Icons.mail),
                  label: const Text('Contact via Email'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: Colors.blueAccent,
                  ),
                ),
                gapH24,
                Text(_email),
                Text(_message),
                Text(_name),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
