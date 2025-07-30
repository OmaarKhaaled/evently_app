import 'package:evently_app/app_theme.dart';
import 'package:flutter/material.dart';

class TabItem extends StatelessWidget {
  bool isSelected;
  IconData icon;
  String label;
  Color selectedForeGroundColor;
  Color unselectedForeGroundColor;
  Color selectedBackGroundColor;

  TabItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.selectedForeGroundColor,
    required this.unselectedForeGroundColor,
    required this.selectedBackGroundColor,
  });
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: isSelected ? selectedBackGroundColor : Colors.transparent,
        borderRadius: BorderRadius.circular(46),
        border: isSelected ? null : Border.all(color: AppTheme.primary),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 24,
            color: isSelected
                ? selectedForeGroundColor
                : unselectedForeGroundColor,
          ),
          SizedBox(width: 8),
          Text(
            label,
            style: textTheme.titleMedium!.copyWith(
              color: isSelected
                  ? selectedForeGroundColor
                  : unselectedForeGroundColor,
            ),
          ),
        ],
      ),
    );
  }
}
