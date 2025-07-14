import 'package:flutter/material.dart';

class OnboardingProvider with ChangeNotifier {
  // PageView controller
  int _currentPage = 0;

  int get currentPage => _currentPage;

  void currentPageIndex(int index) {
    _currentPage = index;
    notifyListeners();
  }

  // Gender selection
  String? _selectedGender;

  String? get selectedGender => _selectedGender;

  void selectGender(String gender) {
    _selectedGender = gender;
    notifyListeners();
  }

  // Birthdate selection
  int _selectedDay = 11;
  int _selectedMonth = 5;
  int _selectedYear = 5;

  int get selectedDay => _selectedDay;

  int get selectedMonth => _selectedMonth;

  int get selectedYear => _selectedYear;

  void setDay(int index) {
    _selectedDay = index;
    notifyListeners();
  }

  void setMonth(int index) {
    _selectedMonth = index;
    notifyListeners();
  }

  void setYear(int index) {
    _selectedYear = index;
    notifyListeners();
  }

  // Height
  int _selectedUnit = 1; // 0 = cm, 1 = ft
  int get selectedUnit => _selectedUnit;

  void setHeightUnit(int unit) {
    _selectedUnit = unit;
    notifyListeners();
  }

  int _selectedFeet = 5;
  int _selectedInch = 6;
  int _selectedCm = 170;

  int get selectedFeet => _selectedFeet;

  int get selectedInch => _selectedInch;

  int get selectedCm => _selectedCm;

  void setFeet(int index) {
    _selectedFeet = index;
    notifyListeners();
  }

  void setInch(int index) {
    _selectedInch = index;
    notifyListeners();
  }

  void setCm(int index) {
    _selectedCm = index;
    notifyListeners();
  }

  // Weight (reuse unit)
  int _selectedWeightKg = 70;
  int _selectedWeightLbs = 154;

  int get selectedWeightKg => _selectedWeightKg;

  int get selectedWeightLbs => _selectedWeightLbs;

  void setWeightKg(int weight) {
    _selectedWeightKg = weight;
    notifyListeners();
  }

  void setWeightLbs(int weight) {
    _selectedWeightLbs = weight;
    notifyListeners();
  }

  // Target weight
  int _selectedTargetWeightKg = 65;
  int _selectedTargetWeightLbs = 145;

  int get selectedTargetWeightKg => _selectedTargetWeightKg;

  int get selectedTargetWeightLbs => _selectedTargetWeightLbs;

  void setTargetWeightKg(int weight) {
    _selectedTargetWeightKg = weight;
    notifyListeners();
  }

  void setTargetWeightLbs(int weight) {
    _selectedTargetWeightLbs = weight;
    notifyListeners();
  }

  // Goal
  String _selectedGoal = 'Keep Fit';

  String get selectedGoal => _selectedGoal;

  void setGoal(String goal) {
    _selectedGoal = goal;
    notifyListeners();
  }

  // Activity Level
  String _selectedLevel = 'Beginner';

  String get selectedLevel => _selectedLevel;

  void setActivityLevel(String level) {
    _selectedLevel = level;
    notifyListeners();
  }

  // Diet
  String _selectedDiet = 'Vegetarian';

  String get selectedDiet => _selectedDiet;

  void setDiet(String diet) {
    _selectedDiet = diet;
    notifyListeners();
  }
}
