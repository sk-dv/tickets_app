import 'package:flutter/material.dart';
import 'package:tickets_app/core/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:tickets_app/screens/home_screen.dart';
import 'package:tickets_app/widgets/shadowned_button.dart';

class ShadownedActionButton extends StatelessWidget {
  const ShadownedActionButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        width: context.screenWidth * 0.7,
        height: 70,
        child: ShadownedButton(
          onPressed: onPressed,
          scales: (1.0, 0.95),
          child: Center(
            child: Text(
              text,
              style: AppTheme.mono.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
