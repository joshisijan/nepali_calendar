import 'package:flutter/material.dart';

class CustomDot extends StatelessWidget {
  final Color color;
  final double size;
  final bool active;

  const CustomDot({
    Key key,
    this.color,
    this.size,
    this.active = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: size ?? 10.0,
      width: size ?? 10.0,
      decoration: BoxDecoration(
        color: color?.withAlpha(active ? 255 : 150) ??
            Theme.of(context)
                .colorScheme
                .onPrimary
                .withAlpha(active ? 255 : 150),
        borderRadius: BorderRadius.circular(this.size ?? 10.0),
      ),
    );
  }
}
