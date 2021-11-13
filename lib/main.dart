import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';
import 'package:gimmenow_assign/pages/landing_page.dart';
import 'package:gimmenow_assign/pages/loading_page.dart';
import 'amplifyconfiguration.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isAmplifyConfigured = false;

  @override
  initState() {
    super.initState();
    _initAmplifyFlutter();
  }

  void _initAmplifyFlutter() async {
    AmplifyAuthCognito auth = AmplifyAuthCognito();

    Amplify.addPlugins([auth]);

    // Initialize AmplifyFlutter
    try {
      await Amplify.configure(amplifyconfig);
    } on AmplifyAlreadyConfiguredException {
      print("Amplify was already configured. Looks like app restarted");
    }

    setState(() {
      _isAmplifyConfigured = true;
    });
  }

  Widget _display() {
    if (_isAmplifyConfigured) {
      return LandingPage();
    } else {
      return LandingPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: '/landing',
        routes: {
          '/landing': (context) => LandingPage(),
          '/loading': (context) => LoadingPage(),
        },
        title: 'Flutter Amplify App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: _display());
  }
}
