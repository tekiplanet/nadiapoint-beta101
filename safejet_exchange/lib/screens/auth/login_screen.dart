import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../../config/theme/colors.dart';
import 'registration_screen.dart';
import 'forgot_password_screen.dart';
import '../main/home_screen.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/biometric_settings_provider.dart';
import '../../services/biometric_settings_service.dart';
import 'two_factor_auth_screen.dart';
import 'email_verification_screen.dart';
import 'package:flutter/gestures.dart';
import '../support/webview_screen.dart';
import '../../services/home_service.dart';

class LoginScreen extends StatefulWidget {
  final String? message;

  const LoginScreen({super.key, this.message});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _showBiometricButton = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkBiometricAvailability();
    });
    if (widget.message != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(widget.message!),
            backgroundColor: SafeJetColors.error,
            behavior: SnackBarBehavior.floating,
          ),
        );
      });
    }
  }

  Future<void> _checkBiometricAvailability() async {
    try {
      final biometricService = BiometricSettingsService();
      final isAvailable = await biometricService.isBiometricAvailable();
      if (mounted) {
        setState(() {
          _showBiometricButton = isAvailable;
        });
      }
    } catch (e) {
      print('Error checking biometric availability');
    }
  }

  Future<void> _handleBiometricLogin() async {
    try {
      setState(() => _isLoading = true);
      
      print('=== Starting Biometric Login ===');
      final biometricService = BiometricSettingsService();
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      
      // Authenticate and get tokens
      final authenticated = await biometricService.authenticateAndGetTokens();
      if (!authenticated) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Biometric authentication failed')),
          );
        }
        return;
      }

      // Get tokens after successful authentication
      final tokens = await biometricService.getBiometricTokens();
      if (tokens['token'] == null || tokens['refreshToken'] == null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No valid tokens found')),
          );
        }
        return;
      }

      // Login with the tokens
      await authProvider.loginWithTokens(
        tokens['token']!,
        tokens['refreshToken']!,
      );

      // Navigate to home screen
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    } catch (e) {
      print('Error in biometric login');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: SafeJetColors.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: isDark
                    ? [
                        SafeJetColors.darkGradientStart,
                        SafeJetColors.darkGradientEnd,
                      ]
                    : [
                        SafeJetColors.lightGradientStart,
                        SafeJetColors.lightGradientEnd,
                      ],
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    // Logo and Welcome Text
                    FadeInDown(
                      duration: const Duration(milliseconds: 800),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome Back',
                            style: theme.textTheme.headlineLarge,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Sign in to continue',
                            style: theme.textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    // Login Form
                    FadeInUp(
                      duration: const Duration(milliseconds: 800),
                      delay: const Duration(milliseconds: 400),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            // Email Field
                            _buildTextField(
                              controller: _emailController,
                              label: 'Email',
                              hint: 'Enter your email',
                            ),
                            const SizedBox(height: 20),
                            // Password Field
                            _buildTextField(
                              controller: _passwordController,
                              label: 'Password',
                              hint: 'Enter your password',
                              isPassword: true,
                            ),
                            const SizedBox(height: 12),
                            // Forgot Password
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const ForgotPasswordScreen(),
                                    ),
                                  );
                                },
                                child: Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                    color: SafeJetColors.secondaryHighlight,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 32),
                            // Login Button
                            _buildLoginButton(),
                            const SizedBox(height: 24),
                            // Or Divider
                            Row(
                              children: [
                                Expanded(child: Divider(color: Colors.grey[700])),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  child: Text(
                                    'Or continue with',
                                    style: TextStyle(color: Colors.grey[400]),
                                  ),
                                ),
                                Expanded(child: Divider(color: Colors.grey[700])),
                              ],
                            ),
                            const SizedBox(height: 24),
                            // Social Login Buttons
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildSocialButton(
                                  icon: Icons.g_mobiledata_rounded,
                                  label: 'Google',
                                  onPressed: () {
                                    // TODO: Implement Google login
                                  },
                                ),
                                _buildSocialButton(
                                  icon: Icons.facebook_rounded,
                                  label: 'Facebook',
                                  onPressed: () {
                                    // TODO: Implement Facebook login
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            // Sign Up Link
                            _buildSignUpLink(),
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Text.rich(
                        TextSpan(
                          text: 'Having trouble? ',
                          style: TextStyle(color: Colors.grey[400]),
                          children: [
                            TextSpan(
                              text: 'Contact support',
                              style: TextStyle(
                                color: SafeJetColors.secondaryHighlight,
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  print('Contact support tapped');
                                  try {
                                    print('Showing loading indicator');
                                    // Show loading indicator
                                    showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (context) => const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );

                                    print('Creating HomeService');
                                    final homeService = HomeService();
                                    print('Fetching contact info...');
                                    final contactInfo = await homeService.getContactInfo();
                                    print('Contact info received: $contactInfo');
                                    
                                    // Close loading indicator
                                    if (context.mounted) {
                                      Navigator.pop(context);
                                    }

                                    final liveChatUrl = contactInfo['supportLinks']['liveChat'];
                                    print('Live chat URL: $liveChatUrl');
                                    
                                    if (liveChatUrl == null || liveChatUrl.isEmpty) {
                                      throw Exception('Live chat URL not found');
                                    }

                                    if (context.mounted) {
                                      print('Navigating to WebView');
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => WebViewScreen(
                                            url: liveChatUrl,
                                            title: 'Live Chat',
                                          ),
                                        ),
                                      );
                                    }
                                  } catch (e) {
                                    print('Error occurred: $e');
                                    // Close loading indicator if it's still showing
                                    if (context.mounted) {
                                      Navigator.pop(context);
                                    }
                                    
                                    // Show error message
                                    if (context.mounted) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Failed to open live chat: ${e.toString()}'),
                                          backgroundColor: SafeJetColors.error,
                                        ),
                                      );
                                    }
                                  }
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: Consumer<BiometricSettingsProvider>(
        builder: (context, provider, child) {
          if (!provider.isAvailable || !provider.isEnabled) {
            return const SizedBox.shrink();
          }

          return FloatingActionButton(
            onPressed: _isLoading ? null : _handleBiometricLogin,
            backgroundColor: _isLoading 
              ? Colors.grey 
              : SafeJetColors.secondaryHighlight,
            child: _isLoading 
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
              : const Icon(Icons.fingerprint),
          );
        },
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    bool isPassword = false,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.bodyLarge,
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: isDark
                ? SafeJetColors.primaryAccent.withOpacity(0.1)
                : SafeJetColors.lightCardBackground,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isDark
                  ? SafeJetColors.primaryAccent.withOpacity(0.2)
                  : SafeJetColors.lightCardBorder,
            ),
          ),
          child: TextFormField(
            controller: controller,
            obscureText: isPassword && !_isPasswordVisible,
            style: theme.textTheme.bodyLarge,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: theme.textTheme.bodyMedium,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(16),
              suffixIcon: isPassword
                  ? IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: isDark ? Colors.white70 : Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    )
                  : null,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _isLoading
            ? null
            : () async {
                _handleLogin();
              },
        style: ElevatedButton.styleFrom(
          backgroundColor: SafeJetColors.secondaryHighlight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
        child: _isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : const Text(
                'Login',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: SafeJetColors.primaryBackground,
                ),
              ),
      ),
    );
  }

  Widget _buildSignUpLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Don\'t have an account? ',
          style: TextStyle(color: Colors.grey[400]),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const RegistrationScreen(),
              ),
            );
          },
          child: Text(
            'Sign Up',
            style: TextStyle(
              color: SafeJetColors.secondaryHighlight,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: 140,
      height: 48,
      decoration: BoxDecoration(
        color: SafeJetColors.primaryAccent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: SafeJetColors.primaryAccent.withOpacity(0.2),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final response = await authProvider.login(
        _emailController.text,
        _passwordController.text,
      );

      if (!mounted) return;

      // Check if 2FA is required
      if (response['requires2FA'] == true) {
        // Navigate to 2FA verification screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TwoFactorAuthScreen(
              email: _emailController.text,
            ),
          ),
        );
      } else {
        // No 2FA required, proceed with normal login flow
        if (response['user']['emailVerified'] == false) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => EmailVerificationScreen(
                email: _emailController.text,
              ),
            ),
          );
        } else {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
            (route) => false,
          );
        }
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: SafeJetColors.error,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
} 