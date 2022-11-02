class OnboardingItemDTO {
  final String color;
  final String image;
  final String title;
  final String description;
  final bool skip;

  OnboardingItemDTO({
    required this.color,
    required this.title,
    required this.description,
    required this.image,
    required this.skip,
  });
}
