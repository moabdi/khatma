import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:khatma/src/features/authentication/presentation/widgets/app_logo.dart';
import 'package:khatma/src/features/info/presentation/validators/contact_validators.dart';
import 'package:khatma/src/features/info/presentation/widgets/contact_method_bottom_sheet.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma_ui/constants/app_sizes.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({super.key});

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage>
    with ContactFormValidatorsMixin {
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
    // Set the submitted flag to show validation errors
    setFormSubmitted();
    setState(() {}); // Trigger rebuild to show validation errors

    // Validate the form
    if (!_formKey.currentState!.validate()) return;

    // Double-check with our mixin validation
    final validatedData = getValidatedContactFormData(
      name: _nameController.text,
      email: _emailController.text,
      message: _messageController.text,
      contactType: _selectedContactType,
    );

    if (validatedData == null) {
      _showSnackBar(context.loc.pleaseFillAllFieldsValid, isError: true);
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Send email using flutter_email_sender
      await _sendEmail(validatedData);

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
    setState(() {
      _selectedContactType = ContactType.feedback;
      resetFormSubmitted(); // Reset the submitted state
    });
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
                    validator: (value) => validateContactName(value, context),
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
                    validator: (value) => validateContactEmail(value, context),
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
                    validator: (value) =>
                        validateContactMessage(value, context),
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

                  // Contact via email button - now opens modal
                  ElevatedButton.icon(
                    onPressed: () => ContactMethodBottomSheet.show(context),
                    icon: const Icon(Icons.mail),
                    label: Text(context.loc.contactViaEmail),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
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
