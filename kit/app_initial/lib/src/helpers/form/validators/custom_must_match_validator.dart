import 'package:reactive_forms/reactive_forms.dart';

class CustomMustMatchValidator extends Validator<dynamic> {
  CustomMustMatchValidator({
    required this.controlName,
    required this.matchingControlName,
  }) : super();
  final String controlName;
  final String matchingControlName;

  @override
  Map<String, dynamic>? validate(AbstractControl<dynamic> control) {
    final form = control as FormGroup;

    final formControl = form.control(controlName);
    final matchingFormControl = form.control(matchingControlName);

    if (formControl.value != matchingFormControl.value) {
      matchingFormControl.setErrors({'mustMatch': true});
    } else {
      matchingFormControl.removeError('mustMatch');
    }

    return null;
  }
}
