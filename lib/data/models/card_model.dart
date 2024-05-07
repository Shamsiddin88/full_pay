class CardModel {
  final String cardHolder;
  final String cardNumber;
  final String expireDate;
  final String userId;
  final String cardId;
  final int type;
  final String cvc;
  final String icon;
  final String color;
  final String bank;
  final double balance;
  final bool isMain;

  CardModel({
    required this.cardHolder,
    required this.cardNumber,
    required this.expireDate,
    required this.userId,
    required this.type,
    required this.cvc,
    required this.icon,
    required this.balance,
    required this.bank,
    required this.cardId,
    required this.color,
    required this.isMain,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      cardHolder: json['cardHolder'] as String? ?? "",
      cardNumber: json['cardNumber'] as String? ?? "",
      expireDate: json['expireDate'] as String? ?? "",
      userId: json['userId'] as String? ?? "",
      type: json['type'] as int? ?? 0,
      cvc: json['cvc'] as String? ?? "",
      icon: json['icon'] as String? ?? "",
      balance: (json['balance'] as num? ?? 0).toDouble(),
      bank: json['bank'] as String? ?? "",
      cardId: json['cardId'] as String? ?? "",
      color: json['color'] as String? ?? "",
      isMain: json['isMain'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cardHolder': cardHolder,
      'cardNumber': cardNumber,
      'expireDate': expireDate,
      'userId': userId,
      'type': type,
      'cvc': cvc,
      'icon': icon,
      'balance': balance,
      'bank': bank,
      'cardId': cardId,
      'color': color,
      'isMain': isMain,
    };
  }

  Map<String, dynamic> toJsonForUpdate() {
    return {
      'balance': balance,
      'isMain': isMain,
      'color': color,
    };
  }

  CardModel copyWith({
    String? cardHolder,
    String? cardNumber,
    String? expireDate,
    String? userId,
    int? type,
    String? cvc,
    String? icon,
    String? bank,
    double? balance,
    String? cardId,
    String? color,
    bool? isMain,
  }) {
    return CardModel(
      cardHolder: cardHolder ?? this.cardHolder,
      cardNumber: cardNumber ?? this.cardNumber,
      expireDate: expireDate ?? this.expireDate,
      userId: userId ?? this.userId,
      type: type ?? this.type,
      cvc: cvc ?? this.cvc,
      icon: icon ?? this.icon,
      bank: bank ?? this.bank,
      balance: balance ?? this.balance,
      cardId: cardId ?? this.cardId,
      color: color ?? this.color,
      isMain: isMain ?? this.isMain,
    );
  }

  static CardModel initial() => CardModel(
        cardHolder: "",
        cardNumber: "",
        expireDate: "",
        userId: "",
        type: -1,
        cvc: "",
        icon: "",
        balance: 0,
        bank: "",
        cardId: "",
        color: "",
        isMain: false,
      );
}
