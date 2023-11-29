import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/Provider/formProvider.dart';
import 'package:provider/provider.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Success'),
      ),

      floatingActionButton:  FloatingActionButton(
        onPressed: () {
          final provider = Provider.of<FormProvider>(context, listen: false).signOut();
          // Navigator.pop(context);
            SystemNavigator.pop();


        },
        child: Text("log out"),
      ),
      body:const Center(
        child: Text(
          'Success!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}