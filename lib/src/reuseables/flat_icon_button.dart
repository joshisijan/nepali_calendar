import 'package:flutter/material.dart';

class FlatIconButton extends StatelessWidget {
  final Function onPressed;
  final Widget firstChild;
  final Widget secondChild;
  const FlatIconButton({
    Key key,
    @required this.onPressed,
    @required this.firstChild,
    @required this.secondChild,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Container(
        constraints: BoxConstraints(
          minWidth: 90.0,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            firstChild,
            SizedBox(
              width: 5.0,
            ),
            secondChild,
          ],
        ),
      ),
      onPressed: onPressed,
    );
  }
}
