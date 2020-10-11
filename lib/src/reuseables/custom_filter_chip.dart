import 'package:flutter/material.dart';

class CustomFilterChip extends StatelessWidget {
  final String label;
  final Function onSelected;
  final bool selected;

  const CustomFilterChip({
    Key key,
    @required this.label,
    @required this.onSelected,
    this.selected = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: FilterChip(
        selectedColor: Theme.of(context).colorScheme.secondary,
        checkmarkColor: Theme.of(context).colorScheme.onPrimary,
        selected: selected,
        backgroundColor: Theme.of(context).primaryColorLight,
        label: Text(
          label,
          style: Theme.of(context).textTheme.overline.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
        ),
        onSelected: onSelected,
      ),
    );
  }
}
