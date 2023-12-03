import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ExpenseModel{
  DateTime expense_date;
  double money_expense;
  String note;
  String uid;

  ExpenseModel({
    required this.expense_date,
    required this.money_expense,
    required this.note,
    required this.uid
  });

  factory ExpenseModel.fromJson(Map<String,dynamic> json){
    return ExpenseModel(
        expense_date: DateTime.parse(json['expense_date']) ,
        money_expense: double.parse(json["money_expense"]),
        note: json["note"],
        uid: json["uid"]
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String,dynamic>{};
    data["expense_date"]= expense_date.toIso8601String();
    data["money_expense"]= money_expense.toString();
    data["note"]= note;
    data["uid"]= uid;
    return data;
  }
}