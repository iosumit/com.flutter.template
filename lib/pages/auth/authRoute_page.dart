import 'package:flutter_template/generated/gen_l10n/Langs.dart';
import 'package:flutter/material.dart';

class AuthroutePage extends StatelessWidget {
  const AuthroutePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                Langs.of(context)!.appName,
                style: TextStyle(fontSize: 40),
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: Text(Langs.of(context)!.login),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
                child: Text(Langs.of(context)!.signup),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
