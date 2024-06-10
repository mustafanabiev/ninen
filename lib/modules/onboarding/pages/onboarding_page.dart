import 'package:flutter/material.dart';
import 'package:ninen/modules/main/pages/main_page.dart';
import 'package:ninen/models/onboarding_model.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final pageController = PageController();
  int page = 0;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: PageView.builder(
        controller: pageController,
        itemCount: onboardingList.length + 1,
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
                        selectPage(page),
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

  Row selectPage(int page) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: 10,
          width: 10,
          margin: const EdgeInsets.only(right: 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: page == 0 ? const Color(0xffFF3225) : Colors.white,
          ),
        ),
        const SizedBox(width: 19),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: 10,
          width: 10,
          margin: const EdgeInsets.only(right: 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: page == 1 ? const Color(0xffFF3225) : Colors.white,
          ),
        ),
        const SizedBox(width: 19),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: 10,
          width: 10,
          margin: const EdgeInsets.only(right: 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: page == 2 ? const Color(0xffFF3225) : Colors.white,
          ),
        ),
      ],
    );
  }
}
