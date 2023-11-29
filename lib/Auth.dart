import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/Provider/formProvider.dart';
import 'package:myapp/SuccessScreen.dart';
import 'package:myapp/assets.dart';
import 'package:myapp/utils/gradientText.dart';
import 'package:myapp/widget/CustomField.dart';
import 'package:myapp/widget/dialog.dart';
import 'package:provider/provider.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  late FormProvider _formProvider;

  AuthMode _authMode = AuthMode.Signup;


  @override
  Widget build(BuildContext context) {
    _formProvider = Provider.of<FormProvider>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body:  Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GradientText(
                        "Symmatric",
                        style: GoogleFonts.playfairDisplay(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                        gradient: const LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color.fromARGB(255, 141, 0, 75),
                              Color.fromARGB(255, 199, 0, 106),
                            ]),
                      ),

                     const  SizedBox(
                        height: 11,
                      ),

                      Image.asset(
                        Assets.logo,
                        height: 90,
                        width: 90,
                      ),
                     const  SizedBox(
                        height: 11,
                      ),

                      GradientText(
                        _authMode == AuthMode.Signup ? "Sign Up" : "Sign In",
                        style: GoogleFonts.playfairDisplay(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                        gradient: const LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color.fromARGB(255, 141, 0, 75),
                              Color.fromARGB(255, 199, 0, 106),
                            ]),
                      ),
                     const  SizedBox(
                        height: 18,
                      ),

                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            _authMode == AuthMode.Signup
                                ? CustomFormField(
                                    hintText: 'Name',
                                    prefixicon: Icon(Icons.person_2_outlined,
                                        color: Colors.grey),
                                    onChanged: _formProvider.validateName,
                                    errorText: _formProvider.name.error,
                                  )
                                : Container(),
                            CustomFormField(
                              hintText: 'Email',
                              prefixicon:const  Icon(Icons.email_outlined,
                                  color: Colors.grey),
                              onChanged: _formProvider.validateEmail,
                              errorText: _formProvider.email.error,
                            ),
                            CustomFormField(
                              prefixicon:const  Icon(
                                Icons.lock_outline,
                                color: Colors.grey,
                              ),
                              hintText: 'Password',
                              onChanged: _formProvider.validatePassword,
                              errorText: _formProvider.password.error,
                            ),
                            Consumer<FormProvider>(
                                builder: (context, model, child) {
                              return GestureDetector(
                                onTap: () {
                                  if (_formProvider.validate) {
                                    if (_authMode == AuthMode.Signup) {
                                      model.signUp().then((value) {
                                        if (value == true) {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  SuccessScreen(),
                                            ),
                                          );
                                        } else {
                                          CustomAlertBox(
                                              context, value.toString());
                                        }
                                      });
                                    } else {
                                      model.signIn().then((value) {
                                        if (value == true) {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  SuccessScreen(),
                                            ),
                                          );
                                        } else {
                                        
                                          CustomAlertBox(
                                              context, value.toString());
                                        }
                                      });
                                    }
                                  }
                                },
                                child: Container(
                                  height: 70,
                                  width: double.infinity,
                                  child: Stack(children: [
                                    Align(
                                      child: Container(
                                        alignment: Alignment.bottomCenter,

                                        height: 50,
                                        width:
                                            MediaQuery.of(context).size.width -
                                                40,

                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                                border: Border.all(color: const Color.fromARGB(255, 255, 0, 0), width: 2),
                                            
                                                ),
                                        // margin: EdgeInsets.symmetric(horizontal: 10),
                                        child: const Icon(
                                          Icons.arrow_forward,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      // margin: EdgeInsets.symmetric(vertical: 8),
                                      alignment: Alignment.center,
                                      //  width: double.infinity,
                                      width: MediaQuery.of(context).size.width -
                                          40,

                                      height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          gradient:const  LinearGradient(
                                              begin: Alignment.centerLeft,
                                              end: Alignment.centerRight,
                                              colors: [
                                                  Color(0xffEE5738),
                                                  Color(0xffE61D41),
                                              ])),

                                      child: Text(
                                        _authMode == AuthMode.Signup
                                            ? "Sign Up"
                                            : "Sign In",
                                        style:const  TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ]),
                                ),
                              );

                        
                            })
                          ],
                        ),
                      ),


                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              _authMode == AuthMode.Signup
                                  ? "Aready have an account? "
                                  : "DId you have an account? ",
                              style:const  TextStyle(
                                  // fontSize: 20,
                                  color: Color.fromARGB(255, 126, 126, 126))),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _authMode = _authMode == AuthMode.Signup
                                    ? AuthMode.Login
                                    : AuthMode.Signup;
                              });
                            },
                            child: Text(
                              _authMode == AuthMode.Signup
                                  ? " LogIn"
                                  : " SignUp",
                              style:const  TextStyle(
                                  // fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 255, 0, 0)),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20,  ),

                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 1,
                            width: 100,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.centerRight,
                                  end: Alignment.centerLeft,
                                  colors: [
                                    Colors.red,
                                    Color.fromARGB(0, 255, 255, 255),
                                  ]),
                              // borderRadius: BorderRadius.circular(10)
                            ),
                          ),
                          Text(
                            _authMode == AuthMode.Signup
                                ? "  Or Sign Up with  "
                                : "  Or Sign In with  ",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          Container(
                            height: 1,
                            width: 100,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Colors.red,
                                    Color.fromARGB(0, 255, 255, 255),
                                  ]),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20,  ),

                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: Color.fromARGB(255, 214, 214, 214),
                                width: 2)),
                        height: 40,
                        width: 120,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                Assets.Googlelogo,
                                height: 25,
                                width: 25,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              const Text(
                                "Google",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 0, 0, 0)),
                              )
                            ]),
                      ),
                      SizedBox(height: 30,  ),

                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "By signing up you agree to our",
                            style: TextStyle(
                                // fontSize: 10,
                                color: Color.fromARGB(255, 126, 126, 126)),
                          ),
                          Text(
                            " Terms & Conditions",
                            style: TextStyle(
                                // fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 255, 0, 0)),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
