import 'package:flutter/material.dart';

import 'app_theme.dart';
import 'dashboard_page.dart';

/// Lab Exercise 6.1 — Page 2 of 4: Login page.
///
/// Member 1 deliverable. Design and visual layout only: no authentication
/// and no validation, as stated in the lab brief. "Sign in" simply moves
/// the user to the dashboard page.
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static const String routeName = '/login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscurePassword = true;
  bool _rememberMe = true;

  // ---- Actions (navigation and visual feedback only) -----------------

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _goTo(String routeName) {
    try {
      Navigator.of(context).pushNamed(routeName);
    } catch (_) {
      _showMessage('Route $routeName is not registered in main.dart yet.');
    }
  }

  /// AlertDialog (Lesson 8, Topic 02). Layout demonstration only.
  Future<void> _showForgotPasswordDialog() async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.radius),
          ),
          title: const Text('Reset password'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Enter the email linked to your Hotel Suites account and '
                    'we will send a reset link.',
                style: TextStyle(fontSize: 13.5, color: AppTheme.mutedInk),
              ),
              SizedBox(height: 16),
              TextField(
                key: Key('loginResetEmail'),
                keyboardType: TextInputType.emailAddress,
                cursorColor: AppTheme.teal,
                decoration: InputDecoration(
                  hintText: 'guest@example.com',
                  prefixIcon: Icon(Icons.mail_outline_rounded),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(120, 44),
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop();
                _showMessage('Reset link sent.');
              },
              child: const Text('Send link'),
            ),
          ],
        );
      },
    );
  }

  // ---- UI ------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: GradientBackdrop(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: screenHeight - 80),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 32),
                  const BrandWordmark(
                    compact: true,
                    tagline: 'Welcome back. Your suite is waiting.',
                  ),
                  const SizedBox(height: 28),
                  _loginCard(),
                  const SizedBox(height: 22),
                  _signupPrompt(),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _loginCard() {
    return Container(
      padding: const EdgeInsets.fromLTRB(22, 26, 22, 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppTheme.cardRadius),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppTheme.ink.withAlpha(45),
            blurRadius: 30,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Sign in',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: AppTheme.ink,
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Use the email you registered with.',
            style: TextStyle(color: AppTheme.mutedInk, fontSize: 13.5),
          ),
          const SizedBox(height: 24),

          const TextField(
            key: Key('loginEmail'),
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

          TextField(
            key: const Key('loginPassword'),
            obscureText: _obscurePassword,
            textInputAction: TextInputAction.done,
            cursorColor: AppTheme.teal,
            decoration: InputDecoration(
              labelText: 'Password',
              hintText: 'Enter your password',
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
          const SizedBox(height: 6),

          // Switch widget (Lesson 8, Topic 01) + AlertDialog trigger
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      height: 32,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Switch(
                          key: const Key('loginRememberMe'),
                          value: _rememberMe,
                          onChanged: (bool value) =>
                              setState(() => _rememberMe = value),
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Flexible(
                      child: Text(
                        'Remember me',
                        overflow: TextOverflow.ellipsis,
                        style:
                        TextStyle(fontSize: 13, color: AppTheme.mutedInk),
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                key: const Key('loginForgotPassword'),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: _showForgotPasswordDialog,
                child: const Text('Forgot password?'),
              ),
            ],
          ),
          const SizedBox(height: 10),

          ElevatedButton(
            key: const Key('loginSubmit'),
            onPressed: () => _goTo(DashboardPage.routeName),
            child: const Text('Sign in'),
          ),
          const SizedBox(height: 18),

          Row(
            children: <Widget>[
              Expanded(child: Divider(color: AppTheme.mutedInk.withAlpha(60))),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  'or',
                  style: TextStyle(color: AppTheme.mutedInk, fontSize: 12),
                ),
              ),
              Expanded(child: Divider(color: AppTheme.mutedInk.withAlpha(60))),
            ],
          ),
          const SizedBox(height: 18),

          OutlinedButton.icon(
            key: const Key('loginBrowseAsGuest'),
            onPressed: () => _goTo('/rooms'),
            icon: const Icon(Icons.search_rounded),
            label: const Text('Browse rooms as guest'),
          ),
        ],
      ),
    );
  }

  Widget _signupPrompt() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(30),
        borderRadius: BorderRadius.circular(AppTheme.radius),
        border: Border.all(color: Colors.white.withAlpha(60)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'New to Hotel?',
            style: TextStyle(color: Colors.white.withAlpha(220), fontSize: 14),
          ),
          TextButton(
            key: const Key('loginGoToSignup'),
            style: TextButton.styleFrom(foregroundColor: AppTheme.gold),
            onPressed: () => _goTo('/signup'),
            child: const Text('Create an account'),
          ),
        ],
      ),
    );
  }
}