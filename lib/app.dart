import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'core/services/storage_service.dart';
import 'core/localization/app_localizations.dart';
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
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(storage)..init(),
        ),
        ChangeNotifierProvider(
          create: (_) => LanguageProvider(storage)..init(),
        ),
      ],
      child: Consumer2<ThemeProvider, LanguageProvider>(
        builder: (context, themeProvider, langProvider, child) {
          return MaterialApp(
            title: 'MUNI-M',
            debugShowCheckedModeBanner: false,
            // ── Themes ────────────────────────────────────────────────────
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: themeProvider.themeMode,
            // ── Localization ──────────────────────────────────────────────
            locale: langProvider.locale,
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
