import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nepali_calendar/src/cubit/language_cubit.dart';
import 'package:nepali_calendar/src/models/time_model.dart';
import 'package:nepali_calendar/src/screens/downloading_widget.dart';
import 'package:nepali_calendar/src/services/time_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class UpdateMode extends StatelessWidget {
  int year;
  @override
  Widget build(BuildContext context) {
    year =
        CurrentTimeModel(englishDateTime: DateTime.now()).nepaliDateTime.year;
    () async {
      SharedPreferences.getInstance().then((value) {
        value.setInt('calendarMode', 2);
      });
    }.call();
    return BlocBuilder(
      cubit: LanguageCubit(),
      builder: (context, languageState) {
        return Scaffold(
          backgroundColor: Theme.of(context).primaryColorDark,
          body: Container(
            padding: EdgeInsets.all(20.0),
            width: double.maxFinite,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  languageState == 0 ? 'Update available' : 'अपडेट उपलब्ध छ',
                  style: Theme.of(context).textTheme.headline6.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  languageState == 0
                      ? 'There is an update available for year current year ${year.toString()}.'
                      : '${CustomTimeUtil().englishToNepaliDate(year)} बर्ष को लागि अपडेट उपलब्ध छ।',
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                FlatButton.icon(
                  color: Theme.of(context).buttonColor,
                  onPressed: () {
                    Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (_, animation, __) {
                        return DownloadingFileWidget();
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
                  },
                  icon: Icon(
                    Icons.update,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  label: Text(
                    languageState == 0 ? 'Update now' : 'अपडेट गर्नुहोस्',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
