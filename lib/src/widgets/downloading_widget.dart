import 'package:flutter/material.dart';
import 'package:nepali_calendar/src/app_base.dart';
import 'package:nepali_calendar/src/models/time_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DownloadingFileWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int _year = CurrentTimeModel(
      englishDateTime: DateTime.now(),
    ).getNepaliDate(DateTime.now()).year;
    () async {
      SharedPreferences _preferences = await SharedPreferences.getInstance();
      _preferences.setBool('firstOrNot', true);
      Navigator.of(context).pushReplacement(PageRouteBuilder(
        pageBuilder: (_, animation, __) {
          return AppBase();
        },
        transitionDuration: Duration(milliseconds: 350),
        transitionsBuilder: (_, animation, __, child) {
          animation = CurvedAnimation(
            curve: Curves.decelerate,
            parent: animation,
          );
          return SlideTransition(
            position: Tween(
              begin: Offset(1.0, 0.0),
              end: Offset(0.0, 0.0),
            ).animate(animation),
            child: child,
          );
        },
      ));
    }.call();
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              child: CircularProgressIndicator(
                backgroundColor: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Align(
              child: Text(
                'Downloading Asset (Year $_year B.S)',
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
