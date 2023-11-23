import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:config/model/userModel.dart';
import 'package:flutter/material.dart';

class AddUsersPage extends StatefulWidget {
  const AddUsersPage({super.key});

  @override
  State<AddUsersPage> createState() => _AddUsersPageState();
}

class _AddUsersPageState extends State<AddUsersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Page add users"),
        //centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            print("Click add");
          }, icon: const Icon(Icons.add))
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("users").snapshots(),
        builder: (index,snapshots ) {
          if(snapshots.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }
          else if (snapshots.hasError){
            return Center(child: Text("Firebase Error: ${snapshots.error}"));
          }
          else{
            var data = snapshots.data;
            return ListView.builder(
                itemCount: data?.size,
                itemBuilder: (context,index){
                  UserModel users = UserModel.fromJson(data!.docs[index].data());
                  // return Container(
                  //   color: Colors.grey,
                  //   margin: const EdgeInsets.all(8.0),
                  //   child: ListTile(
                  //     title: Text("username : ${users.username}"),
                  //     subtitle: Text("Gmail: ${users.gmail}"),
                  //   ),
                  // );

                  // return Padding(
                  //   padding: const EdgeInsets.only(top: 8.0),
                  //   child: Container(
                  //     margin: const EdgeInsets.symmetric(horizontal: 8),
                  //     decoration: BoxDecoration(
                  //       color: Colors.grey,
                  //       borderRadius: BorderRadius.circular(12),
                  //     ),
                  //     child: ListTile(
                  //       title: Text("User name: ${users.username}"),
                  //       subtitle: Text("Gmail: ${users.gmail}"),
                  //     ),
                  //   ),
                  // );

                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(12)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("User name: ${users.username}"),
                          Text("Gmail: ${users.gmail}"),
                          Text("Address: ${users.address?.street} ${users.address?.city}"),
                        ],
                      ),
                    ),
                  );
                }
            );
          }
        },
      ),
    );
  }
}
