class AuthorModel {
  late String? id;
  late String? name;
  late String? imageURL;
  late String? aboutAuthor;

  late List? myBooks = [];

  AuthorModel({
    required this.id,
    required this.name,
    required this.myBooks,
    required this.imageURL,
    required this.aboutAuthor,
  });
}
