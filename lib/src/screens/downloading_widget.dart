import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nepali_calendar/src/app.dart';
import 'package:nepali_calendar/src/cubit/calendar_mode_cubit.dart';
import 'package:nepali_calendar/src/cubit/language_cubit.dart';
import 'package:nepali_calendar/src/models/time_model.dart';
import 'package:nepali_calendar/src/services/time_util.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class DownloadingFileWidget extends StatelessWidget {
  final String year;

  const DownloadingFileWidget({Key key, this.year}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CalendarModeCubit(),
      child: DownloadingFileWidgetInner(
        year: year,
      ),
    );
  }
}

class DownloadingFileWidgetInner extends StatefulWidget {
  final String year;

  const DownloadingFileWidgetInner({Key key, this.year}) : super(key: key);

  @override
  _DownloadingFileWidgetInnerState createState() =>
      _DownloadingFileWidgetInnerState();
}

class _DownloadingFileWidgetInnerState
    extends State<DownloadingFileWidgetInner> {
  getResponse(String year) async {
    try {
      var response = await http.get(
          'https://joshisijan.github.io/calendar_scrapper/data/years/$year.json');
      return response;
    } catch (e) {
      return null;
    }
  }

  String error = '';

  @override
  Widget build(BuildContext context) {
    String _year = widget.year ??
        CurrentTimeModel(
          englishDateTime: DateTime.now(),
        ).getNepaliDate(DateTime.now()).year.toString();
    () async {
      var response = await getResponse(_year);
      if (response != null && response?.statusCode == 200) {
        try {
          String body = response.body;
          Directory storagePathDirectory =
              await getApplicationDocumentsDirectory();
          String storagePath = storagePathDirectory.path;
          await File(join(storagePath, '$_year.json')).writeAsString(body);
          SharedPreferences _preferences =
              await SharedPreferences.getInstance();
          _preferences.setBool('firstOrNot', true);
          _preferences.setInt('calendarMode', 0);
          Navigator.of(context).pushReplacement(PageRouteBuilder(
            pageBuilder: (_, animation, __) {
              if (widget.year != null)
                return App(
                  onYear: int.parse(widget.year),
                );
              return App();
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
        } catch (e) {
          setState(() {
            error = 'Downloading error. Try again later.';
          });
        }
      } else {
        setState(() {
          error = 'Downloading error. Try again later.';
        });
      }
    }.call();
    return WillPopScope(
      child: BlocBuilder(
        cubit: LanguageCubit(),
        builder: (context, languageState) {
          return Scaffold(
            backgroundColor: Theme.of(context).primaryColor,
            body: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  error == ''
                      ? Align(
                          child: CircularProgressIndicator(
                            backgroundColor:
                                Theme.of(context).colorScheme.onPrimary,
                          ),
                        )
                      : SizedBox.shrink(),
                  error == ''
                      ? SizedBox(
                          height: 20.0,
                        )
                      : SizedBox.shrink(),
                  error == ''
                      ? Align(
                          child: Text(
                            languageState == 0
                                ? 'Downloading calendar of Year $_year B.S'
                                : '${CustomTimeUtil().englishToNepaliDate(int.parse(_year))} को पात्रो डाउनलोड गर्दै',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                          ),
                        )
                      : SizedBox.shrink(),
                  error != ''
                      ? IconButton(
                          icon: Icon(
                            Icons.refresh,
                            color: Theme.of(context).colorScheme.onPrimary,
                            size: 40.0,
                          ),
                          onPressed: () {
                            setState(() {
                              error = '';
                            });
                          },
                        )
                      : SizedBox.shrink(),
                  error != ''
                      ? SizedBox(
                          height: 20.0,
                        )
                      : SizedBox.shrink(),
                  error != ''
                      ? Align(
                          child: Text(
                            error,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                          ),
                        )
                      : SizedBox.shrink(),
                ],
              ),
            ),
          );
        },
      ),
      onWillPop: () {
        return showDialog(
          context: context,
          child: AlertDialog(
            backgroundColor: Theme.of(context).primaryColor,
            title: Text(
              'Cancle download',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            content: Text(
              'Do you want to cancle downloading the calendar?',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.check,
                  color: Colors.green,
                ),
                onPressed: () {
                  Navigator.pop(context, true);
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.close,
                  color: Theme.of(context).errorColor,
                ),
                onPressed: () {
                  Navigator.pop(context, false);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
