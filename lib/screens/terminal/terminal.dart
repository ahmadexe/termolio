import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:termolio/configs/configs.dart';
import 'package:termolio/widgets/core/screen.dart';

part '_state.dart';
part '_body.dart';

class TerminalScreen extends StatelessWidget {
  const TerminalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _ScreenState(),
      child: _Body(),
    );
  }
}
