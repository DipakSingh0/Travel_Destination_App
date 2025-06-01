import 'package:flutter/material.dart';

class CustomSnackBar {
  static void show({
    required BuildContext context,
    required String message,
    bool isError = true,
    Duration duration = const Duration(seconds: 3),
    String actionLabel = 'OK',
    VoidCallback? onActionPressed,
    Color? backgroundColor,
    Color? textColor,
    IconData? icon,
  }) {
    final theme = Theme.of(context);

    // Use default icons if none provided
    final IconData displayIcon =
        icon ?? (isError ? Icons.error : Icons.check_circle);

    final snackBar = SnackBar(
      duration: duration,
      backgroundColor: backgroundColor ??
          (isError ? theme.colorScheme.error : theme.colorScheme.primary),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 6,
      content: Row(
        children: [
          AnimatedOpacity(
            opacity: 1,
            duration: const Duration(milliseconds: 500),
            child: Icon(
              displayIcon,
              color: textColor ?? Colors.white,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: textColor ?? Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
      action: SnackBarAction(
        label: actionLabel,
        textColor: textColor ?? Colors.white,
        onPressed: onActionPressed ??
            () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
      ),
    );

    // Avoid overlapping SnackBars
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
