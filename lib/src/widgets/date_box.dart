import 'package:flutter/material.dart';

class DateBox extends StatelessWidget {
  final String centerDate;
  final String tithi;
  final bool isHoliday;
  final bool isActive;
  final int language;
  final Function onTap;
  const DateBox({
    Key key,
    this.centerDate,
    this.isHoliday = false,
    this.isActive = false,
    this.tithi,
    this.language,
    this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
              color: Theme.of(context).colorScheme.onPrimary.withAlpha(50)),
        ),
        width: MediaQuery.of(context).size.width / 7,
        height: double.maxFinite,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 3.0),
          color: isActive
              ? Theme.of(context).colorScheme.secondary.withAlpha(180)
              : Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                centerDate ?? '',
                style: TextStyle(
                  color: isHoliday
                      ? Theme.of(context).errorColor
                      : Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              Container(
                height: Theme.of(context).textTheme.overline.fontSize,
                child: Text(
                  tithi ?? '',
                  style: Theme.of(context).textTheme.overline.copyWith(
                        color: isHoliday
                            ? Theme.of(context).errorColor
                            : Theme.of(context).colorScheme.onPrimary,
                        letterSpacing: 0.0,
                        fontSize: language == 0
                            ? Theme.of(context).textTheme.overline.fontSize -
                                2.0
                            : Theme.of(context).textTheme.overline.fontSize,
                      ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
