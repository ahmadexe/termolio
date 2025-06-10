import 'package:flutter/material.dart';
import 'package:termolio/configs/configs.dart';
import 'package:termolio/widgets/headless/focus_handler.dart';

class Screen extends StatelessWidget {
  const Screen({
    super.key,
    required this.child,
    this.padding = EdgeInsets.zero,
    this.keyboardHandler = false,
    this.renderSettings = true,
    this.floatingActionButton,
    this.scaffoldBackgroundColor,
    this.belowBuilders,
    this.overlayBuilders,
    this.initialFormValue,
    this.onBackPressed,
  });

  final Widget child;
  final EdgeInsets padding;
  final bool keyboardHandler;
  final bool renderSettings;
  final Widget? floatingActionButton;
  final Color? scaffoldBackgroundColor;
  final List<Widget>? belowBuilders;
  final List<Widget>? overlayBuilders;
  final Map<String, dynamic>? initialFormValue;
  final Future<bool> Function()? onBackPressed;

  @override
  Widget build(BuildContext context) {
    App.init(context);

    Widget body = child;

    if (keyboardHandler) {
      body = FocusHandler(child: body);
    }

    body = Padding(padding: padding, child: body);

    return Scaffold(
      backgroundColor: AppTheme.backgroundDark,
      floatingActionButton: floatingActionButton,
      body: Stack(
        fit: StackFit.expand,
        children: [
          if (belowBuilders != null) ...belowBuilders!,
          Positioned.fill(child: body),
          if (overlayBuilders != null) ...overlayBuilders!,
        ],
      ),
    );
  }
}
