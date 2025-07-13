import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ionicons/ionicons.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final _formKey = GlobalKey<FormState>();

  List<String> days = List.generate(
    31,
    (index) => (index + 1).toString().padLeft(2, '0'),
  );
  List<String> months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];
  List<String> years = List.generate(40, (index) => (1985 + index).toString());

  int selectedDay = 0;
  int selectedMonth = 0;
  int selectedYear = 5;

  // Unit selection: 0 = cm, 1 = ft
  int selectedUnit = 1;

  final List<int> feetList = List.generate(9, (index) => index + 1); // 1 to 9
  final List<int> inchList = List.generate(11, (index) => index); // 0 to 10
  final List<int> cmList = List.generate(
    151,
    (index) => index + 50,
  ); // 50 to 200

  int selectedFeet = 5;
  int selectedInch = 6;
  int selectedCm = 170;

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
                  _buildBirthdateSection(),
                  _buildHeightSection(),
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
          SizedBox(height: 80),
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50),
      child: Column(
        children: [
          Text(
            "What's your Birthdate ?",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 80),
          Center(
            child: SizedBox(
              height: 450,
              child: Row(
                children: [
                  // Day Picker
                  Expanded(
                    child: _buildPicker(days, selectedDay, (index) {
                      setState(() {
                        selectedDay = index;
                      });
                    }),
                  ),
                  // Month Picker
                  Expanded(
                    child: _buildPicker(months, selectedMonth, (index) {
                      setState(() {
                        selectedMonth = index;
                      });
                    }),
                  ),
                  // Year Picker
                  Expanded(
                    child: _buildPicker(years, selectedYear, (index) {
                      setState(() {
                        selectedYear = index;
                      });
                    }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPicker(
    List<String> items,
    int selectedItem,
    Function(int) onSelectedItemChanged,
  ) {
    return CupertinoPicker(
      scrollController: FixedExtentScrollController(initialItem: selectedItem),
      itemExtent: 40,
      magnification: 1.1,
      useMagnifier: true,
      onSelectedItemChanged: onSelectedItemChanged,
      children: List<Widget>.generate(items.length, (index) {
        final isSelected = index == selectedItem;
        return Center(
          child: Text(
            items[index],
            style: TextStyle(
              fontSize: 18,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color:
                  isSelected
                      ? CupertinoColors.activeBlue
                      : CupertinoColors.black,
            ),
          ),
        );
      }),
    );
  }

  Widget _buildHeightSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50),
      child: Column(
        children: [
          Text(
            "What's your Height?",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 80),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (selectedUnit == 1)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildHeightPicker(
                        items: feetList.map((e) => e.toString()).toList(),
                        selectedItem: selectedFeet - 1,
                        onSelected:
                            (index) =>
                                setState(() => selectedFeet = feetList[index]),
                      ),
                      _unitLabel("Ft"),
                      _buildHeightPicker(
                        items: inchList.map((e) => e.toString()).toList(),
                        selectedItem: selectedInch,
                        onSelected:
                            (index) =>
                                setState(() => selectedInch = inchList[index]),
                      ),
                      _unitLabel("In"),
                    ],
                  )
                else
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildHeightPicker(
                        items: cmList.map((e) => e.toString()).toList(),
                        selectedItem: selectedCm - 50,
                        onSelected:
                            (index) =>
                                setState(() => selectedCm = cmList[index]),
                      ),
                      _unitLabel("Cm"),
                    ],
                  ),

                const SizedBox(height: 30),

                // Toggle switch
                CupertinoSegmentedControl<int>(
                  padding: EdgeInsets.symmetric(horizontal: 80, vertical: 4),
                  children: {
                    0: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Text("Cm", style: TextStyle(fontSize: 16)),
                    ),
                    1: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18),
                      child: Text("Ft", style: TextStyle(fontSize: 16)),
                    ),
                  },
                  groupValue: selectedUnit,
                  onValueChanged: (value) {
                    setState(() => selectedUnit = value);
                  },
                  selectedColor: CupertinoColors.activeBlue,
                  unselectedColor: CupertinoColors.white,
                  borderColor: CupertinoColors.activeBlue,
                  pressedColor: CupertinoColors.systemGrey4,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeightPicker({
    required List<String> items,
    required int selectedItem,
    required Function(int) onSelected,
  }) {
    return SizedBox(
      width: 80,
      height: 450,
      child: CupertinoPicker(
        scrollController: FixedExtentScrollController(
          initialItem: selectedItem,
        ),
        itemExtent: 40,
        useMagnifier: true,
        magnification: 1.2,
        onSelectedItemChanged: onSelected,
        children: List.generate(items.length, (index) {
          final isSelected = index == selectedItem;
          return Center(
            child: Text(
              items[index],
              style: TextStyle(
                fontSize: 18,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color:
                    isSelected
                        ? CupertinoColors.activeBlue
                        : CupertinoColors.black,
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _unitLabel(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          color: CupertinoColors.activeBlue,
          fontWeight: FontWeight.w600,
        ),
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
