import 'package:flutter_template/controllers/auth_controller.dart';
import 'package:flutter_template/generated/gen_l10n/Langs.dart';
import 'package:flutter_template/pages/auth/authRoute_page.dart';
import 'package:flutter_template/pages/auth/onboarding_page.dart';
import 'package:flutter_template/pages/auth/reset_page.dart';
import 'package:flutter_template/pages/dashboard_page.dart';
import 'package:flutter_template/pages/auth/login_page.dart';
import 'package:flutter_template/pages/auth/signup_page.dart';
import 'package:flutter_template/pages/splash_page.dart';
import 'package:flutter_template/utils/colors.dart';
import 'package:flutter_template/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => AuthController()),
      ],
      child: Consumer<AuthController>(
        builder: (context, authProvider, _) {
          if (authProvider.isLoading) {
            authProvider.initializeApp();
            return const LoadingApp();
          }
          if (!authProvider.isOnboardingComplete) {
            return OnboardingApp();
          }
          return authProvider.isAuthenticated
              ? const PrivateApp()
              : const PublicApp();
        },
      ),
    );
  }
}

class LoadingApp extends StatelessWidget {
  const LoadingApp({super.key});

  @override
  Widget build(BuildContext context) {
    final tp = context.watch<ThemeProvider>();
    return Cols(
      c: tp.themeMode == ThemeMode.dark ? AppColorDark() : AppColorLight(),
      child: MaterialApp(
        title: Langs.of(context)?.appName,
        theme: AppThemes.lightTheme,
        darkTheme: AppThemes.darkTheme,
        themeMode: tp.themeMode,
        localizationsDelegates: Langs.localizationsDelegates,
        supportedLocales: Langs.supportedLocales,
        home: SplashPage(),
      ),
    );
  }
}

class OnboardingApp extends StatelessWidget {
  const OnboardingApp({super.key});

  @override
  Widget build(BuildContext context) {
    final tp = context.watch<ThemeProvider>();
    return Cols(
      c: tp.themeMode == ThemeMode.dark ? AppColorDark() : AppColorLight(),
      child: MaterialApp(
        title: Langs.of(context)?.appName,
        theme: AppThemes.lightTheme,
        darkTheme: AppThemes.darkTheme,
        themeMode: tp.themeMode,
        localizationsDelegates: Langs.localizationsDelegates,
        supportedLocales: Langs.supportedLocales,
        home: OnboardingPage(
          onFinish: () {
            Provider.of<AuthController>(context, listen: false)
                .completeOnboarding();
          },
        ),
      ),
    );
  }
}

class PublicApp extends StatelessWidget {
  const PublicApp({super.key});

  @override
  Widget build(BuildContext context) {
    final tp = context.watch<ThemeProvider>();
    return Cols(
      c: tp.themeMode == ThemeMode.dark ? AppColorDark() : AppColorLight(),
      child: MaterialApp(
        title: Langs.of(context)?.appName,
        theme: AppThemes.lightTheme,
        darkTheme: AppThemes.darkTheme,
        themeMode: tp.themeMode,
        localizationsDelegates: Langs.localizationsDelegates,
        supportedLocales: Langs.supportedLocales,
        initialRoute: '/',
        routes: {
          '/': (context) => AuthroutePage(),
          '/login': (context) => LoginPage(),
          '/signup': (context) => SignupPage(),
          '/signup/otp': (context) => SignupPage(),
          '/reset': (context) => ResetPage(),
          '/reset/password': (context) => ResetPage(),
        },
      ),
    );
  }
}

class PrivateApp extends StatelessWidget {
  const PrivateApp({super.key});

  @override
  Widget build(BuildContext context) {
    final tp = context.watch<ThemeProvider>();
    return Cols(
      c: tp.themeMode == ThemeMode.dark ? AppColorDark() : AppColorLight(),
      child: MaterialApp(
        title: Langs.of(context)?.appName,
        theme: AppThemes.lightTheme,
        darkTheme: AppThemes.darkTheme,
        themeMode: tp.themeMode,
        localizationsDelegates: Langs.localizationsDelegates,
        supportedLocales: Langs.supportedLocales,
        initialRoute: '/',
        routes: {
          '/': (context) => DashboardPage(),
        },
      ),
    );
  }
}
