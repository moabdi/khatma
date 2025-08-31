import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:khatma/src/features/authentication/presentation/widgets/app_logo.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma_ui/constants/app_sizes.dart';

enum ContactType {
  bug('bug_report', Icons.bug_report),
  suggestion('suggestion', Icons.lightbulb_outline),
  feedback('feedback', Icons.feedback_outlined),
  other('other', Icons.help_outline);

  const ContactType(this.key, this.icon);
  final String key;
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

  String getLocalizedSubject(BuildContext context) {
    final contactTypeName = _getContactTypeName(context);
    return context.loc.contactFormSubject(contactTypeName);
  }

  String _getContactTypeName(BuildContext context) {
    switch (contactType) {
      case ContactType.bug:
        return context.loc.bugReport;
      case ContactType.suggestion:
        return context.loc.suggestion;
      case ContactType.feedback:
        return context.loc.feedback;
      case ContactType.other:
        return context.loc.other;
    }
  }

  String getLocalizedBody(BuildContext context) => '''
    $message

    ---
    ${context.loc.sentViaKhatmaApp}
  ''';

  @override
  String toString() {
    return 'ContactFormData(name: $name, email: $email, type: ${contactType.key})';
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
      _showSnackBar(context.loc.pleaseFillAllFieldsValid, isError: true);
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Send email using flutter_email_sender
      await _sendEmail(formData);

      _showSnackBar(context.loc.messageSentSuccessfully);
      _clearForm();
    } catch (e) {
      _showSnackBar(context.loc.failedToSendMessage, isError: true);
      print('Error sending contact form: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _sendEmail(ContactFormData formData) async {
    final Email email = Email(
      body: formData.getLocalizedBody(context),
      subject: formData.getLocalizedSubject(context),
      recipients: ['support@khatma.app'], // Replace with your support email
      isHTML: false,
    );

    try {
      await FlutterEmailSender.send(email);
    } catch (error) {
      print('Email sending error: $error');
      // Re-throw to be caught by the calling method
      throw Exception('Failed to send email: $error');
    }
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
      return context.loc.pleaseEnterYourName;
    }
    if (value.trim().length < 2) {
      return context.loc.nameMustBeAtLeast2Characters;
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return context.loc.pleaseEnterYourEmail;
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return context.loc.pleaseEnterValidEmail;
    }
    return null;
  }

  String? _validateMessage(String? value) {
    if (value == null || value.trim().isEmpty) {
      return context.loc.pleaseEnterYourMessage;
    }
    if (value.trim().length < 10) {
      return context.loc.messageMustBeAtLeast10Characters;
    }
    return null;
  }

  String _getContactTypeLabel(ContactType type) {
    switch (type) {
      case ContactType.bug:
        return context.loc.bugReport;
      case ContactType.suggestion:
        return context.loc.suggestion;
      case ContactType.feedback:
        return context.loc.feedback;
      case ContactType.other:
        return context.loc.other;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.contactUs),
        centerTitle: true,
      ),
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
                    decoration: InputDecoration(
                      labelText: context.loc.contactType,
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.category_outlined),
                    ),
                    items: ContactType.values.map((type) {
                      return DropdownMenuItem<ContactType>(
                        value: type,
                        child: Row(
                          children: [
                            Icon(type.icon, size: 20),
                            const SizedBox(width: 12),
                            Text(_getContactTypeLabel(type)),
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
                    decoration: InputDecoration(
                      labelText: context.loc.yourName,
                      hintText: context.loc.enterYourName,
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.person_outline),
                    ),
                    validator: _validateName,
                    textCapitalization: TextCapitalization.words,
                  ),
                  const SizedBox(height: 16),

                  // Email field
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: context.loc.email,
                      hintText: context.loc.enterYourEmail,
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.email_outlined),
                    ),
                    validator: _validateEmail,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),

                  // Message field
                  TextFormField(
                    controller: _messageController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      labelText: context.loc.message,
                      hintText: context.loc.writeYourMessage,
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.message_outlined),
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
                        : Text(context.loc.sendMessage),
                  ),
                  gapH12,

                  // Divider with "Or" in the center
                  Row(
                    children: [
                      const Expanded(child: Divider()),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          context.loc.or,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Expanded(child: Divider()),
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
                    label: Text(context.loc.contactViaEmail),
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
