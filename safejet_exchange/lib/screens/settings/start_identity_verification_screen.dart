import 'package:flutter/material.dart';
import '../../config/theme/colors.dart';
import '../../providers/kyc_provider.dart';
import 'sumsub_verification_screen.dart';
import 'package:provider/provider.dart';
import '../support/support_screen.dart';
import '../../widgets/p2p_app_bar.dart';

class StartIdentityVerificationScreen extends StatefulWidget {
  const StartIdentityVerificationScreen({Key? key}) : super(key: key);

  @override
  State<StartIdentityVerificationScreen> createState() => _StartIdentityVerificationScreenState();
}

class _StartIdentityVerificationScreenState extends State<StartIdentityVerificationScreen> {
  bool _loading = false;
  String? _error;

  Future<void> _startVerification() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final result = await Provider.of<KYCProvider>(context, listen: false).startDocumentVerification();
      if (!mounted) return;
      if (result['token'] != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SumsubVerificationScreen(accessToken: result['token']!),
          ),
        );
      } else {
        String? message = result['message']?.toString().toLowerCase();
        if (message != null && (message.contains('not enough credit') || message.contains('402'))) {
          _error = 'Automatic verification is currently unavailable. Contact support for manual KYC verification.';
        } else {
          _error = result['message'] ?? 'Unable to start verification';
        }
        setState(() {});
      }
    } catch (e) {
      String errorMsg = e.toString().toLowerCase();
      if (errorMsg.contains('not enough credit') || errorMsg.contains('402')) {
        setState(() {
          _error = 'Automatic verification is currently unavailable. Contact support for manual KYC verification.';
        });
      } else {
        setState(() {
          _error = e.toString().replaceAll('Exception: ', '');
        });
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: P2PAppBar(
        title: 'Identity Verification',
        hasNotification: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.verified_user, size: 60, color: SafeJetColors.secondaryHighlight),
            const SizedBox(height: 24),
            Text(
              'You are ready to start identity verification.',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            if (_error != null) ...[
              Text(
                _error!,
                style: const TextStyle(color: SafeJetColors.error, fontSize: 14),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
            ],
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _loading ? null : _startVerification,
                style: ElevatedButton.styleFrom(
                  backgroundColor: SafeJetColors.secondaryHighlight,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _loading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Start Verification', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 32),
            _buildSupportNotice(context, isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildSupportNotice(BuildContext context, bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isDark
            ? SafeJetColors.primaryAccent.withOpacity(0.10)
            : SafeJetColors.lightCardBackground,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isDark
              ? SafeJetColors.secondaryHighlight.withOpacity(0.18)
              : SafeJetColors.lightCardBorder,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: SafeJetColors.secondaryHighlight.withOpacity(0.13),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.support_agent_rounded,
                  color: SafeJetColors.secondaryHighlight,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Having trouble with verification?',
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Contact support to complete your verification.',
                      style: TextStyle(
                        color: isDark ? Colors.grey[400] : Colors.grey[700],
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SupportScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: SafeJetColors.secondaryHighlight,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Contact Support',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
} 