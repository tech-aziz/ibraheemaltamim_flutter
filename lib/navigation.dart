// // ignore_for_file: must_be_immutable

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';

// class Navigation extends StatefulWidget {
//   int? pageNum;
//   Navigation({super.key, this.pageNum});

//   @override
//   // ignore: library_private_types_in_public_api
//   _NavigationState createState() => _NavigationState();
// }

// class _NavigationState extends State<Navigation> {
//   int selectedIndex = 0;

//   final List<Widget> screens = [
//     // const HomeScreen(),
//     // const AccountFullScreen() // PurchasedScreen
//     // ProfileScreen
//   ];

//   void onItemTapped(int index) {
//     setState(() {
//       selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: screens[selectedIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: selectedIndex,
//         onTap: onItemTapped,
//         type: BottomNavigationBarType.fixed,
//         backgroundColor: Colors.green,
//         selectedItemColor: Colors.green,
//         unselectedItemColor: Colors.grey,
//         items: [
//           BottomNavigationBarItem(
//             icon: SvgPicture.asset(''),
//             activeIcon: SvgPicture.asset(
//               '',
//               // ignore: deprecated_member_use
//               color: Colors.green,
//             ),
//             label: "Home",
//           ),
//           BottomNavigationBarItem(
//             icon: SvgPicture.asset(''),
//             activeIcon: SvgPicture.asset(
//               '',
//               // ignore: deprecated_member_use
//               color: Colors.green,
//             ),
//             label: "Profile",
//           ),
//         ],
//       ),
//     );
//   }
// }
