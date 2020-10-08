import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nepali_calendar/src/app.dart';
import 'package:nepali_calendar/src/models/time_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class DownloadingFileWidget extends StatefulWidget {
  final String year;

  const DownloadingFileWidget({Key key, this.year}) : super(key: key);

  @override
  _DownloadingFileWidgetState createState() => _DownloadingFileWidgetState();
}

class _DownloadingFileWidgetState extends State<DownloadingFileWidget> {
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
                      backgroundColor: Theme.of(context).colorScheme.onPrimary,
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
                      'Downloading Asset (Year $_year B.S)',
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
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
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                    ),
                  )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
