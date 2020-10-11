import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class AboutScreen extends StatelessWidget {
  final int language;

  AboutScreen({
    Key key,
    @required this.language,
  }) : super(key: key);

  final String githubUrl = 'https://github.com/joshisijan';
  String appVersion;
  String appName;
  String appDescription;
  String developerName;

  @override
  Widget build(BuildContext context) {
    appName = language == 0 ? 'Nepali Calendar' : 'नेपाली क्यालेन्डर';
    appVersion = language == 0 ? 'version: 1.0.0+1' : 'संस्करण १.१.१+१';
    appDescription = language == 0
        ? 'Nepali Calendar app provides you with nepali calendar. You can find some tools that might help with loaclization.'
        : 'नेपाली क्यालेन्डर अनुप्रयोग तपाईलाई नेपाली क्यालेन्डर प्रदान गर्दछ। तपाईं केहि उपकरणहरू पाउन सक्नुहुन्छ जुनले लोक्लाइजेशनको लागि मद्दत गर्न सक्छ।';
    developerName =
        language == 0 ? 'Developer: Sijan Joshi' : 'विकासकर्ता: सिजान जोशी';
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).primaryColorDark,
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(20.0),
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Icon(
              Icons.calendar_today,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            appName,
            textAlign: TextAlign.end,
            style: Theme.of(context).textTheme.headline6.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            appVersion,
            textAlign: TextAlign.end,
            style: Theme.of(context).textTheme.caption.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            developerName,
            textAlign: TextAlign.end,
            style: Theme.of(context).textTheme.caption.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
          ),
          TextButton(
            child: Container(
              width: double.maxFinite,
              child: Wrap(
                alignment: WrapAlignment.end,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Icon(Icons.open_in_new,
                      color: Theme.of(context).colorScheme.onPrimary),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    githubUrl,
                    style: Theme.of(context).textTheme.caption.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                  ),
                ],
              ),
            ),
            onPressed: () async {
              if (await canLaunch(githubUrl)) {
                launch(githubUrl);
              }
            },
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            appDescription,
            textAlign: TextAlign.right,
            style: Theme.of(context).textTheme.caption.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
          ),
        ],
      ),
    );
  }
}
