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

  //goal section
  String selectedGoal = 'Keep Fit';

  final List<String> goals = ['Lose Weight', 'Gain Muscle', 'Keep Fit'];

  //activity level section
  String selectedLevel = 'Beginner';

  final List<String> levels = ['Beginner', 'Intermediate', 'Advance'];

  //diet section
  String selectedDiet = 'Vegetarian';

  final List<String> diets = ['All-food diet', 'Vegetarian', 'Vegan', 'Keto'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                  _buildWeightSection(),
                  _buildHeightSection(),
                  _buildTargetWeightSection(),
                  _buildGoalSection(),
                  _buildActivityLevelSection(),
                  _buildDietSection(),
                ],
              ),
            ),
            _buildNavigationBar(),
          ],
        ),
      ),
    );
  }

  //gender section

  Widget _buildGenderSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(
            'Which gender do you \n identify as?',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 80),
          Center(
            child: Column(
              children: [
                Column(
                  children: [
                    SvgPicture.asset(
                      'assets/male.svg',
                      width: 100,
                      height: 100,
                    ),
                    Text('Male', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 50),
                Column(
                  children: [
                    SvgPicture.asset(
                      'assets/female.svg',
                      width: 100,
                      height: 100,
                    ),
                    Text(
                      'Female',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //birthdate section

  Widget _buildBirthdateSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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

  //height section

  Widget _buildHeightSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                      _heightUnitLabel("Ft"),
                      _buildHeightPicker(
                        items: inchList.map((e) => e.toString()).toList(),
                        selectedItem: selectedInch,
                        onSelected:
                            (index) =>
                                setState(() => selectedInch = inchList[index]),
                      ),
                      _heightUnitLabel("In"),
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
                      _heightUnitLabel("Cm"),
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

  Widget _heightUnitLabel(String text) {
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

  //weightSection

  Widget _buildWeightSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "What's your Weight?",
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
                      _buildWeightPicker(
                        items: feetList.map((e) => e.toString()).toList(),
                        selectedItem: selectedFeet - 1,
                        onSelected:
                            (index) =>
                                setState(() => selectedFeet = feetList[index]),
                      ),
                      _weightUnitLabel("Lbs"),
                    ],
                  )
                else
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildWeightPicker(
                        items: cmList.map((e) => e.toString()).toList(),
                        selectedItem: selectedCm - 50,
                        onSelected:
                            (index) =>
                                setState(() => selectedCm = cmList[index]),
                      ),
                      _weightUnitLabel("Kg"),
                    ],
                  ),

                const SizedBox(height: 30),

                // Toggle switch
                CupertinoSegmentedControl<int>(
                  padding: EdgeInsets.symmetric(horizontal: 80, vertical: 4),
                  children: {
                    0: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Text("Kg", style: TextStyle(fontSize: 16)),
                    ),
                    1: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18),
                      child: Text("Lbs", style: TextStyle(fontSize: 16)),
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

  Widget _buildWeightPicker({
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

  Widget _weightUnitLabel(String text) {
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

  //target weight section

  Widget _buildTargetWeightSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "What's your Target\n  Weight?",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (selectedUnit == 1)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildTargetWeightPicker(
                        items: feetList.map((e) => e.toString()).toList(),
                        selectedItem: selectedFeet - 1,
                        onSelected:
                            (index) =>
                                setState(() => selectedFeet = feetList[index]),
                      ),
                      _targetWeightUnitLabel("Lbs"),
                    ],
                  )
                else
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildTargetWeightPicker(
                        items: cmList.map((e) => e.toString()).toList(),
                        selectedItem: selectedCm - 50,
                        onSelected:
                            (index) =>
                                setState(() => selectedCm = cmList[index]),
                      ),
                      _targetWeightUnitLabel("Kg"),
                    ],
                  ),

                const SizedBox(height: 30),

                // Toggle switch
                CupertinoSegmentedControl<int>(
                  padding: EdgeInsets.symmetric(horizontal: 80, vertical: 4),
                  children: {
                    0: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Text("Kg", style: TextStyle(fontSize: 16)),
                    ),
                    1: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18),
                      child: Text("Lbs", style: TextStyle(fontSize: 16)),
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

  Widget _buildTargetWeightPicker({
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

  Widget _targetWeightUnitLabel(String text) {
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

  //activity level section

  Widget _buildActivityLevelSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "What’s your Physical\nActivity Level?",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 50),
          ...levels.map((level) => _buildActivityLevelOption(level)).toList(),
        ],
      ),
    );
  }

  Widget _buildActivityLevelOption(String level) {
    final isSelected = selectedLevel == level;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedLevel = level;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.deepPurpleAccent : Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: Text(
          level,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  //goal section

  Widget _buildGoalSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "What’s your Goal?",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 80),
          ...goals.map((goal) => _buildGoalOption(goal)).toList(),
        ],
      ),
    );
  }

  Widget _buildGoalOption(String goal) {
    final isSelected = selectedGoal == goal;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedGoal = goal;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.deepPurpleAccent : Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: Text(
          goal,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  //diet section

  Widget _buildDietSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Which diet do you \n prefer?",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 50),
          ...diets.map((diet) => _buildDietOption(diet)).toList(),
        ],
      ),
    );
  }

  Widget _buildDietOption(String diet) {
    final isSelected = selectedDiet == diet;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedDiet = diet;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.deepPurpleAccent : Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: Text(
          diet,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  //navigation section

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
              8,
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
          _currentPage < 8
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
