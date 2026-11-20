import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metro_mate/core/theme/setting_cubit.dart';
import 'package:metro_mate/l10n/app_localizations.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/data/repo/auth_repo.dart';
import 'features/auth/view/auth_screen.dart';
import 'features/auth/view_model/auth_cubit.dart';
import 'features/map/view/map_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    BlocProvider(
      create: (context) => SettingsCubit(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, settingsState) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          locale: settingsState.locale,
          supportedLocales: L10n.supportedLocales,
          localizationsDelegates: L10n.localizationsDelegates,
          title: 'Metro Mate',
          theme: AppTheme.lightFor(settingsState.locale),
          darkTheme: AppTheme.darkFor(settingsState.locale),
          themeMode: settingsState.themeMode,
          home: MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => AuthCubit(AuthRepo()))
            ],
            child: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                final user = snapshot.data ?? FirebaseAuth.instance.currentUser;
                return user == null ? const AuthScreen() : const MapScreen();
              },
            ),
          ),
        );
      },
    );
  }
}