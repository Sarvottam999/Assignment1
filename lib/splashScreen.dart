import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Auth.dart';
import 'package:myapp/Provider/formProvider.dart';
import 'package:myapp/SuccessScreen.dart';
import 'package:myapp/assets.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {

       WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    final provider = Provider.of<FormProvider>(context, listen: false);
    provider.isUserLoggedIn() == true
        ? Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SuccessScreen()
            )
        )
        : Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => AuthScreen()
            )
        );
    });

  

 
    
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Center(
     child :  Image.asset(Assets.logo),
    );
  }
}