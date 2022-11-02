import 'package:first_app/src/feactures/onboarding/data/onboarding_item_dto.dart';

abstract class AbstractOnboardingRepository {
  Future<List<OnboardingItemDTO>> getItems();
}
