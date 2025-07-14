import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:onboarding_app/providers/onboarding_provider.dart';
import 'package:provider/provider.dart';

class OnboardingScreen extends StatefulWidget {
  static const activeColor = Color(0Xff6c63ff);

  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  // int _currentPage = 0;
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

  final List<int> kgList = List.generate(610, (index) => index + 30);
  final List<int> lbsList = List.generate(1340, (index) => index + 66);

  final List<int> feetList = List.generate(9, (index) => index + 1); // 1 to 9
  final List<int> inchList = List.generate(11, (index) => index); // 0 to 10
  final List<int> cmList = List.generate(
    250,
    (index) => index + 50,
  ); // 50 to 200

  final List<String> goals = ['Lose Weight', 'Gain Muscle', 'Keep Fit'];

  final List<String> levels = ['Beginner', 'Intermediate', 'Advance'];

  final List<String> diets = ['All-food diet', 'Vegetarian', 'Vegan', 'Keto'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Consumer<OnboardingProvider>(
          builder: (context, provider, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (index) => provider.currentPageIndex(index),
                    children: [
                      _buildGenderSection(provider),
                      _buildBirthdateSection(provider),
                      _buildWeightSection(provider),
                      _buildHeightSection(provider),
                      _buildTargetWeightSection(provider),
                      _buildGoalSection(provider),
                      _buildActivityLevelSection(provider),
                      _buildDietSection(provider),
                    ],
                  ),
                ),
                _buildNavigationBar(
                  formKey: _formKey,
                  context,
                  _pageController,
                  provider,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  //gender section

  Widget _buildGenderSection(OnboardingProvider provider) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Which gender do you identify as?",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 80),
          Center(
            child: Column(
              children: [
                _buildGenderOption(provider, "Male", "assets/male.png"),
                const SizedBox(height: 24),
                _buildGenderOption(provider, "Female", "assets/female.png"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGenderOption(
    OnboardingProvider provider,
    String gender,
    String imagePath,
  ) {
    final isSelected = provider.selectedGender == gender;
    return GestureDetector(
      onTap: () => provider.selectGender(gender),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color:
                    isSelected
                        ? OnboardingScreen.activeColor
                        : Colors.grey.shade300,
                width: 2,
              ),
            ),
            child: CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(imagePath),
              backgroundColor: Colors.transparent,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            gender,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: isSelected ? OnboardingScreen.activeColor : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  //birthdate section

  Widget _buildBirthdateSection(OnboardingProvider provider) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
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
                      child: _buildPicker(
                        days,
                        provider.selectedDay,
                        provider.setDay,
                      ),
                    ),
                    // Month Picker
                    Expanded(
                      child: _buildPicker(
                        months,
                        provider.selectedMonth,
                        provider.setMonth,
                      ),
                    ),
                    // Year Picker
                    Expanded(
                      child: _buildPicker(
                        years,
                        provider.selectedYear,
                        provider.setYear,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
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
                      ? OnboardingScreen.activeColor
                      : CupertinoColors.black,
            ),
          ),
        );
      }),
    );
  }

  //height section

  Widget _buildHeightSection(OnboardingProvider provider) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
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
                  if (provider.selectedUnit == 1)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildHeightPicker(
                          items: feetList.map((e) => e.toString()).toList(),
                          selectedItem: provider.selectedFeet ,
                          onSelected: (index) => provider.setFeet(index),
                        ),
                        _heightUnitLabel("Ft"),
                        _buildHeightPicker(
                          items: inchList.map((e) => e.toString()).toList(),
                          selectedItem: provider.selectedInch,
                          onSelected: (index) => provider.setInch(index),
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
                          selectedItem: provider.selectedCm ,
                          onSelected: (index) => provider.setCm(index),
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
                    groupValue: provider.selectedUnit,
                    onValueChanged: (value) {
                      provider.setHeightUnit(value);
                    },
                    selectedColor: OnboardingScreen.activeColor,
                    unselectedColor: CupertinoColors.white,
                    borderColor: OnboardingScreen.activeColor,
                    pressedColor: CupertinoColors.systemGrey4,
                  ),
                ],
              ),
            ),
          ],
        ),
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
      height: MediaQuery.of(context).size.height * 0.5,
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
                        ? OnboardingScreen.activeColor
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
          color: OnboardingScreen.activeColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  //weight Section

  Widget _buildWeightSection(OnboardingProvider provider) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
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
                  if (provider.selectedUnit == 1)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildWeightPicker(
                          items: lbsList.map((e) => e.toString()).toList(),
                          selectedItem: provider.selectedWeightLbs ,
                          onSelected: (index) => provider.setWeightLbs(index),
                        ),
                        _weightUnitLabel("Lbs"),
                      ],
                    )
                  else
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildWeightPicker(
                          items: kgList.map((e) => e.toString()).toList(),
                          selectedItem: provider.selectedWeightKg ,
                          onSelected: (index) => provider.setWeightKg(index),
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
                    groupValue: provider.selectedUnit,
                    onValueChanged: (value) {
                      provider.setHeightUnit(value);
                    },
                    selectedColor: OnboardingScreen.activeColor,
                    unselectedColor: CupertinoColors.white,
                    borderColor: OnboardingScreen.activeColor,
                    pressedColor: CupertinoColors.systemGrey4,
                  ),
                ],
              ),
            ),
          ],
        ),
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
      height: MediaQuery.of(context).size.height * 0.5,
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
                        ? OnboardingScreen.activeColor
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
          color: OnboardingScreen.activeColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  //target weight section

  Widget _buildTargetWeightSection(OnboardingProvider provider) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "What's your Target\nWeight?",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 50),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (provider.selectedUnit == 1)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildTargetWeightPicker(
                          items: lbsList.map((e) => e.toString()).toList(),
                          selectedItem: provider.selectedTargetWeightLbs ,
                          onSelected:
                              (index) => provider.setTargetWeightLbs(index),
                        ),
                        _targetWeightUnitLabel("Lbs"),
                      ],
                    )
                  else
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildTargetWeightPicker(
                          items: kgList.map((e) => e.toString()).toList(),
                          selectedItem: provider.selectedTargetWeightKg ,
                          onSelected:
                              (index) => provider.setTargetWeightKg(index),
                        ),
                        _targetWeightUnitLabel("Kg"),
                      ],
                    ),

                  const SizedBox(height: 25),

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
                    groupValue: provider.selectedUnit,
                    onValueChanged: (value) {
                      provider.setHeightUnit(value);
                    },
                    selectedColor: OnboardingScreen.activeColor,
                    unselectedColor: CupertinoColors.white,
                    borderColor: OnboardingScreen.activeColor,
                    pressedColor: CupertinoColors.systemGrey4,
                  ),
                ],
              ),
            ),
          ],
        ),
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
      height: MediaQuery.of(context).size.height * 0.5,
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
                        ? OnboardingScreen.activeColor
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
          color: OnboardingScreen.activeColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  //activity level section

  Widget _buildActivityLevelSection(OnboardingProvider provider) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "What’s your Physical\nActivity Level?",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 50),
          ...levels
              .map((level) => _buildActivityLevelOption(level, provider))
              .toList(),
        ],
      ),
    );
  }

  Widget _buildActivityLevelOption(String level, OnboardingProvider provider) {
    final isSelected = provider.selectedLevel == level;

    return GestureDetector(
      onTap: () => provider.setActivityLevel(level),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? OnboardingScreen.activeColor : Colors.white,
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

  Widget _buildGoalSection(OnboardingProvider provider) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "What’s your Goal?",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 85),
          ...goals.map((goal) => _buildGoalOption(goal, provider)).toList(),
        ],
      ),
    );
  }

  Widget _buildGoalOption(String goal, OnboardingProvider provider) {
    final isSelected = provider.selectedGoal == goal;

    return GestureDetector(
      onTap: () => provider.setGoal(goal),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? OnboardingScreen.activeColor : Colors.white,
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

  Widget _buildDietSection(OnboardingProvider provider) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Which diet do you \n prefer?",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 50),
          ...diets.map((diet) => _buildDietOption(diet, provider)).toList(),
        ],
      ),
    );
  }

  Widget _buildDietOption(String diet, OnboardingProvider provider) {
    final isSelected = provider.selectedDiet == diet;

    return GestureDetector(
      onTap: () => provider.setDiet(diet),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? OnboardingScreen.activeColor : Colors.white,
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

  Widget _buildNavigationBar(
    BuildContext context,
    PageController controller,
    OnboardingProvider provider, {
    GlobalKey<FormState>? formKey,
    int totalPages = 8,
  }) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            provider.currentPage > 0
                ? TextButton(
                  onPressed: () {
                    controller.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: const Text(
                    'Back',
                    style: TextStyle(color: OnboardingScreen.activeColor),
                  ),
                )
                : const SizedBox(),

            // Dots indicator
            Row(
              children: List.generate(
                totalPages,
                (index) => Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        provider.currentPage == index
                            ? OnboardingScreen.activeColor
                            : Colors.grey[300],
                  ),
                ),
              ),
            ),

            // Next button or Get Started
            provider.currentPage < totalPages - 1
                ? IconButton(
                  style: IconButton.styleFrom(
                    backgroundColor: OnboardingScreen.activeColor,
                  ),
                  onPressed: () {
                    // if (provider.currentPage == 1 &&
                    //     formKey != null &&
                    //     !formKey.currentState!.validate()) {
                    //   return;
                    // }
                    controller.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  icon: const Icon(Ionicons.arrow_forward, color: Colors.white),
                )
                : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: OnboardingScreen.activeColor,
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Get Started',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
