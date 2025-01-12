import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  final VoidCallback onFinish;

  const OnboardingPage({super.key, required this.onFinish});

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();

    return Scaffold(
      body: PageView(
        controller: controller,
        children: [
          _buildPage(
            title: 'Welcome to flutter_template',
            description: 'Manage your databases with ease.',
            image: Icons.storage,
          ),
          _buildPage(
            title: 'Secure',
            description: 'Your data is safe and secure with us.',
            image: Icons.security,
          ),
          _buildPage(
            title: 'Get Started',
            description: 'Let’s dive into your database management journey.',
            image: Icons.check_circle,
            isLast: true,
            onFinish: onFinish,
          ),
        ],
      ),
    );
  }

  Widget _buildPage({
    required String title,
    required String description,
    required IconData image,
    bool isLast = false,
    VoidCallback? onFinish,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(image, size: 100, color: Colors.blue),
        const SizedBox(height: 20),
        Text(
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(
          description,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 40),
        if (isLast)
          ElevatedButton(
            onPressed: onFinish,
            child: const Text('Get Started'),
          ),
      ],
    );
  }
}
