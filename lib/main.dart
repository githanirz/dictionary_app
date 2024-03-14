import 'package:flutter/material.dart';
import 'package:dictionary_apps/screen_page/register_screen.dart';
import 'package:dictionary_apps/screen_page/splashscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'dictionary_apps',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();
  final List<Widget> _pages = const [
    _GetCardsContent(
      image: './lib/assets/image1.png',
    ),
    _GetCardsContent(
      image: './lib/assets/image2.png',
    ),
    _GetCardsContent(
      image: './lib/assets/image3.png',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _navigateToNextScreen() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => RegisterScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(.9),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            PageView(
              controller: _pageController,
              children: _pages,
              onPageChanged: (index) {
                if (index == _pages.length - 1) {
                  // Navigate to the next screen when the last page is reached
                  _navigateToNextScreen();
                }
              },
            ),
            Positioned(
              bottom: 20.0,
              left: 0,
              right: 0,
              child: Center(
                child: ElevatedButton(
                  onPressed: _navigateToNextScreen,
                  child: Text('Skip'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GetCardsContent extends StatelessWidget {
  final String image;

  const _GetCardsContent({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ClipRRect(
              child: Image.asset(
                image,
                fit: BoxFit.fill, // Sesuaikan tampilan gambar
                height: 680,
                width: 500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
