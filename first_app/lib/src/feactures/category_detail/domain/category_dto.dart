class CategoryDTO {
  final String icon, title;

  CategoryDTO({required this.icon, required this.title});
}

// ignore: non_constant_identifier_names
List<CategoryDTO> demo_categories = [
  CategoryDTO(
    icon: "assets/icons/category/animals.png",
    title: "Animals",
  ),
  CategoryDTO(
    icon: "assets/icons/category/home.png",
    title: "Home",
  ),
  CategoryDTO(
    icon: "assets/icons/category/plants.png",
    title: "Plants",
  ),
  CategoryDTO(
    icon: "assets/icons/category/person.png",
    title: "Persons",
  ),
  CategoryDTO(
    icon: "assets/icons/category/numbers.png",
    title: "Numbers",
  ),
];
