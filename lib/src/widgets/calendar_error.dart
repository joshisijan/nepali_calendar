import 'package:flutter/material.dart';

class CustomCalendarError extends StatelessWidget {
  final String title;
  final Function onPressed;
  final bool loading;

  const CustomCalendarError({
    Key key,
    this.title,
    this.onPressed,
    this.loading = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
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
                    Icons.refresh,
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
              ? Align(
                  child: Text(
                    title ?? '',
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                  ),
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
