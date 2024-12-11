import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class LoadingButton extends StatefulWidget {
  final bool isLoading;
  final Widget child;
  final VoidCallback? onPressed;
  final ButtonStyle? style;
  final Widget? loader;
  final AnimatedSwitcherTransitionBuilder? transitionBuilder;

  const LoadingButton({
    super.key,
    required this.isLoading,
    required this.child,
    this.onPressed,
    this.style,
    this.loader,
    this.transitionBuilder,
  });

  @override
  State<LoadingButton> createState() => _LoadingButtonState();
}

class _LoadingButtonState extends State<LoadingButton> {
  final GlobalKey _childKey = GlobalKey();

  late double _childWidth;
  late double _childHeight;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateChildSize());
  }

  void _updateChildSize() {
    final renderBox =
        _childKey.currentContext?.findRenderObject() as RenderBox?;
    setState(() {
      _childWidth = renderBox?.size.width ?? 0;
      _childHeight = renderBox?.size.height ?? 0;
    });
  }

  Widget _defaultFadeTransition(Widget child, Animation<double> animation) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
     final colorsProvider = Theme.of(context).colors;

    return FilledButton(
      onPressed: widget.isLoading ? null : widget.onPressed,
      style: widget.style,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: widget.transitionBuilder ?? _defaultFadeTransition,
        child: widget.isLoading
            ? SizedBox(
                width: _childWidth,
                height: _childHeight,
                child: Center(
                  child: SizedBox(
                    width: _childHeight,
                    height: _childHeight,
                    child: widget.loader ??
                        CircularProgressIndicator(
                          strokeWidth: 2.0,
                          color: colorsProvider.onPrimary,
                        ),
                  ),
                ),
              )
            : Container(
                key: _childKey,
                child: widget.child,
              ),
      ),
    );
  }
}
