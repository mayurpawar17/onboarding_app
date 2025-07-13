import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ionicons/ionicons.dart';

import 'date_picker.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                children: [
                  _buildGenderSection(),
                  DatePickerExample(),
                  _buildGenderSection(),
                ],
              ),
            ),
            _buildNavigationBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildGenderSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50),
      child: Column(
        children: [
          Text(
            'Which gender do you \n identify as?',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 60),
          Column(
            children: [
              SvgPicture.asset('assets/male.svg', width: 100, height: 100),
              Text('Male', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: 50),
          Column(
            children: [
              SvgPicture.asset('assets/female.svg', width: 100, height: 100),
              Text('Female', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBirthdateSection() {
    int selectedDay = 3; // Index for "01" (January)
    int selectedMonth = 3; // Index for "January"
    int selectedYear = 3; // Index for "1990"

    List<String> days = ['29', '30', '31', '01', '02', '03', '04'];

    List<String> months = [
      'October',
      'November',
      'December',
      'January',
      'February',
      'March',
      'April',
    ];

    List<String> years = [
      '1987',
      '1988',
      '1989',
      '1990',
      '1991',
      '1992',
      '1993',
    ];
    double value = 0.0;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50),
      child: Column(
        children: [
          Text(
            "What's your Birthdate ?",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 60),
          Center(
            child: Container(
              height: 200,
              child: Row(
                children: [
                 Text('hello')
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationBar() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // _currentPage > 0
          //     ? TextButton(
          //       onPressed: () {
          //         _pageController.previousPage(
          //           duration: Duration(milliseconds: 300),
          //           curve: Curves.easeInOut,
          //         );
          //       },
          //       child: Text('Back'),
          //     )
          //     : SizedBox(),
          Row(
            children: List.generate(
              5,
              (index) => Container(
                width: 8,
                height: 8,
                margin: EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      _currentPage == index
                          ? Theme.of(context).primaryColor
                          : Colors.grey[300],
                ),
              ),
            ),
          ),
          _currentPage < 4
              ? IconButton(
                style: IconButton.styleFrom(
                  backgroundColor: Colors.deepPurpleAccent,
                ),
                onPressed: () {
                  if (_currentPage == 1 && !_formKey.currentState!.validate()) {
                    return;
                  }
                  _pageController.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                icon: Icon(Ionicons.arrow_forward, color: Colors.white),
              )
              : ElevatedButton(
                onPressed: null,

                // onPressed: _completeOnboarding,
                child: Text('Get Started'),
              ),
        ],
      ),
    );
  }
}
