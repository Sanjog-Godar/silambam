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
  bool
  _obscurePassword =
      true;
  bool
  _isLoading =
      false;

  @override
  void
  dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void
  _handleLogin() async {
    // Validate input
    if (_emailController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        const SnackBar(
          content: Text(
            'Please enter both email and password',
          ),
          backgroundColor: Colors.red,
        ),
      );
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
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        SnackBar(
          content: Text(
            response.message,
          ),
          backgroundColor: Colors.green,
        ),
      );

      // Navigate to AllTournament screen
      if (mounted) {
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
      // Show error message
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        SnackBar(
          content: Text(
            e.message,
          ),
          backgroundColor: Colors.red,
        ),
      );
    } catch (
      e
    ) {
      // Handle unexpected errors
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        SnackBar(
          content: Text(
            'An unexpected error occurred: ${e.toString()}',
          ),
          backgroundColor: Colors.red,
        ),
      );
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

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
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
                        color: Colors.black.withOpacity(
                          0.5,
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
                        const Text(
                          'Jury Login',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: orangeGold,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(
                          height: 32,
                        ),

                        // Email TextField
                        TextField(
                          controller: _emailController,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Email',
                            hintStyle: TextStyle(
                              color: Colors.grey[400],
                            ),
                            prefixIcon: const Icon(
                              Icons.mail,
                              color: tealAccent,
                            ),
                            filled: true,
                            fillColor: Colors.transparent,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                16,
                              ),
                              borderSide: const BorderSide(
                                color: tealAccent,
                                width: 2,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                16,
                              ),
                              borderSide: const BorderSide(
                                color: tealAccent,
                                width: 2,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                16,
                              ),
                              borderSide: const BorderSide(
                                color: tealAccent,
                                width: 2,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 16,
                        ),

                        // Password TextField
                        TextField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: TextStyle(
                              color: Colors.grey[400],
                            ),
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: tealAccent,
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(
                                  () {
                                    _obscurePassword = !_obscurePassword;
                                  },
                                );
                              },
                              child: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: orangeGold,
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.transparent,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                16,
                              ),
                              borderSide: const BorderSide(
                                color: tealAccent,
                                width: 2,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                16,
                              ),
                              borderSide: const BorderSide(
                                color: tealAccent,
                                width: 2,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                16,
                              ),
                              borderSide: const BorderSide(
                                color: tealAccent,
                                width: 2,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 32,
                        ),

                        // Login Button
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              24,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(
                                  0.3,
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
                              padding: const EdgeInsets.symmetric(
                                vertical: 16,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  24,
                                ),
                              ),
                            ),
                            child: _isLoading
                                ? const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
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
                                        width: 10,
                                      ),
                                      Text(
                                        'Logging in...',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  )
                                : const Text(
                                    'Login',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ),
                      ],
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
