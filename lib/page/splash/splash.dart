
import 'package:config/page/login/login.dart';
import 'package:config/page/myHomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:config/provider/auth_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    onChecking();
    super.initState();
  }

  onChecking() async {
    await Future.delayed(const Duration(seconds: 1));
    FirebaseAuth.instance.authStateChanges().listen((user) async {
      if (user != null) {
        await Provider.of(context,listen: false).getUser(user.uid);
        //MyPageRoute.goToReplace(context, RootPage(user.uid));
      } else {
        //MyPageRoute.goToReplace(context, const LoginPage());
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage() ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CupertinoActivityIndicator(),
      ),
    );
  }
}
