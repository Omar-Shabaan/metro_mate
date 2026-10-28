import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/theme/app_theme.dart';
import 'feature/auth/data/repo/auth_repo.dart';
import 'feature/auth/view/auth_screen.dart';
import 'feature/auth/view_model/auth_cubit.dart';
import 'feature/map/view/map_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const locale = Locale('ar');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: const Locale('ar'),
      supportedLocales: const [Locale('ar'), Locale('en')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      title: 'Soccer_Booking',
      theme: AppTheme.lightFor(locale),
      darkTheme: AppTheme.darkFor(locale),
      themeMode: ThemeMode.system,
      home: MultiBlocProvider(
        providers: [BlocProvider(create: (context) => AuthCubit(AuthRepo()))],
        child: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            final user = snapshot.data ?? FirebaseAuth.instance.currentUser;
            return user == null ? const AuthScreen() : const MapScreen();
          },
        ),
      ),
    );
  }
}
