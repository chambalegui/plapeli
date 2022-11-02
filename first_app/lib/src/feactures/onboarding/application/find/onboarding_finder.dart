import 'package:first_app/src/feactures/onboarding/data/onboarding_item_dto.dart';
import 'package:first_app/src/feactures/onboarding/data/onboarding_repository.dart';

class OnboardingFinder {
  OnboardingFinder(this.repository);

  final OnboardingRepository repository;

  Future<List<OnboardingItemDTO>> getItems() async {
    return repository.getItems();
  }
}
