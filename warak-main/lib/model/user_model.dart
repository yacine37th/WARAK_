class UserModel {
  late String? uID;
  late String? firstName;
  late String? lastName;

  late String? imageURL;
  late String? aboutMe;
  late String? instaAccount;
  late String? facebookAccount;
  late String? i9ama;

  bool isSubbed = false;
  String? subStartingDay;
  String? subEndingingDay;
  late String? email;
  late List? favoriteBooks;
  late List? ordersElectronicBooks;

  late List? maktabati = [];

  UserModel({
    required this.uID,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.aboutMe,
    required this.instaAccount,
    required this.facebookAccount,
    required this.i9ama,
    required this.imageURL,
    required this.favoriteBooks,
    required this.maktabati,
    required this.ordersElectronicBooks,
    this.isSubbed = false,
    this.subEndingingDay,
    this.subStartingDay,
  });
}
