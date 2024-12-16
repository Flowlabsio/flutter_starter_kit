import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

enum ButtonType {
  elevated,
  filled,
  tonal,
  outlined,
  text;
}

class LoadingButton extends StatefulWidget {
  final bool isLoading;
  final Widget child;
  final ButtonType type;
  final VoidCallback? onPressed;
  final ButtonStyle? style;
  final Widget? loader;
  final double? strokeWidth;
  final Color? loaderColor;
  final AnimatedSwitcherTransitionBuilder? transitionBuilder;
  final Duration duration;

  const LoadingButton({
    super.key,
    required this.child,
    required this.type,
    this.isLoading = false,
    this.duration = const Duration(milliseconds: 300),
    this.onPressed,
    this.style,
    this.loader,
    this.strokeWidth,
    this.loaderColor,
    this.transitionBuilder,
  });

  @override
  State<LoadingButton> createState() => _LoadingButtonState();
}

class _LoadingButtonState extends State<LoadingButton> {
  late double _childHeight = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateChildSize());
  }

  void _updateChildSize() {
    final renderBox = context.findRenderObject() as RenderBox?;
    setState(() {
      _childHeight = renderBox?.size.height ?? 0;
    });
  }

  Widget _defaultFadeTransition(Widget child, Animation<double> animation) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }

  void _onPressed() {
    if (widget.isLoading) return;
    widget.onPressed?.call();
  }

  @override
  Widget build(BuildContext context) {
    final colorsProvider = Theme.of(context).colors;

    final content = AnimatedSwitcher(
        duration: widget.duration,
        transitionBuilder: widget.transitionBuilder ?? _defaultFadeTransition,
        child: widget.isLoading
            ? widget.loader ??
                SizedBox(
                  width: _childHeight * 0.5,
                  height: _childHeight * 0.5,
                  child: SizedBox(
                    width: _childHeight,
                    height: _childHeight,
                    child: CircularProgressIndicator(
                      strokeWidth: widget.strokeWidth ?? UISpacing.px1,
                      color: widget.loaderColor ?? colorsProvider.onPrimary,
                    ),
                  ),
                )
            : widget.child);

    if (widget.type == ButtonType.elevated) {
      return ElevatedButton(
        onPressed: widget.onPressed == null ? null : _onPressed,
        style: widget.style,
        child: content,
      );
    }

    if (widget.type == ButtonType.outlined) {
      return OutlinedButton(
        onPressed: widget.onPressed == null ? null : _onPressed,
        style: widget.style,
        child: content,
      );
    }

    if (widget.type == ButtonType.text) {
      return TextButton(
        onPressed: widget.onPressed == null ? null : _onPressed,
        style: widget.style,
        child: content,
      );
    }

    if (widget.type == ButtonType.tonal) {
      return FilledButton.tonal(
        onPressed: widget.onPressed == null ? null : _onPressed,
        style: widget.style,
        child: content,
      );
    }

    if (widget.type == ButtonType.filled) {
      return FilledButton(
        onPressed: widget.onPressed == null ? null : _onPressed,
        style: widget.style,
        child: content,
      );
    }

    throw Exception('Button type not supported');
  }
}
