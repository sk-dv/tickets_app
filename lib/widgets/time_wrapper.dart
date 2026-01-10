import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tickets_app/core/theme/app_colors.dart';
import 'package:tickets_app/core/theme/app_theme.dart';
import 'package:tickets_app/screens/home_screen.dart';

import 'shadowned_action_button.dart';

enum TimeSection {
  date,
  time;

  String get title {
    return this == date ? 'SELECCIONAR FECHA' : 'SELECCIONAR HORA';
  }
}

Future<void> showTimeModal(
  BuildContext context, {
  required TimeSection section,
  required Widget Function(BuildContext, SelectionOverlayBuilder) builder,
}) async {
  await showModalBottomSheet(
    context: context,
    backgroundColor: AppColors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return TimeWrapper(title: section.title, builder: builder);
    },
  );
}

class TimeWrapper extends StatelessWidget {
  const TimeWrapper({super.key, required this.title, required this.builder});

  final String title;
  final Widget Function(BuildContext, SelectionOverlayBuilder) builder;

  @override
  Widget build(BuildContext context) {
    return Localizations(
      locale: const Locale('es', 'MX'),
      delegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      child: Container(
        height: context.screenHeight * 0.4,
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: AppTheme.mono.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: CupertinoTheme(
                data: CupertinoThemeData(
                  textTheme: CupertinoTextThemeData(
                    dateTimePickerTextStyle: AppTheme.mono.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                    ),
                  ),
                ),
                child: builder(context, overlay),
              ),
            ),
            const SizedBox(height: 16),
            ShadownedActionButton(
              onPressed: Navigator.of(context).pop,
              text: 'CONFIRMAR',
            ),
          ],
        ),
      ),
    );
  }

  Widget overlay(_, {required int columnCount, required int selectedIndex}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.black),
      ),
    );
  }
}
