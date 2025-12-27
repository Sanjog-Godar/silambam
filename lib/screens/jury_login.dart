import 'package:flutter/material.dart';
import 'all_tournament.dart';
import '../services/auth_api_service.dart';
import '../models/api_error.dart';

class JuryLogin
    extends
        StatefulWidget {
  const JuryLogin({
    super.key,
  });

  @override
  State<
    JuryLogin
  >
  createState() =>
      _JuryLoginState();
}

class _JuryLoginState
    extends
        State<
          JuryLogin
        > {
  final TextEditingController
  _emailController =
      TextEditingController();
  final TextEditingController
  _passwordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool
  _obscurePassword =
      true;
  bool
  _isLoading =
      false;
  String? _emailError;
  String? _passwordError;

  @override
  void
  dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  void _validateFields() {
    setState(() {
      _emailError = null;
      _passwordError = null;
    });

    if (_emailController.text.isEmpty) {
      setState(() {
        _emailError = 'Email is required';
      });
    } else if (!_isValidEmail(_emailController.text.trim())) {
      setState(() {
        _emailError = 'Enter a valid email address';
      });
    }

    if (_passwordController.text.isEmpty) {
      setState(() {
        _passwordError = 'Password is required';
      });
    } else if (_passwordController.text.length < 6) {
      setState(() {
        _passwordError = 'Password must be at least 6 characters';
      });
    }
  }

  void
  _handleLogin() async {
    // Validate input
    if (_emailController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      _validateFields();
      return;
    }

    if (!_isValidEmail(_emailController.text.trim())) {
      setState(() {
        _emailError = 'Enter a valid email address';
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Call API
      final response = await AuthApiService.judgeLogin(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      // Login successful
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(
          SnackBar(
            content: Text(
              response.message,
            ),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),
          ),
        );

        // Navigate to AllTournament screen
        Navigator.of(
          context,
        ).pushReplacement(
          MaterialPageRoute(
            builder:
                (
                  context,
                ) => const AllTournament(),
          ),
        );
      }
    } on ApiError catch (
      e
    ) {
      if (mounted) {
        // Show error message
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(
          SnackBar(
            content: Text(
              e.message,
            ),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } catch (
      e
    ) {
      if (mounted) {
        // Handle unexpected errors
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(
          SnackBar(
            content: Text(
              'An unexpected error occurred: ${e.toString()}',
            ),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } finally {
      setState(
        () {
          _isLoading = false;
        },
      );
    }
  }

  @override
  Widget
  build(
    BuildContext
    context,
  ) {
    // Color Palette
    const Color
    darkNavy = Color(
      0xFF0B2340,
    );
    const Color
    cardNavy = Color(
      0xFF1A3A52,
    );
    const Color
    tealAccent = Color(
      0xFF27B7B0,
    );
    const Color
    orangeGold = Color(
      0xFFE3A23A,
    );
    const Color
    errorRed = Color(
      0xFFE74C3C,
    );

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              darkNavy,
              orangeGold,
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Main Card
                Container(
                  width:
                      MediaQuery.of(
                        context,
                      ).size.width *
                      0.85,
                  decoration: BoxDecoration(
                    color: cardNavy,
                    borderRadius: BorderRadius.circular(
                      24,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(
                          alpha: 0.5,
                        ),
                        blurRadius: 15,
                        offset: const Offset(
                          0,
                          8,
                        ),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32.0,
                      vertical: 40.0,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Logo/Image
                          Image.asset(
                            'assets/logo.png',
                            height: 100,
                            fit: BoxFit.contain,
                          ),

                          const SizedBox(
                            height: 16,
                          ),

                          // Title
                          Text(
                            'Judge Panel',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: orangeGold,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0,
                            ),
                          ),

                          const SizedBox(
                            height: 8,
                          ),

                          // Subtitle
                          Text(
                            'Professional Scoring System',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey[300],
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),

                          const SizedBox(
                            height: 32,
                          ),

                          // Email TextField
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Email Address',
                                style: TextStyle(
                                  color: Colors.grey[300],
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              const SizedBox(height: 8),
                              TextField(
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _emailError = null;
                                  });
                                },
                                decoration: InputDecoration(
                                  hintText: 'judge@example.com',
                                  hintStyle: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: 14,
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.mail_outline,
                                    color: tealAccent,
                                    size: 20,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white.withValues(
                                    alpha: 0.08,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                      12,
                                    ),
                                    borderSide: const BorderSide(
                                      color: tealAccent,
                                      width: 1.5,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                      12,
                                    ),
                                    borderSide: BorderSide(
                                      color: _emailError != null
                                          ? errorRed
                                          : tealAccent,
                                      width: 1.5,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                      12,
                                    ),
                                    borderSide: const BorderSide(
                                      color: orangeGold,
                                      width: 2,
                                    ),
                                  ),
                                  contentPadding:
                                      const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 14,
                                  ),
                                ),
                              ),
                              if (_emailError != null)
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 6,
                                  ),
                                  child: Text(
                                    _emailError!,
                                    style: const TextStyle(
                                      color: errorRed,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                            ],
                          ),

                          const SizedBox(
                            height: 20,
                          ),

                          // Password TextField
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Password',
                                style: TextStyle(
                                  color: Colors.grey[300],
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              const SizedBox(height: 8),
                              TextField(
                                controller: _passwordController,
                                obscureText: _obscurePassword,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _passwordError = null;
                                  });
                                },
                                decoration: InputDecoration(
                                  hintText: 'Enter your password',
                                  hintStyle: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: 14,
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.lock_outline,
                                    color: tealAccent,
                                    size: 20,
                                  ),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(
                                        () {
                                          _obscurePassword =
                                              !_obscurePassword;
                                        },
                                      );
                                    },
                                    child: Icon(
                                      _obscurePassword
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined,
                                      color: orangeGold,
                                      size: 20,
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white.withValues(
                                    alpha: 0.08,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                      12,
                                    ),
                                    borderSide: const BorderSide(
                                      color: tealAccent,
                                      width: 1.5,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                      12,
                                    ),
                                    borderSide: BorderSide(
                                      color: _passwordError != null
                                          ? errorRed
                                          : tealAccent,
                                      width: 1.5,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                      12,
                                    ),
                                    borderSide: const BorderSide(
                                      color: orangeGold,
                                      width: 2,
                                    ),
                                  ),
                                  contentPadding:
                                      const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 14,
                                  ),
                                ),
                              ),
                              if (_passwordError != null)
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 6,
                                  ),
                                  child: Text(
                                    _passwordError!,
                                    style: const TextStyle(
                                      color: errorRed,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                            ],
                          ),

                          const SizedBox(
                            height: 32,
                          ),

                          // Login Button
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                12,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(
                                    alpha: 0.3,
                                  ),
                                  blurRadius: 10,
                                  offset: const Offset(
                                    0,
                                    4,
                                  ),
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              onPressed: _isLoading
                                  ? null
                                  : _handleLogin,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: orangeGold,
                                disabledBackgroundColor:
                                    Colors.grey[600],
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    12,
                                  ),
                                ),
                                elevation: 0,
                              ),
                              child: _isLoading
                                  ? const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 20,
                                          height: 20,
                                          child:
                                              CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<
                                                  Color
                                                >(
                                                  Colors.white,
                                                ),
                                            strokeWidth: 2,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 12,
                                        ),
                                        Text(
                                          'Signing in...',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                      ],
                                    )
                                  : const Text(
                                      'Sign In',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                            ),
                          ),

                          const SizedBox(
                            height: 20,
                          ),

                          // Footer Info
                          Divider(
                            color: Colors.white.withValues(
                              alpha: 0.1,
                            ),
                          ),

                          const SizedBox(
                            height: 16,
                          ),

                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'v1.0.0',
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 11,
                                ),
                              ),
                              Text(
                                'Silambam Judge Panel',
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
