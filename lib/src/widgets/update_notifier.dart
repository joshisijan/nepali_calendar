import 'package:flutter/material.dart';
import 'package:nepali_calendar/src/screens/downloading_widget.dart';
import 'package:nepali_calendar/src/services/time_util.dart';

class CustomUpdateNotifier extends StatelessWidget {
  final String year;
  final int languageState;
  const CustomUpdateNotifier({
    Key key,
    @required this.year,
    @required this.languageState,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            color: Theme.of(context).primaryColor.withAlpha(150),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          color: Theme.of(context).colorScheme.surface,
          height: 220.0,
          child: Column(
            children: [
              SizedBox(
                height: 40.0,
              ),
              Text(
                languageState == 0
                    ? 'Update Available (year $year)'
                    : 'अपडेट उपलब्ध छ (बर्ष $year)',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 16.0,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                languageState == 0
                    ? 'There is update available for year $year. New events are added. Update now. It won\'t take more than a minute.'
                    : 'बर्ष $year को लागि अपडेट उपलब्ध छ। नयाँ कुराहरू थपिएको छ। अपडेट गर्नुहोस्। १ मिनेट भन्दा बढि लिने छैन।',
                style: Theme.of(context).textTheme.caption.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: languageState == 0
                          ? Theme.of(context).textTheme.caption.fontSize
                          : Theme.of(context).textTheme.caption.fontSize + 1,
                    ),
              ),
              SizedBox(
                height: 10.0,
              ),
              FlatButton.icon(
                color: Theme.of(context).buttonColor,
                icon: Icon(
                  Icons.system_update_alt,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                label: Text(
                  languageState == 0 ? 'Update' : 'अपडेट',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (_, animation, __) {
                        return DownloadingFileWidget(
                          year: languageState == 0
                              ? year
                              : CustomTimeUtil()
                                  .nepaliToEnglishDate(year)
                                  .toString(),
                        );
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
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
