import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:config/api/daily_expense_api.dart';
import 'package:config/api/user_api.dart';
import 'package:config/model/daily_expense_model.dart';
import 'package:config/page/login/login.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RootPage extends StatefulWidget {
  final String uid;
  const RootPage(this.uid, {super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {

  TextEditingController money =TextEditingController();
  TextEditingController note =TextEditingController();
  String storeDocId = "";

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text("Daily Expense"),
        backgroundColor: Colors.red[400],
        actions: [
          IconButton(onPressed: (){
            _scaffoldKey.currentState!.openEndDrawer();
            storeDocId="";
            setDataEmpty();
          }, icon: const Icon(Icons.add)),
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
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("daily_expense").where("uid", isEqualTo: widget.uid).snapshots(),
          builder: (index, snapshot){
            if (snapshot.connectionState == ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator());
            }
            else if (snapshot.hasError){
              return Center(child: Text("Firebase Error: ${snapshot.error}"));
            }
            else{
              var data = snapshot.data;
              return ListView.builder(
                  itemCount: data!.size,
                  itemBuilder:(context,index){
                    ExpenseModel expense = ExpenseModel.fromJson(data.docs[index].data());
                    var docId = data.docs[index].id;
                    return InkWell(
                      onTap: (){
                        money.text = expense.money_expense.toString();
                        note.text = expense.note.toString();
                        setState(() {
                          storeDocId = docId;
                        });
                        _scaffoldKey.currentState!.openEndDrawer();
                      },
                      child: Card(
                        child:
                        // ListTile(
                        //   title: Text("${expense.money_expense}"),
                        //   subtitle: Text(expense.note),
                        //   // trailing: IconButton(onPressed:
                        //   //     ()=> BabyApiService().deleteData(docId),
                        //   //   icon: Icon(Icons.delete),
                        //   // ),
                        // ),
                      
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Money Expense: ${expense.money_expense}"),
                                  //Text("Money Expense: ${double.parse(expense.money_expense.toString())}"),
                                  Text("Note: ${expense.note}"),
                                  Text("Expense Date: ${DateFormat("dd MMM, yyyy - hh:mm a").format(expense.expense_date) }"),
                                ],
                              ),
                              IconButton(onPressed: (){
                                DailyExpenseAPI().deleteData(docId);
                              }, icon: const Icon(Icons.delete))
                            ],
                          ),
                        )
                      ),
                    );
                  }
              );
            }
          }
      ),

      endDrawer: Drawer(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  controller: money,
                  validator: (v){
                    if (v == null || v.isEmpty)
                    {
                      return "Money Expense is required";
                    }
                  },
                  decoration: const InputDecoration(
                      label: Text("Money  Expense")
                  ),
                ),
                TextFormField(
                  controller: note,
                  validator: (v){
                    if (v == null || v.isEmpty)
                    {
                      return "Note is required";
                    }
                  },
                  decoration: const InputDecoration(
                      label: Text("Note")
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    storeDocId == "" ? ElevatedButton(onPressed: () async{
                      await DailyExpenseAPI().createData(
                          money: money.text,
                          note: note.text,
                          uid: this.widget.uid);
                      Navigator.pop(context);
                      setDataEmpty();
                    }, child: const Text("Save")) : const SizedBox(),
                    storeDocId != "" ? ElevatedButton(onPressed: () async{
                      await DailyExpenseAPI().updateData(
                          docId : storeDocId,
                          money: money.text,
                          note: note.text);
                      Navigator.pop(context);
                      setDataEmpty();
                    }, child: const Text("Update")) : const SizedBox(),
                  ],
                )
              ],
            ),
          ),
        ),
      ),

    );
  }

  setDataEmpty(){
    setState(() {
      money.text ="";
      note.text="";
    });
  }
}
