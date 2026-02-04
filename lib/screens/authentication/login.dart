import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:kdc_chitty_mainnew/screens/authentication/forgotPasswordPhoneNumber.dart';
import 'package:lottie/lottie.dart';
import '../../core/common.dart';
import '../../models/loginModel.dart';
import '../../screens/leadManagement/dashboard.dart';
import '../../service/service.dart';
import '../../widgets/colors.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import '../../widgets/size_config.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  String? firebaseToken;
  bool _loading = false;
  bool obSecure=true;

  handleAsync() async {
    firebaseToken = await FirebaseMessaging.instance.getToken();
    if (kDebugMode) {
      print("Firebase token : $firebaseToken");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    handleAsync();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                // Colors.purple,
                Colors.white,
                Colors.white,
              ])),
          child: Column(
            children: [
              Container(
                  margin: const EdgeInsets.only(top: 100),
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Center(
                    child: Lottie.asset(
                      'assets/main/splash.json',
                      fit: BoxFit.fill,
                    ),
                  )),
              Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50))),
                  margin: const EdgeInsets.only(top: 60),
                  child: Column(
                    children: [
                      const Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                          )
                      ),
                      const SizedBox(height: 5,),
                      const Text(
                          "Enter your login details",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          )
                      ),
                      const SizedBox(height: 50,),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: TextFormField(
                          controller: username,
                          decoration: const InputDecoration(
                            hintText: 'Enter Username',
                            contentPadding: EdgeInsets.all(10),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25,),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: TextFormField(
                          obscureText: obSecure,
                          controller: password,
                          decoration: InputDecoration(
                            hintText: 'Enter Password',
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  obSecure=!obSecure;
                                });
                              },
                              icon:  Icon(
                                obSecure==true?Icons.remove_red_eye_outlined:Icons.visibility_off,
                                color: const Color(0xFF454B60),
                                size: 22,
                              ),
                            ),
                            contentPadding: const EdgeInsets.all(10),
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25,),


                      InkWell(
                          onTap: () async {
                            final connectivityResult =
                            await (Connectivity().checkConnectivity());
                            if (connectivityResult == ConnectivityResult.mobile ||
                                connectivityResult == ConnectivityResult.wifi) {
                              if (username.text.isEmpty) {
                                Common.toastMessaage(
                                    'Username cannot be empty', Colors.red);
                              } else if (password.text.isEmpty) {
                                Common.toastMessaage(
                                    'Password cannot be empty', Colors.red);
                              } else {
                                setState(() {
                                  _loading = true;
                                });

                                LoginModel object = await HttpService.login(
                                    username.text, password.text, firebaseToken);
                                if (object.status == true) {
                                  Common.saveSharedPref(
                                      "sound", 'slow_spring_board');
                                  Common.saveSharedPref(
                                      "token", object.data!.token.toString());
                                  Common.saveSharedPref("name",
                                      object.data!.name.toString().toUpperCase());
                                  Common.saveSharedPref(
                                      "userId", object.data!.userId.toString());
                                  Common.saveSharedPref(
                                      "role", object.data!.role.toString());
                                  Common.saveSharedPref(
                                      "roleId", object.data!.roleId.toString());
                                  Common.saveSharedPref(
                                      "multiBranch", object.data!.isMultiBranch.toString());
                                  Common.saveSharedPref(
                                      "callLogPermission", 'false');

                                  if (object.status == true) {
                                    if (context.mounted) {

                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => Dashboard(
                                                object.data!.token.toString())),
                                      );
                                    }
                                  } else {}

                                  Common.toastMessaage(
                                      object.message, Colors.green);
                                } else {
                                  setState(() {
                                    _loading = false;
                                    Common.toastMessaage(
                                        object.message, Colors.red);
                                  });
                                }
                              }
                            } else {
                              setState(() {
                                _loading = false;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'No Network Found..Try Again Later..'),
                                    backgroundColor: Colors.redAccent,
                                    elevation: 10,
                                    behavior: SnackBarBehavior.floating,
                                    margin: EdgeInsets.all(10),
                                  ),
                                );
                              });
                            }
                          },
                        child: Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 45,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.black),
                          child:  Center(
                            child: _loading == true
                                ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ):const Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white
                                )
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                const ForgotPasswordNumber()),
                          );
                        },
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // ElevatedButton(
                      //   onPressed: () async {
                      //     Navigator.of(context).pushAndRemoveUntil(
                      //         MaterialPageRoute(
                      //             builder: (context) => CreditHomePageView()),
                      //             (Route<dynamic> route) => false);
                      //
                      //     // Navigator.of(context).pushAndRemoveUntil(
                      //     //     MaterialPageRoute(builder: (context) => Dashboard()),
                      //     //         (Route<dynamic> route) => false);
                      //   },
                      //   style: ElevatedButton.styleFrom(
                      //       onPrimary: Colors.orangeAccent,
                      //       shadowColor: Colors.orange,
                      //       elevation: 15,
                      //       padding: EdgeInsets.zero,
                      //       shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(15))),
                      //   child: Ink(
                      //     decoration: BoxDecoration(
                      //         gradient: const LinearGradient(colors: [
                      //           Colors.orangeAccent,
                      //           Colors.orange
                      //         ]),
                      //         borderRadius: BorderRadius.circular(15)),
                      //     child: Container(
                      //       width: 200,
                      //       height: 50,
                      //       alignment: Alignment.center,
                      //       child: _loading == true
                      //           ? Center(
                      //         child: CircularProgressIndicator(
                      //           color: Colors.white,
                      //         ),
                      //       )
                      //           : const Text(
                      //         'credit',
                      //         style: TextStyle(
                      //           fontSize: 20,
                      //           color: Colors.white,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      // ElevatedButton(
                      //   onPressed: () async {
                      //     Navigator.of(context).pushAndRemoveUntil(
                      //         MaterialPageRoute(
                      //             builder: (context) => InsuranceHomePageView()),
                      //             (Route<dynamic> route) => false);
                      //
                      //     // Navigator.of(context).pushAndRemoveUntil(
                      //     //     MaterialPageRoute(builder: (context) => Dashboard()),
                      //     //         (Route<dynamic> route) => false);
                      //   },
                      //   style: ElevatedButton.styleFrom(
                      //       onPrimary: Colors.orangeAccent,
                      //       shadowColor: Colors.orange,
                      //       elevation: 15,
                      //       padding: EdgeInsets.zero,
                      //       shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(15))),
                      //   child: Ink(
                      //     decoration: BoxDecoration(
                      //         gradient: const LinearGradient(colors: [
                      //           Colors.orangeAccent,
                      //           Colors.orange
                      //         ]),
                      //         borderRadius: BorderRadius.circular(15)),
                      //     child: Container(
                      //       width: 200,
                      //       height: 50,
                      //       alignment: Alignment.center,
                      //       child: _loading == true
                      //           ? Center(
                      //         child: CircularProgressIndicator(
                      //           color: Colors.white,
                      //         ),
                      //       )
                      //           : const Text(
                      //         'Insurance',
                      //         style: TextStyle(
                      //           fontSize: 20,
                      //           color: Colors.white,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      // ElevatedButton(
                      //   onPressed: () async {
                      //     Navigator.of(context).pushAndRemoveUntil(
                      //         MaterialPageRoute(
                      //             builder: (context) => ReminderManagementHomePageView()),
                      //             (Route<dynamic> route) => false);
                      //
                      //     // Navigator.of(context).pushAndRemoveUntil(
                      //     //     MaterialPageRoute(builder: (context) => Dashboard()),
                      //     //         (Route<dynamic> route) => false);
                      //   },
                      //   style: ElevatedButton.styleFrom(
                      //       onPrimary: Colors.orangeAccent,
                      //       shadowColor: Colors.orange,
                      //       elevation: 15,
                      //       padding: EdgeInsets.zero,
                      //       shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(15))),
                      //   child: Ink(
                      //     decoration: BoxDecoration(
                      //         gradient: const LinearGradient(colors: [
                      //           Colors.orangeAccent,
                      //           Colors.orange
                      //         ]),
                      //         borderRadius: BorderRadius.circular(15)),
                      //     child: Container(
                      //       width: 200,
                      //       height: 50,
                      //       alignment: Alignment.center,
                      //       child: _loading == true
                      //           ? Center(
                      //         child: CircularProgressIndicator(
                      //           color: Colors.white,
                      //         ),
                      //       )
                      //           : const Text(
                      //         'Reminder System',
                      //         style: TextStyle(
                      //           fontSize: 20,
                      //           color: Colors.white,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      // Padding(
                      //   padding: EdgeInsets.fromLTRB(
                      //       SizeConfig.screenWidth!/20.55,
                      //       SizeConfig.screenHeight!/136.6,
                      //       SizeConfig.screenWidth!/20.55,
                      //       0
                      //   ),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       Text("Don't have an account?", style: TextStyle(color: texthint),),
                      //       GestureDetector(
                      //         onTap: (){
                      //           // Navigator.push(context, MaterialPageRoute(builder: (context) => Register()));
                      //         },
                      //         child: Text(
                      //           "Register",
                      //           style: TextStyle(
                      //               color: buttonColor,
                      //               fontWeight: FontWeight.w600,
                      //               fontSize: SizeConfig.screenHeight!/45.54          /// 15
                      //           ),
                      //         ),
                      //       )
                      //     ],
                      //   ),
                      // ),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
