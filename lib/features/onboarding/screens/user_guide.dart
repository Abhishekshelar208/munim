import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../../../core/theme/app_colors.dart';
import 'onboarding_screen.dart';

class UserGuideScreen extends StatefulWidget {
  const UserGuideScreen({super.key});

  @override
  State<UserGuideScreen> createState() => _UserGuideScreenState();
}

class _UserGuideScreenState extends State<UserGuideScreen> {
  final PageController _pageCtrl = PageController();
  int _currentIndex = 0;

  final List<Map<String, String>> _pages = [
    {
      'title': 'Meet Your AI Advisor',
      'subtitle': 'Your 24/7 financial genius. Get instant, personalized advice on saving, spending, and investing with deep Indian financial context.',
      'icon': '🧠',
    },
    {
      'title': 'Predict Your Future',
      'subtitle': 'Stop guessing. MUNI-M analyzes your real spending habits to predict exact future compound wealth and opportunity costs down to the rupee.',
      'icon': '🔮',
    },
    {
      'title': 'Discipline Strategy',
      'subtitle': 'Automated wealth rules and dynamic goal tracking. We calculate exactly how much you can afford to spend without sacrificing your dreams.',
      'icon': '🎯',
    },
    {
      'title': 'Self-Growth Only',
      'subtitle': 'No toxic social leaderboards. Pure, hard mathematics tracking your discipline against the only person who matters: your past self.',
      'icon': '📈',
    },
  ];

  @override
  void dispose() {
    _pageCtrl.dispose();
    super.dispose();
  }

  void _next() {
    if (_currentIndex < _pages.length - 1) {
      _pageCtrl.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      _finish();
    }
  }

  void _finish() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const OnboardingScreen(),
        transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? AppColors.bgDeep : AppColors.bgDeepLight,
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: _finish,
                child: const Text('Skip', style: TextStyle(color: AppColors.textMuted, fontSize: 16)),
              ),
            ),
            
            Expanded(
              child: PageView.builder(
                controller: _pageCtrl,
                onPageChanged: (i) => setState(() => _currentIndex = i),
                itemCount: _pages.length,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FadeInUp(
                          duration: const Duration(milliseconds: 400),
                          child: Container(
                            width: 140,
                            height: 140,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: RadialGradient(
                                colors: [
                                  AppColors.primaryGreen.withOpacity(0.2),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                            child: Center(
                              child: Text(
                                _pages[i]['icon']!,
                                style: const TextStyle(fontSize: 80),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 48),
                        FadeInUp(
                          delay: const Duration(milliseconds: 100),
                          duration: const Duration(milliseconds: 400),
                          child: Text(
                            _pages[i]['title']!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                              height: 1.2,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        FadeInUp(
                          delay: const Duration(milliseconds: 200),
                          duration: const Duration(milliseconds: 400),
                          child: Text(
                            _pages[i]['subtitle']!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 16,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            
            // Bottom Controls
            Padding(
              padding: const EdgeInsets.all(32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Progress Dots
                  Row(
                    children: List.generate(
                      _pages.length,
                      (i) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.only(right: 8),
                        height: 8,
                        width: _currentIndex == i ? 24 : 8,
                        decoration: BoxDecoration(
                          color: _currentIndex == i ? AppColors.primaryGreen : AppColors.textMuted.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  
                  // Next / Get Started Button
                  GestureDetector(
                    onTap: _next,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primaryGreen.withOpacity(0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _currentIndex == _pages.length - 1 ? 'Configure Profile' : 'Next',
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            _currentIndex == _pages.length - 1 ? Icons.rocket_launch_rounded : Icons.arrow_forward_rounded,
                            color: Colors.black,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
