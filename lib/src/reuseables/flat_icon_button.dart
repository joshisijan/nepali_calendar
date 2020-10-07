import 'package:flutter/material.dart';

class FlatIconButton extends StatelessWidget {
  final Function onPressed;
  final Widget firstChild;
  final Widget secondChild;
  final bool containerUse;
  const FlatIconButton({
    Key key,
    @required this.onPressed,
    @required this.firstChild,
    @required this.secondChild,
    this.containerUse = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Container(
        padding: containerUse ? EdgeInsets.all(10.0) : EdgeInsets.zero,
        constraints: BoxConstraints(
          minWidth: 90.0,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: containerUse
              ? MainAxisAlignment.start
              : MainAxisAlignment.spaceEvenly,
          children: [
            firstChild,
            SizedBox(
              width: containerUse ? 15.0 : 5.0,
            ),
            secondChild,
          ],
        ),
      ),
      onPressed: onPressed,
    );
  }
}
