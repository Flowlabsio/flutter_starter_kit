import 'package:app_initial/src/facades/facades.dart';
import 'package:reactive_forms/reactive_forms.dart';

final Map<String, String Function(Object)> validationMessages = {
  ValidationMessage.any: (error) => Localization.instance.tr.validation_any,
  ValidationMessage.compare: (error) =>
      Localization.instance.tr.validation_compare,
  ValidationMessage.contains: (error) =>
      Localization.instance.tr.validation_contains,
  ValidationMessage.creditCard: (error) =>
      Localization.instance.tr.validation_creditCard,
  ValidationMessage.email: (error) => Localization.instance.tr.validation_email,
  ValidationMessage.equals: (error) =>
      Localization.instance.tr.validation_equals,
  ValidationMessage.max: (error) {
    final max = (error as Map<String, int?>)['max']!;
    return Localization.instance.tr.validation_max(max);
  },
  ValidationMessage.maxLength: (error) {
    final requiredLength = (error as Map<String, int?>)['requiredLength']!;
    return Localization.instance.tr.validation_maxLength(requiredLength);
  },
  ValidationMessage.min: (error) {
    final min = (error as Map<String, int?>)['min']!;
    return Localization.instance.tr.validation_min(min);
  },
  ValidationMessage.minLength: (error) {
    final requiredLength = (error as Map<String, int?>)['requiredLength']!;
    return Localization.instance.tr.validation_minLength(requiredLength);
  },
  ValidationMessage.mustMatch: (error) =>
      Localization.instance.tr.validation_mustMatch,
  ValidationMessage.number: (error) =>
      Localization.instance.tr.validation_number,
  ValidationMessage.pattern: (error) =>
      Localization.instance.tr.validation_pattern,
  ValidationMessage.required: (error) =>
      Localization.instance.tr.validation_required,
  ValidationMessage.requiredTrue: (error) =>
      Localization.instance.tr.validation_requiredTrue,
};
