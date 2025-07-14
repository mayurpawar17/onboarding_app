// import 'package:flutter/material.dart';
//
// class HomeScreen extends StatelessWidget {
//   final String? gender;
//   final String birthdate;
//   final int weight;
//   final int targetWeight;
//   final String height;
//   final String goal;
//   final String activityLevel;
//   final String diet;
//
//   const HomeScreen({
//     super.key,
//     required this.gender,
//     required this.birthdate,
//     required this.weight,
//     required this.targetWeight,
//     required this.height,
//     required this.goal,
//     required this.activityLevel,
//     required this.diet,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF7F8FC),
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//         elevation: 0,
//         title: const Text(
//           "Your Fitness Summary",
//           style: TextStyle(fontWeight: FontWeight.w600),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             _buildInfoCard("Gender", gender ?? "Not set"),
//             _buildInfoCard("Birthdate", birthdate),
//             _buildInfoCard("Weight", "$weight"),
//             _buildInfoCard("Target Weight", "$targetWeight"),
//             _buildInfoCard("Height", height),
//             _buildInfoCard("Goal", goal),
//             _buildInfoCard("Activity Level", activityLevel),
//             _buildInfoCard("Diet", diet),
//             const Spacer(),
//             ElevatedButton(
//               onPressed: () {
//                 // continue to dashboard or another screen
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.black,
//                 padding: const EdgeInsets.symmetric(vertical: 16),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//               child: const Text(
//                 "Continue",
//                 style: TextStyle(
//                   fontSize: 16,
//                   letterSpacing: 0.5,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildInfoCard(String title, String value) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(14),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black12,
//             blurRadius: 6,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             title,
//             style: const TextStyle(
//               color: Colors.black87,
//               fontSize: 15,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           Text(
//             value,
//             style: const TextStyle(
//               color: Colors.black,
//               fontSize: 15,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  final String? gender;
  final String? birthdate;
  final int? weight;
  final int? targetWeight;
  final String? height;
  final String? goal;
  final String? activityLevel;
  final String? diet;

  const HomeScreen({
    this.gender,
    this.birthdate,
    this.weight,
    this.targetWeight,
    this.height,
    this.goal,
    this.activityLevel,
    this.diet,
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String gender;
  late String birthdate;
  late int weight;
  late int targetWeight;
  late String height;
  late String goal;
  late String activityLevel;
  late String diet;

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFromPrefs();
  }

  Future<void> _loadFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      gender = widget.gender ?? prefs.getString('gender') ?? 'Not set';
      birthdate = widget.birthdate ?? prefs.getString('birthdate') ?? 'Not set';
      weight = widget.weight ?? prefs.getInt('weight') ?? 0;
      targetWeight = widget.targetWeight ?? prefs.getInt('targetWeight') ?? 0;
      height = widget.height ?? prefs.getString('height') ?? 'Not set';
      goal = widget.goal ?? prefs.getString('goal') ?? 'Not set';
      activityLevel =
          widget.activityLevel ?? prefs.getString('activityLevel') ?? 'Not set';
      diet = widget.diet ?? prefs.getString('diet') ?? 'Not set';
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(title: const Text("My Fitness Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildInfoCard("Gender", gender),
            _buildInfoCard("Birthdate", birthdate),
            _buildInfoCard("Weight", "$weight"),
            _buildInfoCard("Target Weight", "$targetWeight"),
            _buildInfoCard("Height", height),
            _buildInfoCard("Goal", goal),
            _buildInfoCard("Activity Level", activityLevel),
            _buildInfoCard("Diet", diet),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(vertical: 10),
        elevation: 4,
        child: ListTile(
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(value, style: const TextStyle(fontSize: 16)),
        ),
      ),
    );
  }
}
