import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DaysDate extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onDaySelected;
  const DaysDate(
      {super.key, required this.selectedIndex, required this.onDaySelected});

  @override
  Widget build(BuildContext context) {
    List<DateTime> days = List.generate(30, (index) {
      return DateTime.now().add(Duration(days: index));
    });

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
          children: List.generate(days.length, (index) {
        final day = days[index];
        final dayName = DateFormat('E').format(day);
        final dayNumber = day.day;

        bool isSelected = index == selectedIndex;

        return GestureDetector(
          onTap: () => onDaySelected(index),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 6),
            child: Column(
              children: [
                Text(
                  dayName,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: isSelected ? Colors.amber : Colors.black,
                  ),
                ),
                SizedBox(
                  height: 4.0,
                ),
                CircleAvatar(
                  radius: 14.0,
                  backgroundColor:
                      isSelected ? Colors.amber : Colors.grey.shade300,
                  child: Text(
                    '$dayNumber',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      })),
    );
  }
}
