import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  final Widget child;
  const BackgroundWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [theme.primaryColor.withOpacity(0.4), Colors.white],
          begin: AlignmentDirectional.topCenter,
          end: AlignmentDirectional.bottomCenter,
          stops: [0, 0.25],
        ),
      ),
      child: child,
    );
  }
}
