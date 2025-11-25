import 'package:evently_app/app_theme.dart';
import 'package:evently_app/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  static const routeName = '/onboarding';

  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController pageController = PageController();
  int currentPage = 0;

  List<Map<String, String>> onBoardingData = [
    {
      'image': 'assets/images/onBoarding_img1.png',
      'title': 'Find Events That Inspire You',
      'description':
          'Dive into a world of events crafted to fit your unique interests. Whether you\'re into live music, art workshops, professional networking, or simply discovering new experiences, we have something for everyone. Our curated recommendations will help you explore, connect, and make the most of every opportunity around you',
    },
    {
      'image': 'assets/images/onBoarding_img2.png',
      'title': 'Effortless Event Planning',
      'description':
          'Take the hassle out of organizing events with our all-in-one planning tools. From setting up invites and managing RSVPs to scheduling reminders and coordinating details, we’ve got you covered. Plan with ease and focus on what matters – creating an unforgettable experience for you and your guests.',
    },
    {
      'image': 'assets/images/onboarding_img3.png',
      'title': 'Connect with Friends & Share Moments',
      'description':
          'Make every event memorable by sharing the experience with others. Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together. Capture and share the excitement with your network, so you can relive the highlights and cherish the memories.',
    },
  ];

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    Size screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.flutter_dash, color: AppTheme.primary, size: 54),
                SizedBox(width: 7),
                Text('Evently', style: textTheme.headlineLarge),
              ],
            ),
            SizedBox(height: screenSize.height * .04),
            Expanded(
              child: PageView.builder(
                controller: pageController,
                physics: NeverScrollableScrollPhysics(),
                itemCount: onBoardingData.length,
                onPageChanged: (index) {
                  if (currentPage == index) return;
                  setState(() {
                    currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  currentPage = index;
                  final item = onBoardingData[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          item['image']!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: screenSize.height * .41,
                        ),
                        SizedBox(height: screenSize.height * .04),
                        Text(
                          item['title']!,
                          style: textTheme.titleLarge!.copyWith(
                            color: AppTheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: screenSize.height * .04),
                        Text(
                          item['description']!,
                          style: textTheme.titleMedium,
                        ),
                        Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            currentPage > 0
                                ? IconButton(
                                    onPressed: onBack,
                                    icon: Icon(Icons.arrow_back),
                                  )
                                : SizedBox(width: 60),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                onBoardingData.length,
                                (index) => AnimatedContainer(
                                  margin: EdgeInsets.symmetric(horizontal: 6),
                                  duration: Duration(milliseconds: 300),
                                  alignment: Alignment.center,
                                  height: 8,
                                  width: currentPage == index ? 18 : 6,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(36),
                                    color: currentPage == index
                                        ? AppTheme.primary
                                        : AppTheme.black,
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: onNext,
                              icon: Icon(Icons.arrow_forward),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onBack() {
    if (currentPage > 0) {
      pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  void onNext() async {
    if (currentPage < onBoardingData.length - 1) {
      pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      setOnBoardingSeen();
      Navigator.of(context).pushNamed(HomeScreen.routeName);
    }
  }

  Future<void> setOnBoardingSeen() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('onBoarding_seen', true);
  }
}
