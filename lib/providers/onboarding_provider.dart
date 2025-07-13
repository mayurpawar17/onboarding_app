import 'package:flutter/cupertino.dart';

class OnboardingProvider extends ChangeNotifier {
  //page view

  int _currentPage = 0;

  int get currentPage => _currentPage;

  void currentPageIndex(int index) {
    _currentPage = index;
    notifyListeners();
  }

  //select section
  String? _selectedGender;

  String? get selectedGender => _selectedGender;

  void selectGender(String gender) {
    _selectedGender = gender;
    notifyListeners();
  }

  //
}
