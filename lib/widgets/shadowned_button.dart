import 'package:flutter/material.dart';
import 'package:tickets_app/core/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';

class ShadownedButton extends StatefulWidget {
  const ShadownedButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.scales = const (1.0, 1.2),
    this.shadowned = false,
  });

  final Widget child;
  final VoidCallback onPressed;
  final (double, double) scales;
  final bool shadowned;

  @override
  State<ShadownedButton> createState() => _ShadownedButtonState();
}

class _ShadownedButtonState extends State<ShadownedButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> scaleAnimation;

  bool isPressed = false;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    scaleAnimation = Tween<double>(
      begin: widget.scales.$1,
      end: widget.scales.$2,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    setState(() => isPressed = true);
    controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    setState(() => isPressed = false);
    controller.reverse();
    widget.onPressed.call();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      child: ScaleTransition(
        scale: scaleAnimation,
        child: Container(
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: widget.shadowned ? AppColors.black : AppColors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.black, width: 0.5),
            boxShadow: [
              if (!isPressed)
                BoxShadow(
                  color: AppColors.black,
                  blurRadius: 0,
                  spreadRadius: 0,
                  offset: const Offset(2, 1.5),
                ),
            ],
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
