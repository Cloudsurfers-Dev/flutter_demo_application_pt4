import 'package:demo_application/pages/login.dart';
import 'package:demo_application/providers/api_provider.dart';
import 'package:demo_application/providers/auth_provider.dart';
import 'package:demo_application/providers/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';
import 'package:get_it/get_it.dart';

void main() {
  GetIt.I.registerSingleton<AuthProvider>(AuthProvider());
  GetIt.I.registerSingleton<ApiProvider>(ApiProvider());

  GetIt.I.registerSingleton<DatabaseHelper>(DatabaseHelper());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.green,
        brightness: Brightness.dark,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.resolveWith<Color>((_) {
              return Colors.black54;
            }),
            shape: MaterialStateProperty.resolveWith<OutlinedBorder>((_) {
              return RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32));
            }),
          ),
        ),
      ),
      themeMode: ThemeMode.system,
      home: const LoginPage(),
    );
  }
}
