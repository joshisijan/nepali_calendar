import 'package:flutter/material.dart';
import 'package:nepali_calendar/src/reuseables/dot.dart';
import 'package:nepali_calendar/src/reuseables/flat_icon_button.dart';
import 'package:nepali_calendar/src/screens/downloading_widget.dart';
import 'package:nepali_calendar/src/widgets/first_starting_1.dart';
import 'package:nepali_calendar/src/widgets/first_starting_2.dart';
import 'package:nepali_calendar/src/widgets/first_starting_3.dart';

class FirstWidget extends StatefulWidget {
  @override
  _FirstWidgetState createState() => _FirstWidgetState();
}

class _FirstWidgetState extends State<FirstWidget> {
  PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: 0,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  int _activePage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      body: PageView(
        controller: _pageController,
        onPageChanged: (value) {
          setState(() {
            _activePage = value;
          });
        },
        children: [
          FirstWidget1(),
          FirstWidget2(),
          FirstWidget3(),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).primaryColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlatIconButton(
                firstChild: AnimatedOpacity(
                  opacity: _activePage == 0 ? 0.6 : 1.0,
                  duration: Duration(milliseconds: 350),
                  child: Icon(Icons.arrow_back_ios,
                      color: Theme.of(context).colorScheme.onPrimary),
                ),
                secondChild: AnimatedOpacity(
                  opacity: _activePage == 0 ? 0.6 : 1.0,
                  duration: Duration(milliseconds: 350),
                  child: Text(
                    'Previous',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary),
                  ),
                ),
                onPressed: _activePage != 0
                    ? () {
                        _pageController.animateToPage(
                            _pageController.page.toInt() - 1,
                            duration: Duration(milliseconds: 350),
                            curve: Curves.decelerate);
                      }
                    : null,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(3, (index) {
                      return CustomDot(
                        active: _activePage == index ? true : false,
                      );
                    }),
                  ),
                ),
              ),
              FlatIconButton(
                firstChild: AnimatedCrossFade(
                  duration: Duration(milliseconds: 350),
                  crossFadeState: _activePage == 2
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  firstChild: Text(
                    'Next',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  secondChild: Text(
                    'Continue',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
                secondChild: AnimatedCrossFade(
                  duration: Duration(milliseconds: 350),
                  crossFadeState: _activePage == 2
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  firstChild: Icon(
                    Icons.arrow_forward_ios,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  secondChild: Icon(
                    Icons.check,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                onPressed: () {
                  if (_activePage < 2) {
                    _pageController.animateToPage(
                        _pageController.page.toInt() + 1,
                        duration: Duration(milliseconds: 350),
                        curve: Curves.decelerate);
                  } else {
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
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
