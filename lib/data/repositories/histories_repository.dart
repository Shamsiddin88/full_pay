import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:full_pay/data/models/history_model.dart';
import 'package:full_pay/data/models/network_response.dart';
import 'package:full_pay/utils/constants/app_constants.dart';
import 'package:rxdart/rxdart.dart';

class HistoriesRepository {
  Future<NetworkResponse> addHistory(HistoryModel historyModel) async {
    try {


      DocumentReference documentReference = await FirebaseFirestore.instance
          .collection(AppConstants.histories)
          .add(historyModel.toJson());

      await FirebaseFirestore.instance
          .collection(AppConstants.histories)
          .doc(documentReference.id)
          .update({"docId": documentReference.id});

      return NetworkResponse(data: "success");
    } on FirebaseException catch (error) {
      debugPrint("HISTORY ADD ERROR:$error");
      return NetworkResponse(errorText: error.toString());
    }
  }

  Stream<List<HistoryModel>> getHistoriesByUserId(String docId) {
    Stream<List<HistoryModel>> senderHistories = FirebaseFirestore.instance
        .collection(AppConstants.histories)
        .where("senderId", isEqualTo: docId)
        .snapshots()
        .map((event) =>
        event.docs.map((doc) => HistoryModel.fromJson(doc.data())).toList());

    Stream<List<HistoryModel>> receiverHistories = FirebaseFirestore.instance
        .collection(AppConstants.histories)
        .where("receiverId", isEqualTo: docId)
        .snapshots()
        .map((event) =>
        event.docs.map((doc) => HistoryModel.fromJson(doc.data())).toList());


    return CombineLatestStream<List<HistoryModel>, List<HistoryModel>>(
        [senderHistories, receiverHistories], (list) => list.expand((element) => element).toList());
  }

}
