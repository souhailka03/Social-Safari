import 'package:flutter/material.dart';
import '../data/test_users.dart';
import '../data/user_state.dart';
import '../widgets/payment_success_dialog.dart';
import '../pages/reservation_page.dart';

class LoginScreen extends StatefulWidget {
  final Map<String, String>? offerDetails;

  const LoginScreen({
    Key? key,
    this.offerDetails,
  }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 327),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                const Text(
                  'Login',
                  style: TextStyle(
                    color: Color(0xFF6D56FF),
                    fontSize: 28,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  'Connectez-vous pour accéder à votre profil et sauvegarder vos recommandations.',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 13,
                    height: 1.8,
                  ),
                ),
                const SizedBox(height: 40),

                // Form
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Email field
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[50],
                          hintText: 'Adresse e-mail',
                          hintStyle: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 13,
                          ),
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: Colors.grey[400],
                            size: 18,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Colors.grey[300]!,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer votre adresse e-mail';
                          }
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                            return 'Veuillez entrer une adresse e-mail valide';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Password field
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[50],
                          hintText: 'Mot de passe',
                          hintStyle: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 13,
                          ),
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: Colors.grey[400],
                            size: 18,
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            child: Icon(
                              _obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                              color: Colors.grey[400],
                              size: 18,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Colors.grey[300]!,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer votre mot de passe';
                          }
                          if (value.length < 6) {
                            return 'Le mot de passe doit contenir au moins 6 caractères';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Login button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              final bool isValid = TestUsers.validateUser(
                                _emailController.text,
                                _passwordController.text,
                              );

                              if (isValid) {
                                // Mettre à jour l'état de l'utilisateur
                                UserState.setCurrentUser(
                                  _emailController.text,
                                  _passwordController.text,
                                );

                                if (widget.offerDetails != null) {
                                  // Naviguer vers la page de réservation
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ReservationPage(
                                        offerDetails: widget.offerDetails!,
                                      ),
                                    ),
                                  );
                                } else {
                                  // Simple connexion sans réservation
                                  Navigator.of(context).pop();
                                  // Afficher un message de succès
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Connexion réussie !'),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                }
                              } else {
                                // Afficher un message d'erreur
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Email ou mot de passe incorrect'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF6D56FF),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Se connecter',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Divider
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Colors.grey[200],
                        thickness: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'ou',
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 13,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.grey[200],
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Google button
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    side: BorderSide(color: Colors.grey[300]!),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        'https://cdn.builder.io/api/v1/image/assets/TEMP/f65c35a70fd7dff810f350931c9105ba5326c737',
                        height: 20,
                        width: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Continuer avec Google',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Links
                Center(
                  child: Column(
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Mot de passe oublié ?',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 13,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Pas encore de compte ? Inscrivez-vous',
                          style: TextStyle(
                            color: Color(0xFF6D56FF),
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),

                // Terms
                Center(
                  child: Column(
                    children: [
                      Text(
                        'En vous connectant, vous acceptez nos',
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 11,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              minimumSize: Size.zero,
                              padding: EdgeInsets.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: const Text(
                              'conditions d\'utilisation',
                              style: TextStyle(
                                color: Color(0xFF6D56FF),
                                fontSize: 11,
                              ),
                            ),
                          ),
                          Text(
                            ' et notre ',
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 11,
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              minimumSize: Size.zero,
                              padding: EdgeInsets.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: const Text(
                              'politique de confidentialité',
                              style: TextStyle(
                                color: Color(0xFF6D56FF),
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
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