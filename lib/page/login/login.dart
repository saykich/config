import 'package:config/page/login/signUp.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

import '../../provider/auth_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController email;
  late TextEditingController password;
  double screenWidth =0;
  double screenHeight=0;
  bool? isChecked = false;

  final _formKey = GlobalKey<FormState>();
  bool isEmail(String input) => EmailValidator.validate(input);

  @override
  void initState() {
    email = TextEditingController(text: "");
    password = TextEditingController(text: "");
    super.initState();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    final AuthProvider authProvider = Provider.of<AuthProvider>(context);
    bool isEmail(String input) => EmailValidator.validate(input);

    return LoadingOverlay(
        isLoading: authProvider.isLoading, 
        child: Scaffold(
          body: SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  width: screenWidth,
                  height: screenHeight,
                  child: Column(
                    children: [
                      header(),
                      middle(),
                      footer()
                    ],
                  ),
                ),
              )
          ),
        )
    );
  }
  Widget header() {
    return SizedBox(
      width: screenWidth * 0.9,
      child: Image.asset("assets/coffee.jpg"),
    );
  }
  Widget middle(){
    return Form(
        key: _formKey,
        child: SizedBox(
          width: screenWidth * 0.9,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //const SizedBox(height: 20),
              Text("Welcome back" , style: TextStyle(
                  color: Colors.red[400],
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
                  textAlign: TextAlign.left
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: email,
                validator: (v){
                  if(v == null || v.isEmpty)
                  {
                    return "Email  is required";
                  }
                  else if (!isEmail(v) )
                  {
                    return 'Please enter a valid email.';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    hintText: 'Email', prefixIcon: Icon(FontAwesomeIcons.envelope)
                  //border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: password,
                validator: (v){
                  if (v == null || v.isEmpty)
                  {
                    return "Password is required";
                  }
                  else if (v.length < 8)
                  {
                    return "Password must be 8 digit";
                  }
                },
                decoration: const InputDecoration(
                    hintText: 'Password',
                    prefixIcon: Icon(FontAwesomeIcons.lock)
                  //border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              // Row(
              //   children: [
              //     SizedBox(
              //         width: screenWidth * 0.45,
              //         //color: Colors.green,
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           children: [
              //             Checkbox(
              //                 value: isChecked,
              //                 tristate: true,
              //                 onChanged: (newBool) {
              //                   setState(() {
              //                     isChecked = newBool;
              //                   });
              //                 }),
              //             Text(
              //               "Remember me",
              //               style: TextStyle(
              //                   color: Colors.red[400],
              //                   fontSize: 16
              //               ),
              //
              //             ),
              //           ],
              //         )
              //     ),
              //
              //     SizedBox(
              //         width: screenWidth * 0.45,
              //         //color: Colors.red,
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.end,
              //           children: [
              //             /*Text(
              //           "Forget Password?",
              //           style: TextStyle(
              //             color: Colors.red[400],
              //             fontSize: 16,
              //           ),
              //         ),*/
              //             TextButton(
              //                 onPressed: (){},
              //                 style: TextButton.styleFrom(
              //                     textStyle: TextStyle(fontSize: 16)
              //                 ),
              //                 child: Text("Forget Password?",style: TextStyle(color: Colors.red[400]))
              //             )
              //           ],
              //         )
              //     ),
              //   ],
              // )
            ],
          ),
        )
    );
  }

  Widget footer(){
    return SizedBox(
      child: Container(
        child: Column(
          children: [
            const SizedBox(height: 20),
            SizedBox(
              width: screenWidth * 0.9,
              height: 40,
              child: MaterialButton(
                onPressed: (){
                  if (_formKey.currentState!.validate()) {
                    // UserApiService().signIn(email.text.trim(), password.text.trim());
                    // Navigator.pushReplacement(context,
                    //     MaterialPageRoute(builder: (_)=> BabyPage()));
                  }
                },
                color: Colors.red[400],
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                child: const Text("Login"),
              ),

            ),
            //const SizedBox(height: 20),
            // const Text("Or Login with"),
            // const SizedBox(height: 20),
            // Padding(
            //   padding: const EdgeInsets.only(left: 80,right: 80),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: [
            //       InkWell(
            //         borderRadius: BorderRadius.circular(25),
            //         child: Container(
            //           width: 40,
            //           height: 40,
            //           decoration: const BoxDecoration(shape: BoxShape.circle),
            //           child: Image.network(
            //             'https://th.bing.com/th/id/OIP.FQYyu80e7eHzc3lbL4BzBQHaHY?w=184&h=183&c=7&r=0&o=5&pid=1.7',
            //             width: 40,
            //             height: 40,
            //           ),
            //         ),
            //         onTap: () => (){},
            //       ),
            //       InkWell(
            //         child: Container(
            //           width: 40,
            //           height: 40,
            //           decoration: const BoxDecoration(shape: BoxShape.circle),
            //           child: Image.network('https://th.bing.com/th/id/OIP.YPM8IZ98U35wLNzG0a73CgHaHa?w=186&h=186&c=7&r=0&o=5&pid=1.7',
            //             width: 40,
            //             height: 40,
            //           ),
            //         ),
            //         onTap: () => (){},
            //       ),
            //       InkWell(
            //         child: Container(
            //           width: 40,
            //           height: 40,
            //           decoration: const BoxDecoration(shape: BoxShape.circle),
            //           child: Image.network(
            //             'https://cdn-icons-png.flaticon.com/512/174/174857.png',
            //             width: 40,
            //             height: 40,
            //           ),
            //         ),
            //         onTap: () => (){},
            //       ),
            //
            //       // Icon(Icons.facebook),
            //       // Icon(Icons.messenger),
            //       // Icon(Icons.facebook)
            //     ],
            //   ),
            // ),
            // const SizedBox(height: 10),
            //const Text("Don't have account?"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have account?"),
                //Text("Sign up",style: TextStyle(color: Colors.red[400]),),
                TextButton(
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SignUp()));
                    },
                    style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 16)
                    ),
                    child: Text("Sign Up", style: TextStyle(color: Colors.red[400]))
                )
              ],
            )
          ],
        ),
      ),
    );
  }


}
