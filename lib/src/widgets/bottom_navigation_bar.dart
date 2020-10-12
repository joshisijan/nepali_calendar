import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nepali_calendar/src/cubit/bottom_menu_cubit.dart';
import 'package:nepali_calendar/src/cubit/language_cubit.dart';
import 'package:nepali_calendar/src/screens/tools.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomMenuCubit, bool>(
      builder: (context, bottomMenuState) {
        return BlocBuilder<LanguageCubit, int>(
          builder: (context, languageState) {
            return BottomAppBar(
              elevation: bottomMenuState ? 0.0 : 5.0,
              color: Theme.of(context).primaryColor,
              shape: bottomMenuState ? null : CircularNotchedRectangle(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AnimatedCrossFade(
                    crossFadeState: bottomMenuState
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    duration: Duration(milliseconds: 350),
                    firstChild: FlatButton.icon(
                      label: Text(
                        languageState == 0 ? 'Menu' : 'मेनू',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                      icon: Icon(
                        Icons.menu,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      onPressed: () {
                        context.bloc<BottomMenuCubit>().toggleMenu();
                      },
                    ),
                    secondChild: FlatButton.icon(
                      label: Text(
                        languageState == 0 ? 'Close' : 'बन्द गर्नुहोस्',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                      icon: Icon(
                        Icons.close,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      onPressed: () {
                        context.bloc<BottomMenuCubit>().toggleMenu();
                      },
                    ),
                  ),
                  AnimatedOpacity(
                    opacity: bottomMenuState ? 0.0 : 1.0,
                    duration: Duration(milliseconds: 350),
                    child: AbsorbPointer(
                      absorbing: bottomMenuState,
                      child: FlatButton.icon(
                        label: Text(
                          languageState == 0 ? 'Tools' : 'उपकरणहरू',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                        icon: Icon(
                          Icons.construction,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(PageRouteBuilder(
                            pageBuilder: (_, animation, __) {
                              return ToolsScreen();
                            },
                            transitionDuration: Duration(milliseconds: 350),
                            transitionsBuilder: (_, animation, __, child) {
                              animation = CurvedAnimation(
                                curve: Curves.decelerate,
                                parent: animation,
                              );
                              return SlideTransition(
                                position: Tween(
                                  begin: Offset(0.0, 1.0),
                                  end: Offset(0.0, 0.0),
                                ).animate(animation),
                                child: child,
                              );
                            },
                          ));
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
