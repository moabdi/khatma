import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:khatma/src/features/khatma/presentation/success/widgets/success_widgets.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma_ui/constants/app_sizes.dart';

/// Success screen shown after creating a shared khatma
///
/// Displays join code and QR code for sharing with friends
class KhatmaSuccessScreen extends StatelessWidget {
  const KhatmaSuccessScreen({
    super.key,
    required this.khatmaId,
    required this.joinCode,
    this.khatmaName,
  });

  final String khatmaId;
  final String joinCode;
  final String? khatmaName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => context.go('/khatma'),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Success header with animation
              SuccessHeader(
                title: context.loc.khatmaCreatedSuccessfully,
                subtitle: khatmaName,
              ),
              gapH32,

              // Information banner
              InfoBanner(
                message: context.loc.joinInstructions,
                icon: Icons.info_outline,
              ),
              gapH24,

              // Join code card
              JoinCodeCard(
                code: joinCode,
                title: context.loc.joinCode,
              ),
              gapH24,

              // QR Code card
              QRCodeCard(
                data: joinCode,
                title: context.loc.scanQRCode,
                size: 200,
              ),
              gapH32,

              // Action buttons
              ActionButtons(
                primaryLabel: context.loc.viewKhatma,
                onPrimaryPressed: () {
                  context.go('/khatma/shared/$khatmaId');
                },
                secondaryLabel: context.loc.shareInvite,
                onSecondaryPressed: () {
                  _shareInvite(context);
                },
              ),
              gapH16,
            ],
          ),
        ),
      ),
    );
  }

  void _shareInvite(BuildContext context) {
    // TODO: Implement share functionality
    // You can use the share_plus package or native sharing
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(context.loc.shareInvite),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
