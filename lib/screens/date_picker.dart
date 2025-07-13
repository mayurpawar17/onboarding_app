import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DatePickerExample extends StatefulWidget {
  @override
  _DatePickerExampleState createState() => _DatePickerExampleState();
}

class _DatePickerExampleState extends State<DatePickerExample> {
  int selectedDay = 3; // Index for "01" (January)
  int selectedMonth = 3; // Index for "January"
  int selectedYear = 3; // Index for "1990"

  List<String> days = [
    '29', '30', '31', '01', '02', '03', '04'
  ];

  List<String> months = [
    'October', 'November', 'December', 'January', 'February', 'March', 'April'
  ];

  List<String> years = [
    '1987', '1988', '1989', '1990', '1991', '1992', '1993'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Cupertino Date Picker'),
        backgroundColor: Colors.grey[200],
      ),
      body: Center(
        child: Container(
          height: 200,
          child: Row(
            children: [
              // Day picker
              Expanded(
                child: CupertinoPicker(
                  scrollController: FixedExtentScrollController(
                    initialItem: selectedDay,
                  ),
                  itemExtent: 32.0,
                  onSelectedItemChanged: (int index) {
                    setState(() {
                      selectedDay = index;
                    });
                  },
                  children: days.map((day) {
                    int index = days.indexOf(day);
                    bool isSelected = index == selectedDay;

                    return Container(
                      alignment: Alignment.center,
                      child: Text(
                        day,
                        style: TextStyle(
                          fontSize: 18,
                          color: isSelected ? CupertinoColors.activeBlue : Colors.grey,
                          fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              // Month picker
              Expanded(
                flex: 2,
                child: CupertinoPicker(
                  scrollController: FixedExtentScrollController(
                    initialItem: selectedMonth,
                  ),
                  itemExtent: 32.0,
                  onSelectedItemChanged: (int index) {
                    setState(() {
                      selectedMonth = index;
                    });
                  },
                  children: months.map((month) {
                    int index = months.indexOf(month);
                    bool isSelected = index == selectedMonth;

                    return Container(
                      alignment: Alignment.center,
                      child: Text(
                        month,
                        style: TextStyle(
                          fontSize: 18,
                          color: isSelected ? CupertinoColors.activeBlue : Colors.grey,
                          fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              // Year picker
              Expanded(
                child: CupertinoPicker(
                  scrollController: FixedExtentScrollController(
                    initialItem: selectedYear,
                  ),
                  itemExtent: 32.0,
                  onSelectedItemChanged: (int index) {
                    setState(() {
                      selectedYear = index;
                    });
                  },
                  children: years.map((year) {
                    int index = years.indexOf(year);
                    bool isSelected = index == selectedYear;

                    return Container(
                      alignment: Alignment.center,
                      child: Text(
                        year,
                        style: TextStyle(
                          fontSize: 18,
                          color: isSelected ? CupertinoColors.activeBlue : Colors.grey,
                          fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

