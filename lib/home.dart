import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

void main() {
  runApp(const GitaApp());
}

class GitaApp extends StatelessWidget {
  const GitaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Gita App",
      theme: ThemeData(
        fontFamily: 'Inter',
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final pages = [
      ReadingPage(),
      WallpaperPage(),
    ];

    return LiquidSwipe(
      pages: pages,
      enableLoop: false,
      fullTransitionValue: 400,
      slideIconWidget: const Icon(Icons.arrow_back_ios, color: Colors.white),
      positionSlideIcon: 0.9,
      waveType: WaveType.liquidReveal,
      ignoreUserGestureWhileAnimating: true,
    );
  }
}

/// --------------------
/// Reading Page
/// --------------------
class ReadingPage extends StatelessWidget {
  ReadingPage({super.key});

  final List<Map<String, String>> verses = [
    {
      'sanskrit': 'कर्मण्येवाधिकारस्ते मा फलेषु कदाचन।',
      'translation': 'just do your work, don’t stress about the result.'
    },
    {
      'sanskrit': 'योगस्थः कुरु कर्माणि सङ्गं त्यक्त्वा धनञ्जय।',
      'translation': 'do your duties without clinging, Arjuna.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF003366), Color(0xFF008080)], // Top-left blue, bottom-right teal
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Gita App",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFFD700), // gold accent
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: verses.length,
                itemBuilder: (context, index) {
                  final verse = verses[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    margin: const EdgeInsets.only(bottom: 16),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            verse['sanskrit']!,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            verse['translation']!,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
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
}

/// --------------------
/// Wallpaper / Settings Page
/// --------------------
/// --------------------
/// Wallpaper / Settings Page
/// --------------------
class WallpaperPage extends StatelessWidget {
  const WallpaperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF008080), Color(0xFF003366)], // reverse gradient for style
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            const Text(
              "Set Your Wallpaper",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFFD700),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.asset(
                    'assets/krishna.jpg',
                    width: 250,
                    height: 400,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.shuffle),
                  label: const Text("Random"),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF003366)),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.settings),
                  label: const Text("Settings"),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF003366)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
