class HistoryModel {
  final String docId;
  final String senderName;
  final String receiverName;
  final String senderId;
  final String receiverId;
  final double amount;

  HistoryModel({
    required this.docId,
    required this.amount,
    required this.receiverId,
    required this.senderId,
    required this.senderName,
    required this.receiverName
  });


  Map<String, dynamic> toJson() => {
    "docId": docId,
    "receiverName": receiverName,
    "senderName": senderName,
    "senderId": senderId,
    "receiverId": receiverId,
    "amount": amount,

  };


  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(
      docId: json["docId"] as String? ?? "",
      senderName: json["senderName"] as String? ?? "",
      receiverName: json["receiverName"] as String? ?? "",
      senderId: json["senderId"] as String? ?? "",
      amount: (json["amount"] ?? 0).toDouble(),
      receiverId: json["receiverId"] as String? ?? "",
    );
  }
}
