class MaxSubscriptionModel {
  late String? id;
  late String? text;
  late double? price;
  late double? newPromoPrice;

  late List? prosList = [];

  MaxSubscriptionModel({
    required this.id,
    required this.text,
    required this.price,
    required this.prosList,
    required this.newPromoPrice,
  });
}
