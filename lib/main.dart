import 'package:equipment_picker/constants/colors.dart';
import 'presentation/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const EquipmentPickerApp());
}

class EquipmentPickerApp extends StatelessWidget {
  const EquipmentPickerApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Equipment Picker App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: bgColor),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

