import 'package:config/api/user_api.dart';
import 'package:config/provider/auth_provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController email = TextEditingController(text:"");
  TextEditingController password = TextEditingController(text:"");
  TextEditingController dateController = TextEditingController();
  TextEditingController note = TextEditingController(text:"");

  final _formKey =GlobalKey<FormState>();
  bool isEmail(String input) => EmailValidator.validate(input);
  final tetController = TextEditingController();
  DateTime? dob ;
  void _selDatePicker() {
    showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2023), lastDate: DateTime.now()).then((pickedDate) {
      if (pickedDate == null) {
        return ;
      }
      setState(() {
        tetController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
        dob = pickedDate;
      });
    });
  }


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
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
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
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
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
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  //readOnly: true,
                  decoration: const InputDecoration(
                    hintText: 'Date of birth',
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 30),
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        )),
                    //filled: true,
                    //prefixIcon: Icon(Icons.calendar_today),
                    //enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                  onTap: _selDatePicker,
                  controller: tetController,
                  validator: (v){
                    if (v == null || v.isEmpty)
                    {
                      return "Date of birth is required";
                    }
                  },
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
                    hintText: 'Note',
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 15),
                MaterialButton(
                  onPressed:() {
                    if (_formKey.currentState!.validate()) {
                      UserAPI().signUp(email.text.trim(), password.text.trim(), dob!, note.text.trim());
                      Navigator.pop(context);
                    }
                  },
                  color: Colors.red[400],
                  child: const Text('Sign Up') ,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
