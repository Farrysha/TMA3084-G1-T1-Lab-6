import 'package:flutter/material.dart';

import 'app_theme.dart';

/// Guest type shown with a Material 3 SegmentedButton (Lesson 8, Topic 01).
enum GuestType { leisure, business }

/// Lab Exercise 6.1 — Page 1 of 4: Signup page.
///
/// Member 1 deliverable. Design and visual layout only: there is no
/// authentication, no validation and no data is saved, as stated in the
/// lab brief. The button simply moves the user to the login page.
class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  static const String routeName = '/signup';

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  GuestType _guestType = GuestType.leisure;
  bool _agreedToTerms = false;
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  // ---- Actions (navigation and visual feedback only) -----------------

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  /// Named routes are registered by Member 5 in main.dart. The try/catch
  /// keeps this page runnable on its own before integration day.
  void _goTo(String routeName) {
    try {
      Navigator.of(context).pushNamed(routeName);
    } catch (_) {
      _showMessage('Route $routeName is not registered in main.dart yet.');
    }
  }

  // ---- UI ------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.sand,
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _header(context),
              Transform.translate(
                offset: const Offset(0, -34),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: _formCard(),
                ),
              ),
              const SizedBox(height: 4),
              _footer(),
              const SizedBox(height: 28),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return GradientBackdrop(
      height: 272,
      child: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 34,
          left: 24,
          right: 24,
        ),
        child: const Column(
          children: <Widget>[
            BrandWordmark(tagline: 'Create your account in under a minute.'),
          ],
        ),
      ),
    );
  }

  Widget _formCard() {
    return Container(
      padding: const EdgeInsets.fromLTRB(22, 26, 22, 26),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppTheme.cardRadius),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppTheme.ink.withAlpha(22),
            blurRadius: 26,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Sign up',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: AppTheme.ink,
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Join Hotel Suites to reserve rooms and manage your stays.',
            style: TextStyle(color: AppTheme.mutedInk, fontSize: 13.5),
          ),
          const SizedBox(height: 24),

          // Full name
          const TextField(
            key: Key('signupName'),
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.next,
            cursorColor: AppTheme.teal,
            maxLength: 40,
            decoration: InputDecoration(
              labelText: 'Full name',
              hintText: 'Nur Farrysha binti Ahmad',
              prefixIcon: Icon(Icons.person_outline_rounded),
              counterText: '',
            ),
          ),
          const SizedBox(height: 16),

          // Email
          const TextField(
            key: Key('signupEmail'),
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            autocorrect: false,
            cursorColor: AppTheme.teal,
            decoration: InputDecoration(
              labelText: 'Email address',
              hintText: 'guest@example.com',
              prefixIcon: Icon(Icons.mail_outline_rounded),
            ),
          ),
          const SizedBox(height: 16),

          // Phone — number keyboard only (keyboardType property)
          const TextField(
            key: Key('signupPhone'),
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            maxLength: 15,
            cursorColor: AppTheme.teal,
            decoration: InputDecoration(
              labelText: 'Phone number',
              hintText: '0123456789',
              prefixIcon: Icon(Icons.phone_outlined),
              counterText: '',
            ),
          ),
          const SizedBox(height: 16),

          // Password — obscureText with a show/hide toggle
          TextField(
            key: const Key('signupPassword'),
            obscureText: _obscurePassword,
            textInputAction: TextInputAction.next,
            cursorColor: AppTheme.teal,
            decoration: InputDecoration(
              labelText: 'Password',
              hintText: 'At least 8 characters',
              prefixIcon: const Icon(Icons.lock_outline_rounded),
              suffixIcon: IconButton(
                tooltip: _obscurePassword ? 'Show password' : 'Hide password',
                icon: Icon(
                  _obscurePassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: AppTheme.mutedInk,
                ),
                onPressed: () =>
                    setState(() => _obscurePassword = !_obscurePassword),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Confirm password
          TextField(
            key: const Key('signupConfirmPassword'),
            obscureText: _obscureConfirm,
            textInputAction: TextInputAction.done,
            cursorColor: AppTheme.teal,
            decoration: InputDecoration(
              labelText: 'Confirm password',
              hintText: 'Re-enter your password',
              prefixIcon: const Icon(Icons.lock_reset_rounded),
              suffixIcon: IconButton(
                tooltip: _obscureConfirm ? 'Show password' : 'Hide password',
                icon: Icon(
                  _obscureConfirm
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: AppTheme.mutedInk,
                ),
                onPressed: () =>
                    setState(() => _obscureConfirm = !_obscureConfirm),
              ),
            ),
          ),
          const SizedBox(height: 22),

          // SegmentedButton (Material 3) — travel purpose
          const Text(
            'I usually travel for',
            style: TextStyle(
              color: AppTheme.ink,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: SegmentedButton<GuestType>(
              key: const Key('signupGuestType'),
              showSelectedIcon: false,
              segments: const <ButtonSegment<GuestType>>[
                ButtonSegment<GuestType>(
                  value: GuestType.leisure,
                  label: Text('Leisure'),
                  icon: Icon(Icons.beach_access_outlined),
                ),
                ButtonSegment<GuestType>(
                  value: GuestType.business,
                  label: Text('Business'),
                  icon: Icon(Icons.business_center_outlined),
                ),
              ],
              selected: <GuestType>{_guestType},
              onSelectionChanged: (Set<GuestType> selection) {
                setState(() => _guestType = selection.first);
              },
            ),
          ),
          const SizedBox(height: 10),

          // Checkbox — terms
          CheckboxListTile(
            key: const Key('signupTerms'),
            value: _agreedToTerms,
            onChanged: (bool? value) =>
                setState(() => _agreedToTerms = value ?? false),
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: EdgeInsets.zero,
            dense: true,
            activeColor: AppTheme.teal,
            checkColor: Colors.white,
            title: const Text(
              'I agree to the booking terms and privacy policy',
              style: TextStyle(fontSize: 13, color: AppTheme.mutedInk),
            ),
          ),
          const SizedBox(height: 14),

          ElevatedButton(
            key: const Key('signupSubmit'),
            onPressed: () => _goTo('/login'),
            child: const Text('Create account'),
          ),
        ],
      ),
    );
  }

  Widget _footer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          'Already a guest?',
          style: TextStyle(color: AppTheme.mutedInk, fontSize: 14),
        ),
        TextButton(
          key: const Key('signupGoToLogin'),
          onPressed: () => _goTo('/login'),
          child: const Text('Sign in'),
        ),
      ],
    );
  }
}