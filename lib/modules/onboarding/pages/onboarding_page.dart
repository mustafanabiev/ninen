import 'package:flutter/material.dart';
import 'package:ninen/modules/main/pages/main_page.dart';
import 'package:ninen/models/onboarding_model.dart';
import 'package:ninen/theme/app_colors.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final pageController = PageController();
  int page = 0;
  final int numberOfDots = 4;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: PageView.builder(
        controller: pageController,
        itemCount: numberOfDots,
        onPageChanged: (value) {
          setState(() {
            page = value;
          });
          if (value == onboardingList.length) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const MainPage(),
              ),
              (route) => false,
            );
          }
        },
        itemBuilder: (context, index) {
          if (index == onboardingList.length) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final item = onboardingList[index];
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              images(index),
              Container(
                width: double.infinity,
                height: screenHeight / 2.5,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/circle_red.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: SizedBox(
                    width: 291,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          item.title,
                          style: const TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: 32.0,
                            fontWeight: FontWeight.w700,
                            height: 43.58 / 32.0,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          item.description,
                          style: const TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                            height: 19.32 / 14.0,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 38),
                        // selectPage(page),
                        buildDotIndicator(page),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget images(int page) {
    if (page == 1) {
      return Expanded(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 80),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                child: Image.asset(
                  'assets/images/onboarding_21.png',
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Image.asset(
                    'assets/images/onboarding_22.png',
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else if (page == 2) {
      return Expanded(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 80),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                child: Image.asset(
                  'assets/images/onboarding_32.png',
                ),
              ),
              Positioned(
                top: 100,
                right: 0,
                child: Image.asset(
                  'assets/images/onboarding_31.png',
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Image.asset(
                    'assets/images/onboarding_33.png',
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Expanded(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 80),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                child: Image.asset(
                  'assets/images/onboarding_11.png',
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Image.asset(
                    'assets/images/onboarding_12.png',
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget buildDotIndicator(int currentIndex) {
    List<Widget> dots = [];
    for (int i = 0; i < numberOfDots - 1; i++) {
      dots.add(
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: i == currentIndex ? AppColors.red : AppColors.grey,
            shape: BoxShape.circle,
          ),
        ),
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: dots,
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:ninen/modules/main/pages/main_page.dart';
// import 'package:ninen/theme/app_colors.dart';

// class OnboardingPageBuilderScreen extends StatefulWidget {
//   const OnboardingPageBuilderScreen({super.key});

//   @override
//   State<OnboardingPageBuilderScreen> createState() =>
//       _OnboardingPageBuilderScreenState();
// }

// class _OnboardingPageBuilderScreenState
//     extends State<OnboardingPageBuilderScreen> {
//   final PageController _pageController = PageController();
//   int _currentPage = 0;
//   final int numberOfDots = 3;

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   void _onPageChanged(int index) {
//     setState(() {
//       _currentPage = index;
//     });

//     if (index == numberOfDots - 1) {
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(
//             builder: (context) => const MainPage(),
//           ),
//           (route) => false,
//         );
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.white,
//       body: Stack(
//         children: [
//           PageView.builder(
//             controller: _pageController,
//             onPageChanged: _onPageChanged,
//             itemCount: numberOfDots,
//             itemBuilder: (context, index) {
//               if (index == 0) {
//                 return const OnboardingOneScreen();
//               } else if (index == 1) {
//                 return const OnboardingSecondScreen();
//               } else {
//                 return Container();
//               }
//             },
//           ),
//           Positioned(
//             bottom: 65,
//             left: 0,
//             right: 0,
//             child: buildDotIndicator(_currentPage),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildDotIndicator(int currentIndex) {
//     List<Widget> dots = [];
//     for (int i = 0; i < numberOfDots - 1; i++) {
//       dots.add(
//         Container(
//           margin: const EdgeInsets.symmetric(horizontal: 4.0),
//           width: 10,
//           height: 10,
//           decoration: BoxDecoration(
//             color: i == currentIndex ? AppColors.red : AppColors.grey,
//             shape: BoxShape.circle,
//           ),
//         ),
//       );
//     }
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: dots,
//     );
//   }
// }

// class OnboardingOneScreen extends StatelessWidget {
//   const OnboardingOneScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.white,
//       body: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Image.asset(
//               'assets/images/onboarding_11.png',
//               fit: BoxFit.cover,
//             ),
//             SizedBox(height: 74),
//             Text(
//               'Split the bill in the app',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 24,
//                 fontFamily: 'Lexend',
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class OnboardingSecondScreen extends StatelessWidget {
//   const OnboardingSecondScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.white,
//       body: SafeArea(
//         child: Column(
//           children: [
//             Image.asset(
//               'assets/images/onboarding_12.png',
//               fit: BoxFit.cover,
//             ),
//             SizedBox(
//               height: 44,
//             ),
//             Text(
//               'View the history of split\nbills',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 24,
//                 fontFamily: 'Lexend',
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
