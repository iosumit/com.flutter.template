import 'package:flutter_template/controllers/auth_controller.dart';
import 'package:flutter_template/generated/gen_l10n/Langs.dart';
import 'package:flutter_template/widgets/app_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResetPage extends StatefulWidget {
  const ResetPage({super.key});

  @override
  State<ResetPage> createState() => _ResetPageState();
}

class _ResetPageState extends State<ResetPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  void _login() {
    if (_formKey.currentState!.validate()) {
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
                    Langs.of(context)!.reset_account_password,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
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
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _login,
                      child: Text(Langs.of(context)!.reset),
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
