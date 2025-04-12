// ignore_for_file: prefer_const_constructors

import 'package:bhumibd/app/modules/home/views/home_view.dart';
import 'package:bhumibd/app/modules/service/views/service_view.dart';
import 'package:bhumibd/app/resource/app_color/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardView extends StatefulWidget {
  DashboardView({super.key,});

  @override
  State<DashboardView> createState() => _BrokerHomeState();
}

class _BrokerHomeState extends State<DashboardView> {
  int currentIndex = 0;

  // List of body views based on selected index
  static List<Widget> screens = <Widget>[
    HomeView(),
    ServiceView(),
  ];

  // Active icon list for each tab
  final List<String> activeIcons = [
    'assets/icons/home_active.png',
    'assets/icons/service_inactive.png',
  ];

  // Inactive icon list for each tab
  final List<String> inactiveIcons = [
    'assets/icons/home_inactive.png',
    'assets/icons/service_active.png',
  ];

  // Titles for bottom navigation
  List<String> listOfTitles = [
    'Home',
    'Service',
  ];

  bool get isTablet {
    return MediaQuery.of(context).size.width > 600.0;
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen size using MediaQuery
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: screens[currentIndex],
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height:  isTablet ? size.height * 0.10 : size.height * 0.08,
        decoration: BoxDecoration(
          color: AppColors.violetDarkHover,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 30,
              offset: Offset(0, 10),
            ),
          ],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(0),
            topRight: Radius.circular(0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(2, (index) {
            return Expanded(
              child: InkWell(
                onTap: () {
                  setState(() {
                    currentIndex = index;
                  });
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Animated top border (highlight) when selected
                    AnimatedContainer(
                      duration: Duration(milliseconds: 150),
                      margin: EdgeInsets.only(
                        bottom: index == currentIndex ? 0 : (isTablet ? size.width * 0.018 : size.width * 0.025),
                        right: size.width * .0400,
                        left: size.width * .0400,
                      ),
                      width: size.width * 0.128,
                      height: index == currentIndex ? (isTablet ? size.width * 0.006 : size.width * 0.010) : 0,
                    ),
                    // Custom icon using Image.asset (active/inactive)
                    Image.asset(
                      index == currentIndex
                          ? activeIcons[index]  // Active icon from the list
                          : inactiveIcons[index],  // Inactive icon from the list
                      width: isTablet ? size.width * 0.035 :size.width * 0.060,
                      height: isTablet ? size.height * 0.035 :size.height * 0.030,
                      color: index == currentIndex
                          ? AppColors.white
                          : Colors.white,
                    ),

                    // Show the title only when currentIndex == index
                    Text(
                      listOfTitles[index],
                      style: GoogleFonts.poppins(
                        color: index == currentIndex? AppColors.white : Colors.white,
                        fontSize: isTablet ? 12 : 12,
                      ),
                    ),

                    // Animated bottom border (highlight) when selected
                    AnimatedContainer(
                      duration: Duration(milliseconds: 150),
                      margin: EdgeInsets.only(
                        top: index == currentIndex ? 0 : (isTablet ? size.width * .006 : size.width * .010),
                        right: size.width * .0422,
                        left: size.width * .0422,
                      ),
                      width: size.width * 0.300,
                      height: index == currentIndex ? (isTablet ? size.width * 0.006 : size.width * 0.010) : 0,
                      decoration: BoxDecoration(
                        color: Color(0xffFDFDFD),
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
