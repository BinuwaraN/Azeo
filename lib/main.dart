import 'package:azeo/providers/theme_provider.dart';
import 'package:azeo/providers/user_provider.dart';
import 'package:azeo/screens/home_screen.dart';
import 'package:azeo/screens/welcome_screen.dart';
import 'package:azeo/services/auth_methods.dart';
import 'package:azeo/theme/app_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider(AppTheme.lightTheme),
        ),
      ],
      child: MaterialAppWithTheme(),
    );
  }
}

class MaterialAppWithTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthMethods _authMethods = AuthMethods();
    final theme = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Azeo',
      theme: theme.getTheme(),
      darkTheme: AppTheme.darkTheme,
      initialRoute: "/",
      home: FutureBuilder(
        future: _authMethods.getCurrentUser(),
        builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
          if (snapshot.hasData) {
            return HomeScreen();
          } else {
            return WelcomeScreen();
          }
        },
      ),
    );
  }
}
