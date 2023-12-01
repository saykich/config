import 'package:config/api/user_api.dart';
import 'package:config/page/login/login.dart';
import 'package:flutter/material.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daily Expense"),
        backgroundColor: Colors.red[400],
        actions: [
          IconButton(onPressed: (){
            showDialog(context: context, builder: (context){
              return AlertDialog(
                title: const Text("Do you want to sign out?"),
                actions: [
                  ElevatedButton(onPressed: () {
                    Navigator.pop(context);
                  }, child: const Text("CANCEL")),
                  ElevatedButton(onPressed: () async{
                    bool isSuccess = await UserAPI().signOut();
                    if(isSuccess){
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const LoginPage()), (Route<dynamic> route) => false);
                    }
                  }, child: const Text("ACCEPT"))
                ],
              );
            });
          }, icon: const Icon(Icons.logout))
        ],
      ),
      body: const Text("Daily Expense"),
    );
  }
}
