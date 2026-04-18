import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../providers.dart';
import 'onboarding_screen.dart';
import '../../main_shell.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _fadeIn = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0, 0.6, curve: Curves.easeOut)),
    );
    _scale = Tween<double>(begin: 0.85, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0, 0.6, curve: Curves.easeOut)),
    );

    _controller.forward();

    Future.delayed(const Duration(milliseconds: 2400), _navigate);
  }

  Future<void> _navigate() async {
    if (!mounted) return;
    final userProvider = context.read<UserProvider>();
    await userProvider.init();

    if (!mounted) return;
    final isOnboarded = userProvider.isOnboarded;

    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) =>
            isOnboarded ? const MainShell() : const OnboardingScreen(),
        transitionsBuilder: (_, anim, __, child) =>
            FadeTransition(opacity: anim, child: child),
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppColors.bgDeep : AppColors.bgDeepLight,
      body: Center(
        child: FadeTransition(
          opacity: _fadeIn,
          child: ScaleTransition(
            scale: _scale,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Logo mark
                Container(
                  width: 84,
                  height: 84,
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryGreen.withOpacity(0.4),
                        blurRadius: 30,
                        spreadRadius: 4,
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      'M',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ShaderMask(
                  shaderCallback: (bounds) =>
                      AppColors.primaryGradient.createShader(bounds),
                  child: const Text(
                    'MUNI-M (1.6)',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'The Intelligence Behind Your Money',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 60),
                SizedBox(
                  width: 32,
                  height: 2,
                  child: LinearProgressIndicator(
                    backgroundColor: AppColors.bgCardAlt,
                    valueColor: const AlwaysStoppedAnimation(AppColors.primaryGreen),
                    borderRadius: BorderRadius.circular(2),
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
