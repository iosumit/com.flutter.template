import 'package:flutter_template/generated/gen_l10n/Langs.dart';
import 'package:flutter_template/utils/colors.dart';
import 'package:flutter_template/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          Langs.of(context)!.splash_title,
          style: TextStyle(fontSize: 40, color: Cols.of(context).c.textdark),
        ),
      ),
    );
  }
}
