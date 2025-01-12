import 'package:flutter_template/controllers/auth_controller.dart';
import 'package:flutter_template/generated/gen_l10n/Langs.dart';
import 'package:flutter_template/widgets/app_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  void _signup() {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text.trim();
      String email = _emailController.text.trim();

      Provider.of<AuthController>(context, listen: false).login('sample_token');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    Langs.of(context)!.signup,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  // Name Field
                  AppInput(
                    controller: _nameController,
                    labelText: Langs.of(context)!.name,
                    prefixIcon: Icon(Icons.person),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return Langs.of(context)!.please_enter_your_name;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  // Email Field
                  AppInput(
                    controller: _emailController,
                    labelText: Langs.of(context)!.email,
                    prefixIcon: Icon(Icons.email),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return Langs.of(context)!.please_enter_your_email;
                      } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                          .hasMatch(value)) {
                        return Langs.of(context)!.enter_a_valid_email;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  AppInput(
                    controller: _passwordController,
                    labelText: Langs.of(context)!.password,
                    prefixIcon: Icon(Icons.lock),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return Langs.of(context)!.please_enter_your_password;
                      } else if (value.length < 6) {
                        return Langs.of(context)!
                            .password_must_be_at_least_character;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  // Confirm Password Field
                  AppInput(
                    controller: _confirmPasswordController,
                    labelText: Langs.of(context)!.confirm_password,
                    prefixIcon: Icon(Icons.lock),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return Langs.of(context)!.please_confirm_your_password;
                      } else if (value != _passwordController.text) {
                        return Langs.of(context)!.passwords_do_not_match;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _signup,
                      child: Text(Langs.of(context)!.signup),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
