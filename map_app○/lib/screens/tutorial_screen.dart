import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_screen.dart';

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  _TutorialScreenState createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            children: [
              _buildTutorialPage(
                'ようこそ！',
                'このアプリでは地図を使ってピンを管理できます。',
                Icons.map,
              ),
              _buildTutorialPage(
                'ピンの追加',
                '地図を長押しして、任意の場所にピンを追加しましょう。',
                Icons.add_location,
              ),
              _buildTutorialPage(
                'リアルタイム同期',
                '保存したピンはリアルタイムで表示されます。',
                Icons.sync,
              ),
              _buildFinalPage(context),
            ],
          ),
          _buildPageIndicator(),
        ],
      ),
    );
  }

  Widget _buildTutorialPage(String title, String description, IconData icon) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 100, color: Colors.blue),
            const SizedBox(height: 20),
            Text(
              title,
              style: GoogleFonts.notoSansJp(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              description,
              textAlign: TextAlign.center,
              style: GoogleFonts.notoSansJp(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFinalPage(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, size: 100, color: Colors.green),
            const SizedBox(height: 20),
            Text(
              '準備完了！',
              style: GoogleFonts.notoSansJp(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'それではアプリを楽しみましょう。',
              textAlign: TextAlign.center,
              style: GoogleFonts.notoSansJp(fontSize: 18),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
              child: const Text('はじめる'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Positioned(
      bottom: 20,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(4, (index) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            height: 12.0,
            width: _currentPage == index ? 12.0 : 8.0,
            decoration: BoxDecoration(
              color: _currentPage == index ? Colors.black : Colors.grey,
              shape: BoxShape.circle,
            ),
          );
        }),
      ),
    );
  }
}
