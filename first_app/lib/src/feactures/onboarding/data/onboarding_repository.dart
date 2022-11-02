import 'package:first_app/src/feactures/onboarding/data/onboarding_item_dto.dart';
import 'package:first_app/src/feactures/onboarding/domain/repositories/onboarding_repository.dart';

class OnboardingRepository extends AbstractOnboardingRepository {
  @override
  Future<List<OnboardingItemDTO>> getItems() async {
    List<OnboardingItemDTO> items = [
      OnboardingItemDTO(
        color: '#ffe24e',
        title: 'Cursos, juegos  y estadísticas',
        image: 'assets/images/onboarding0.png',
        description:
            "Cursos diseñados para el aprendizaje de Lenguas Maternas, acompañados de juegos y estadísticas que generan una mayor experiencia de usuario.",
        skip: true,
      ),
      OnboardingItemDTO(
        color: '#a3e4f1',
        title: 'Diccionario',
        image: 'assets/images/onboarding1.png',
        description:
            "Diccionario ilustrativo con ejemplos para la comprensión de las palabras.",
        skip: true,
      ),
      OnboardingItemDTO(
        color: '#31b77a',
        title: 'Tienda',
        image: 'assets/images/onboarding2.png',
        description:
            "Tienda con artículos de la marca y de artesanos asociados con nosotros.",
        skip: false,
      ),
    ];

    return items;
  }
}
