//import 'dart:js';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import 'package:nd_telemedicine_app/screens/chat_menu.dart';
import 'package:nd_telemedicine_app/screens/doctor_schedule.dart';
import 'package:nd_telemedicine_app/screens/doctor_home.dart';
import 'package:nd_telemedicine_app/screens/home.dart';
import 'package:nd_telemedicine_app/screens/list_doctor.dart';
import 'package:nd_telemedicine_app/screens/list_patient.dart';
import 'package:nd_telemedicine_app/screens/sign_in.dart';
import 'package:nd_telemedicine_app/screens/prescription_screen.dart';
import 'package:nd_telemedicine_app/screens/profile_screen.dart';
import 'package:intl/date_symbol_data_local.dart';

//import 'package:bottom_bar_page_transition/bottom_bar_page_transition.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(const MyApp()));
}

// void main() {
//   runApp(const MyApp());
// }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  MaterialColor buildMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    return MaterialColor(color.value, swatch);
  }

  // @override
  // void initState() {
  //   super.initState();
  //   _pageController = PageController();
  // }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ND-Telemedicine-App',
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(boldText: false, textScaleFactor: 1.0),
        child: child!,
      ),
      theme: ThemeData(
        primarySwatch: buildMaterialColor(const Color(0xff2B8D78)),
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: Color(0xffFDFFFE),
      ),
      home: SignInPage(),
      // routes: {
      //   '/homepage' : (context) => fadeTransitionHomeScreen(),
      //
      // },
    );
  }
}

Route fadeTransitionHomeScreen() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const HomeScreen(),
    transitionDuration: Duration(milliseconds: 2450),
    transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
  );
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

// Bottom Nav for Patients
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    DoctorAppointmentScreen(),
    PrescriptionScreen(),
    ChatMenu(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      body: PageTransitionSwitcher(
        transitionBuilder: (child, primaryAnimation, secondaryAnimation) =>
            FadeThroughTransition(
                animation: primaryAnimation,
                secondaryAnimation: secondaryAnimation,
                child: child),
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              size: 27,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined),
            label: 'Booking',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.note_add_outlined,
              size: 26,
            ),
            label: 'Medicine',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.chat_bubble_outline_rounded,
              size: 26,
            ),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded, size: 27),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Color(0xff031011),
        unselectedLabelStyle:
            const TextStyle(color: Color(0xff031011), fontSize: 12),
        selectedLabelStyle:
            const TextStyle(color: Color(0xff78CEBB), fontSize: 14),
        showUnselectedLabels: true,
        selectedIconTheme: IconThemeData(
          size: 30,
        ),
        selectedItemColor: Color(0xff78CEBB),
        onTap: _onItemTapped,
      ),
    );
  }
}

// Bottom nav for Doctors
class DoctorNavBar extends StatefulWidget {
  const DoctorNavBar({super.key});

  @override
  State<DoctorNavBar> createState() => _DoctorNavBarState();
}

class _DoctorNavBarState extends State<DoctorNavBar> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    DoctorHomeScreen(),
    DoctorSchedule(),
    AllPatientsScreen(),
    ChatMenu(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              size: 27,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined),
            label: 'Booking',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.note_add_outlined,
              size: 26,
            ),
            label: 'Medicine',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.chat_bubble_outline_rounded,
              size: 26,
            ),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded, size: 27),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Color(0xff031011),
        unselectedLabelStyle:
            const TextStyle(color: Color(0xff031011), fontSize: 12),
        selectedLabelStyle:
            const TextStyle(color: Color(0xff78CEBB), fontSize: 14),
        showUnselectedLabels: true,
        selectedIconTheme: IconThemeData(
          size: 30,
        ),
        selectedItemColor: Color(0xff78CEBB),
        onTap: _onItemTapped,
      ),
    );
  }
}
