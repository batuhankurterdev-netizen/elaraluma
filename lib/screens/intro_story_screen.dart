import 'package:flutter/material.dart';
import 'level_map_screen.dart';

class IntroStoryScreen extends StatefulWidget {
  const IntroStoryScreen({Key? key}) : super(key: key);

  @override
  _IntroStoryScreenState createState() => _IntroStoryScreenState();
}

class _IntroStoryScreenState extends State<IntroStoryScreen> {
  int currentPage = 0;

  final List<Map<String, dynamic>> storyPages = [
    {
      'character': 'elara',
      'text': 'Merhaba! Ben Elara. Turuncu saçlı küçük bir kızım ve büyülü bir ormanda yaşıyorum.',
    },
    {
      'character': 'luma',
      'text': 'Miyav! Ben de Luma, Elara\'nın en iyi arkadaşı sihirli bir kediyim! 🐱✨',
    },
    {
      'character': 'elara',
      'text': 'Bugün ormanda oynarken yolumuzu kaybettik... Eve dönmek için 4 büyülü bölgeden geçmeliyiz!',
    },
    {
      'character': 'luma',
      'text': 'Her bölgede eğlenceli bir macera bizi bekliyor. Bize yardım eder misin? 🌟',
    },
  ];

  void nextPage() {
    if (currentPage < storyPages.length - 1) {
      setState(() {
        currentPage++;
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LevelMapScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final page = storyPages[currentPage];
    final isElara = page['character'] == 'elara';

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg-forest.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.3),
                Colors.transparent,
                Colors.black.withOpacity(0.3),
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: Image.asset(
                      isElara ? 'assets/images/elara.png' : 'assets/images/luma.png',
                      width: isElara ? 300 : 250,
                      height: isElara ? 300 : 250,
                      errorBuilder: (context, error, stackTrace) {
                        return Text(
                          isElara ? '👧' : '🐱',
                          style: TextStyle(fontSize: 150),
                        );
                      },
                    ),
                  ),
                ),
                
                Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFFFFD700).withOpacity(0.5),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        page['text'],
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF4A148C),
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      
                      SizedBox(height: 20),
                      
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          storyPages.length,
                          (index) => Container(
                            margin: EdgeInsets.symmetric(horizontal: 4),
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: index == currentPage
                                  ? Color(0xFFFFD700)
                                  : Colors.grey[300],
                            ),
                          ),
                        ),
                      ),
                      
                      SizedBox(height: 20),
                      
                      ElevatedButton(
                        onPressed: nextPage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFFFD700),
                          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          currentPage < storyPages.length - 1 ? 'İleri' : 'Hadi Başlayalım!',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
