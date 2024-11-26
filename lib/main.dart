import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safevpn/addPrefernces/add_prefernces.dart';
import 'package:safevpn/screens/home.dart';

late Size sizeScreen;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AddPrefernces.initHive();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Safe VPN',
      theme: ThemeData(
        useMaterial3: true,
        appBarTheme: const AppBarTheme(centerTitle: true, elevation: 3),
      ),
      themeMode: AddPrefernces.isModeDark ? ThemeMode.dark : ThemeMode.light,
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          appBarTheme: const AppBarTheme(centerTitle: true, elevation: 3)),
      debugShowCheckedModeBanner: false,
      home:  HomeScreen(),
    );
  }
}
