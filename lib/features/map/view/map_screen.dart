import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metro_mate/core/localization/l10n_extension.dart';
import 'package:metro_mate/core/theme/setting_cubit.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("map............................."),
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () {
              context.read<SettingsCubit>().toggleLanguage();
            },
          ),
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () {
              context.read<SettingsCubit>().toggleTheme();
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text("tttttt")),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => FirebaseAuth.instance.signOut(),
            child: Text(context.l10n.logout),
          ),
        ],
      ),
    );
  }
}