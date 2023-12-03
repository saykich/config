
import 'package:cloud_firestore/cloud_firestore.dart';

class DailyExpenseAPI{
  final CollectionReference expenseRef = FirebaseFirestore.instance.collection('daily_expense');

  createData({required String money, required String note , required uid}) async{
    await expenseRef.add({
      "money_expense": money,
      "note": note,
      "expense_date" : DateTime.now().toIso8601String(),
      "uid" : uid
    }
    );
  }

  updateData({required String docId, required String money, required String note }) async{
    await expenseRef.doc(docId).update({
      "money_expense": money,
      "note": note,
    }
    );
  }

  deleteData(String docId) async{
    await expenseRef.doc(docId).delete();
  }

}