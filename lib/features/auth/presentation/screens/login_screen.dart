import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../core/l10n/app_localizations.dart';
import '../../../face_recognition/presentation/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  static const _adminUser = 'admin';
  static const _adminPass = 'admin';

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  bool _obscurePassword = true;
  bool _isSubmitting = false;
  String? _authError;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateEmail(AppLocalizations l10n, String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) {
      return l10n.validationEmailRequired;
    }
    if (trimmed == _adminUser) {
      return null;
    }
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailRegex.hasMatch(trimmed)) {
      return l10n.validationEmailInvalid;
    }
    return null;
  }

  String? _validatePassword(AppLocalizations l10n, String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) {
      return l10n.validationPasswordRequired;
    }
    if (trimmed == _adminPass) {
      return null;
    }
    if (trimmed.length < 6) {
      return l10n.validationPasswordLength;
    }
    return null;
  }

  bool _isAdminCredential() {
    return _emailController.text.trim() == _adminUser &&
        _passwordController.text.trim() == _adminPass;
  }

  Future<void> _submit() async {
    final currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }

    setState(() {
      _authError = null;
    });

    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    await Future<void>.delayed(const Duration(milliseconds: 700));

    if (!mounted) return;

    if (!_isAdminCredential()) {
      setState(() {
        _isSubmitting = false;
        _authError = AppLocalizations.of(context).invalidCredentials;
      });
      return;
    }

    setState(() {
      _isSubmitting = false;
    });

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFF7F7FF),
              Color(0xFFE3ECFF),
              Color(0xFFDDE8FF),
            ],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: -80,
              right: -60,
              child: _GlowBlob(size: size.width * 0.55),
            ),
            Positioned(
              bottom: -90,
              left: -40,
              child: _GlowBlob(size: size.width * 0.5, tint: 0xFFBFD0FF),
            ),
            SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 520),
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.loginTitle,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF1B1F3B),
                                  ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              l10n.loginSubtitle,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(color: const Color(0xFF4D5877)),
                            ),
                            const SizedBox(height: 28),
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        l10n.accountTitle,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(fontWeight: FontWeight.w600),
                                      ),
                                      const SizedBox(height: 16),
                                      TextFormField(
                                        controller: _emailController,
                                        keyboardType: TextInputType.emailAddress,
                                        validator: (value) => _validateEmail(l10n, value),
                                        decoration: InputDecoration(
                                          labelText: l10n.emailLabel,
                                          prefixIcon: const Icon(Icons.mail_outline),
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      TextFormField(
                                        controller: _passwordController,
                                        obscureText: _obscurePassword,
                                        validator: (value) => _validatePassword(l10n, value),
                                        decoration: InputDecoration(
                                          labelText: l10n.passwordLabel,
                                          prefixIcon: const Icon(Icons.lock_outline),
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                _obscurePassword = !_obscurePassword;
                                              });
                                            },
                                            icon: Icon(
                                              _obscurePassword
                                                  ? Icons.visibility_off_outlined
                                                  : Icons.visibility_outlined,
                                            ),
                                          ),
                                        ),
                                      ),
                                      if (_authError != null) ...[
                                        const SizedBox(height: 12),
                                        Text(
                                          _authError!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(color: const Color(0xFFE5484D)),
                                        ),
                                      ],
                                      const SizedBox(height: 12),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: TextButton(
                                          onPressed: () {},
                                          child: Text(l10n.forgotPassword),
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      SizedBox(
                                        width: double.infinity,
                                        child: FilledButton(
                                          onPressed: _isSubmitting ? null : _submit,
                                          child: AnimatedSwitcher(
                                            duration: const Duration(milliseconds: 250),
                                            child: _isSubmitting
                                                ? const SizedBox(
                                                    key: ValueKey('loading'),
                                                    height: 20,
                                                    width: 20,
                                                    child: CircularProgressIndicator(
                                                      strokeWidth: 2.4,
                                                      color: Colors.white,
                                                    ),
                                                  )
                                                : Text(l10n.signIn),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                const Icon(Icons.shield_outlined,
                                    color: Color(0xFF2B59FF)),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    l10n.trustNote,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(color: const Color(0xFF5B6788)),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GlowBlob extends StatelessWidget {
  const _GlowBlob({required this.size, this.tint = 0xFFCAD6FF});

  final double size;
  final int tint;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            Color(tint).withOpacity(0.65),
            const Color(0x00FFFFFF),
          ],
        ),
      ),
    );
  }
}
