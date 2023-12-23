class CustomCategoryModel {
  late String? id;
  late String? name;

  late List? books = [];

  CustomCategoryModel({
    required this.id,
    required this.name,
    this.books,
  });
}
