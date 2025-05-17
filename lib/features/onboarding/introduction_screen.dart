import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:sems/router.dart';

class MyIntroductionScreen extends StatelessWidget {
  const MyIntroductionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "Welcome to SEMS",
          body: "Streamline your educational management with ease.",
          image: Lottie.network(
              'https://assets9.lottiefiles.com/packages/lf20_jcikwtux.json'),
          decoration: PageDecoration(
            pageColor: Colors.blue.shade50,
            bodyFlex: 2,
            imageFlex: 3,
          ),
        ),
        PageViewModel(
          title: "Manage Classes",
          body:
              "Efficiently manage classes and courses with our intuitive interface.",
          image: Lottie.network(
              'https://lottie.host/39ecee36-0d56-47e4-9c51-06bb9a939b23/LBAYyBZas0.json'),
          decoration: PageDecoration(
            pageColor: Colors.green.shade50,
            bodyFlex: 2,
            imageFlex: 3,
          ),
        ),
        PageViewModel(
          title: "Student Access",
          body:
              "Students can easily access their attendance, materials, and results.",
          image: Lottie.network(
              'https://lottie.host/3aff1e8d-2195-4510-9f0f-2a6e089af5c7/BqfejjfYmO.json'),
          decoration: PageDecoration(
            pageColor: Colors.orange.shade50,
            bodyFlex: 2,
            imageFlex: 3,
          ),
        ),
        PageViewModel(
          title: "Advanced Features",
          body: "Explore AI-powered assistance and QR code scanning.",
          image: Lottie.network(
              'https://lottie.host/cd1d120a-7245-4536-93b6-e7fa30dc00b3/AGs9ovbxEM.json'),
          decoration: PageDecoration(
            pageColor: Colors.purple.shade50,
            bodyFlex: 2,
            imageFlex: 3,
          ),
        ),
      ],
      onDone: () => context.go(AppRoute.roleSelection.path),
      onSkip: () => context.go(AppRoute.roleSelection.path),
      showSkipButton: true,
      skip: const Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("Skip"),
        ),
      ),
      next: ClipOval(
        child: Material(
          color: Theme.of(context).colorScheme.primary, // Button color
          child: const SizedBox(
            width: 56,
            height: 56,
            child: Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
          ),
        ),
      ),
      done: ClipOval(
        child: Material(
          color: Theme.of(context).colorScheme.primary, // Button color
          child: InkWell(
            onTap: () => context.go(AppRoute.roleSelection.path),
            child: const SizedBox(
              width: 56,
              height: 56,
              child: Icon(Icons.check, color: Colors.white),
            ),
          ),
        ),
      ),
      showNextButton: true,
      curve: Curves.fastLinearToSlowEaseIn,
      dotsDecorator: DotsDecorator(
        size: const Size.square(10.0),
        activeSize: const Size(40.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        activeColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
