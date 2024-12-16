import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ReactivePasswordField extends StatefulWidget {
  const ReactivePasswordField({
    required this.formControlName,
    super.key,
    this.textInputAction,
    this.decoration,
  });

  final String formControlName;
  final TextInputAction? textInputAction;
  final InputDecoration? decoration;

  @override
  State<ReactivePasswordField> createState() => _ReactivePasswordFieldState();
}

class _ReactivePasswordFieldState extends State<ReactivePasswordField> {
  bool _obscureText = true;

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final decoration = widget.decoration ?? const InputDecoration();

    return ReactiveTextField<String>(
      obscureText: _obscureText,
      formControlName: widget.formControlName,
      textInputAction: widget.textInputAction,
      decoration: decoration.copyWith(
        suffixIcon: ExcludeFocus(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) => ScaleTransition(
              scale: animation,
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            ),
            child: IconButton(
              key: ValueKey<bool>(_obscureText),
              icon: Icon(
                _obscureText
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
              ),
              onPressed: _toggleVisibility,
            ),
          ),
        ),
      ),
    );
  }
}
