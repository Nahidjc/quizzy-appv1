import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzy/pages/home_page.dart';
import 'package:quizzy/pages/signup_page.dart';
import 'package:quizzy/provider/login_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => const HomePage()),
      // );
      String email = _emailController.text;
      String password = _passwordController.text;
      Provider.of<AuthProvider>(context, listen: false)
          .loginProvider(email, password);
      _emailController.clear();
      _passwordController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = Provider.of<AuthProvider>(context);
    if (authState.isAuthenticated) {
      return const HomePage();
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppBar(),
                const SizedBox(height: 40.0),
                Image.asset(
                  'assets/images/logo.png',
                  width: 100,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'Log In to your account',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(8), // Apply corner radius
                    ),
                    prefixIcon: const Icon(Icons.email_outlined, size: 24),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!value.contains('@')) {
                      return 'Invalid email format';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: _passwordController,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      prefixIcon: const Icon(Icons.lock, size: 24)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                SizedBox(
                  width: double.infinity,
                  height: 50.0,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.purple),
                    ),
                    onPressed: _submitForm,
                    child: const Text("Login",
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(height: 20.0),
                GestureDetector(
                  child: const Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Text(
                      'Forget password?',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignupPage()),
                    );
                  },
                  child: const Text(
                    "Don't have an account? Register here",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
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
