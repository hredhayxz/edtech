import 'package:edtech/application/state_holder_binder.dart';
import 'package:edtech/presentation/ui/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EdTech extends StatelessWidget {
  const EdTech({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EdTech',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
          inputDecorationTheme: const InputDecorationTheme(
            contentPadding: EdgeInsets.symmetric(horizontal: 16),
            border:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          )
      ),
      home: const SplashScreen(),
      initialBinding: StateHolderBinder(),
    );
  }
}
