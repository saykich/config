import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController email = TextEditingController(text:"");
  TextEditingController password = TextEditingController(text:"");
  TextEditingController note = TextEditingController(text:"");

  final _formKey =GlobalKey<FormState>();
  bool isEmail(String input) => EmailValidator.validate(input);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up Page'),
        centerTitle: true,
        backgroundColor: Colors.red[400],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // const Text(
              //   'Sign Up' ,
              //   style: TextStyle(fontSize: 30),
              // ),
              // const SizedBox(height: 20),
              TextFormField(
                controller: email,
                validator: (v){
                  if(v == null || v.isEmpty)
                  {
                    return "Email is required";
                  }
                  else if (!isEmail(v))
                  {
                    return 'Please enter a valid email.';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
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
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: note,
                validator: (v){
                  if (v == null || v.isEmpty)
                  {
                    return "Note is required";
                  }
                },
                decoration: const InputDecoration(
                  hintText: 'note',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),
              MaterialButton(
                onPressed:() {
                  if (_formKey.currentState!.validate()) {
                    // UserApiService().signUp(email.text.trim(), password.text.trim(),gender.text);
                    // Navigator.pop(context);
                  }
                },
                color: Colors.red[400],
                child: const Text('Sign Up') ,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
