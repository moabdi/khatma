import 'package:flutter/material.dart';
import 'package:khatma/src/features/authentication/presentation/widgets/app_logo.dart';
import 'package:khatma/src/features/authentication/presentation/widgets/footer_links.dart';
import 'package:khatma_ui/constants/app_sizes.dart';

enum ContactType {
  bug('Bug Report', Icons.bug_report),
  suggestion('Suggestion', Icons.lightbulb_outline),
  feedback('Feedback', Icons.feedback_outlined),
  other('Other', Icons.help_outline);

  const ContactType(this.label, this.icon);
  final String label;
  final IconData icon;
}

class ContactFormData {
  final String name;
  final String email;
  final String message;
  final ContactType contactType;

  const ContactFormData({
    required this.name,
    required this.email,
    required this.message,
    required this.contactType,
  });

  bool get isValid =>
      name.trim().isNotEmpty &&
      email.trim().isNotEmpty &&
      message.trim().isNotEmpty &&
      _isValidEmail(email);

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  String get formattedSubject =>
      '${contactType.label}: Contact Form Submission';

  String get formattedBody => '''
Name: $name
Email: $email
Contact Type: ${contactType.label}

Message:
$message

---
Sent via Khatma App Contact Form
''';

  @override
  String toString() {
    return 'ContactFormData(name: $name, email: $email, type: ${contactType.label})';
  }
}

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({super.key});

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  ContactType _selectedContactType = ContactType.feedback;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  ContactFormData get _formData => ContactFormData(
        name: _nameController.text,
        email: _emailController.text,
        message: _messageController.text,
        contactType: _selectedContactType,
      );

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    final formData = _formData;
    if (!formData.isValid) {
      _showSnackBar('Please fill in all fields with valid information.',
          isError: true);
      return;
    }

    setState(() => _isLoading = true);

    try {
      // TODO: Replace this with your actual email service integration
      await _simulateEmailSending(formData);

      _showSnackBar('Message sent successfully!');
      _clearForm();
    } catch (e) {
      _showSnackBar('Failed to send message. Please try again.', isError: true);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _simulateEmailSending(ContactFormData formData) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Here you would integrate with your email service
    // Example: EmailService.send(formData);
    print('Email would be sent with:');
    print('Subject: ${formData.formattedSubject}');
    print('Body: ${formData.formattedBody}');
  }

  void _clearForm() {
    _nameController.clear();
    _emailController.clear();
    _messageController.clear();
    setState(() => _selectedContactType = ContactType.feedback);
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red[600] : Colors.green[600],
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your name';
    }
    if (value.trim().length < 2) {
      return 'Name must be at least 2 characters';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validateMessage(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your message';
    }
    if (value.trim().length < 10) {
      return 'Message must be at least 10 characters';
    }
    return null;
  }

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
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  gapH32,
                  const AppLogo(),
                  gapH32,

                  // Contact Type Dropdown
                  DropdownButtonFormField<ContactType>(
                    value: _selectedContactType,
                    decoration: const InputDecoration(
                      labelText: 'Contact Type',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.category_outlined),
                    ),
                    items: ContactType.values.map((type) {
                      return DropdownMenuItem<ContactType>(
                        value: type,
                        child: Row(
                          children: [
                            Icon(type.icon, size: 20),
                            const SizedBox(width: 12),
                            Text(type.label),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (ContactType? value) {
                      if (value != null) {
                        setState(() => _selectedContactType = value);
                      }
                    },
                  ),
                  const SizedBox(height: 16),

                  // Name field
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Your Name',
                      hintText: 'Enter your name',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                    validator: _validateName,
                    textCapitalization: TextCapitalization.words,
                  ),
                  const SizedBox(height: 16),

                  // Email field
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter your email address',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                    validator: _validateEmail,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),

                  // Message field
                  TextFormField(
                    controller: _messageController,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      labelText: 'Message',
                      hintText: 'Write your message',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.message_outlined),
                      alignLabelWithHint: true,
                    ),
                    validator: _validateMessage,
                    textCapitalization: TextCapitalization.sentences,
                  ),
                  const SizedBox(height: 24),

                  // Submit button
                  ElevatedButton(
                    onPressed: _isLoading ? null : _handleSubmit,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Send Message'),
                  ),
                  gapH12,

                  // Divider with "Or" in the center
                  const Row(
                    children: [
                      Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          'Or',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
                  gapH12,

                  // Contact via email button
                  ElevatedButton.icon(
                    onPressed: () {
                      // Handle external contact method (e.g., open email app)
                      // You can use url_launcher to open email: mailto:support@yourapp.com
                    },
                    icon: const Icon(Icons.mail),
                    label: const Text('Contact via Email'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                    ),
                  ),
                  gapH24,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
