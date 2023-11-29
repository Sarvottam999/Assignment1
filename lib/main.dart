import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Auth.dart';
import 'package:myapp/Provider/formProvider.dart';
import 'package:myapp/SuccessScreen.dart';
import 'package:myapp/splashScreen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(ChangeNotifierProvider(
   create: (_) => FormProvider(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final formProvider = Provider.of<FormProvider>(context, listen: false);
    return MaterialApp(
      title: 'Starter Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        

      ),
      home: SplashScreen()
     );

  }
}

 
