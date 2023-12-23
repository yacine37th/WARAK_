class OrderModel {
  late String? id;
  late String? bookID;
  late String? bookTitle;
  late String? clientID;
  late String? clientImageURL;
  late String? clientFirstName;
  late String? clientLastName;
  late String? clientPhoneNumber;
  late String? clientEmail;
  late String? clientWilaya;
  late String? clienBaladiya;

  late String? client3onwan;
  late double? price;
  late int? qunatity = 1;

  late var paymentMethod;
  late String? proofImageURL;

  bool? isPayed = false; // verification by admin

  late OrderType? orderType;

  OrderModel(
      {required this.id,
      required this.clientID,
      required this.clientFirstName,
      required this.bookID,
      required this.bookTitle,
      required this.clientImageURL,
      required this.clientLastName,
      required this.orderType,
      required this.clientEmail,
      required this.clientPhoneNumber,
      required this.price,
      required this.isPayed,
      this.client3onwan,
      this.clientWilaya,
      this.clienBaladiya,
      this.paymentMethod,
      this.qunatity,
      this.proofImageURL});
}

enum OrderType { electronicCopie, physicalCopie, maxSubscription }
