import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'core/services/storage_service.dart';
import 'providers.dart';
import 'features/onboarding/screens/splash_screen.dart';

class MuniApp extends StatelessWidget {
  const MuniApp({super.key});

  @override
  Widget build(BuildContext context) {
    final storage = StorageService();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(storage)..init(),
        ),
        ChangeNotifierProvider(
          create: (_) => TransactionProvider(storage)..init(),
        ),
        ChangeNotifierProvider(
          create: (_) => GoalProvider(storage)..init(),
        ),
        ChangeNotifierProvider(
          create: (_) => AdvisorProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'MUNI-M',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.dark,
        home: const SplashScreen(),
      ),
    );
  }
}
