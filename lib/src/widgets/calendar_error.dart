import 'package:flutter/material.dart';

class CustomCalendarError extends StatelessWidget {
  final String title;
  final Function onPressed;
  final IconData icon;
  final bool loading;

  const CustomCalendarError({
    Key key,
    this.title,
    this.onPressed,
    this.icon = Icons.refresh,
    this.loading = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          loading
              ? CircularProgressIndicator(
                  backgroundColor: Theme.of(context).colorScheme.onPrimary,
                )
              : SizedBox.shrink(),
          !loading
              ? IconButton(
                  icon: Icon(
                    icon,
                    color: Theme.of(context).colorScheme.onPrimary,
                    size: 40.0,
                  ),
                  onPressed: onPressed,
                )
              : SizedBox.shrink(),
          !loading
              ? SizedBox(
                  height: 20.0,
                )
              : SizedBox.shrink(),
          !loading
              ? Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Align(
                    child: Text(
                      title ?? '',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                    ),
                  ),
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
