import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';
import '../services/admob_service.dart';

class StardustGameScreen extends StatefulWidget {
  const StardustGameScreen({Key? key}) : super(key: key);

  @override
  State<StardustGameScreen> createState() => _StardustGameScreenState();
}

class _StardustGameScreenState extends State<StardustGameScreen> {
  int score = 0;
  int timeLeft = 30;
  List<Star> stars = [];
  Timer? gameTimer;
  Timer? starTimer;
  bool isGameActive = false;
  Random random = Random();
  int gamesPlayed = 0;
  final AdMobManager adManager = AdMobManager();

  @override
  void initState() {
    super.initState();
    // Reklamları yükle
    adManager.loadInterstitialAd();
    adManager.loadRewardedAd();
  }

  @override
  void dispose() {
    gameTimer?.cancel();
    starTimer?.cancel();
    adManager.dispose();
    super.dispose();
  }

  void startGame() {
    setState(() {
      score = 0;
      timeLeft = 30;
      stars = [];
      isGameActive = true;
    });

    // Zaman sayacı
    gameTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        timeLeft--;
        if (timeLeft <= 0) {
          endGame();
        }
      });
    });

    // Yıldız oluşturucu
    starTimer = Timer.periodic(Duration(milliseconds: 800), (timer) {
      if (isGameActive) {
        addStar();
      }
    });
  }

  void endGame() {
    gameTimer?.cancel();
    starTimer?.cancel();
    setState(() {
      isGameActive = false;
      gamesPlayed++;
    });

    // Her 3 oyunda bir interstitial reklam göster
    if (gamesPlayed % 3 == 0) {
      adManager.showInterstitialAd();
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: Color(0xFF1a1a2e),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          '🎉 Oyun Bitti!',
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Topladığın Yıldız Tozu:',
              style: TextStyle(color: Colors.white70),
            ),
            SizedBox(height: 10),
            Text(
              '$score ✨',
              style: TextStyle(
                color: Color(0xFFffd700),
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            // Bonus yıldız için reklam izleme seçeneği
            if (adManager.isRewardedAdReady)
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  adManager.showRewardedAd(
                    onRewarded: (amount) {
                      setState(() {
                        score += 10; // Bonus yıldız
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('🎁 +10 Bonus Yıldız Kazandın!'),
                          backgroundColor: Color(0xFFffd700),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                  );
                },
                icon: Icon(Icons.video_library),
                label: Text('Reklam İzle\n+10 Bonus Yıldız'),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF4ecdc4),
                  onPrimary: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
              ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              startGame();
            },
            child: Text(
              'Tekrar Oyna',
              style: TextStyle(color: Color(0xFFffd700)),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text(
              'Ana Menü',
              style: TextStyle(color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }

  void addStar() {
    final size = MediaQuery.of(context).size;
    setState(() {
      stars.add(Star(
        x: random.nextDouble() * (size.width - 50),
        y: random.nextDouble() * (size.height - 200),
        id: DateTime.now().millisecondsSinceEpoch,
      ));

      // En fazla 8 yıldız ekranda
      if (stars.length > 8) {
        stars.removeAt(0);
      }
    });
  }

  void collectStar(Star star) {
    setState(() {
      stars.remove(star);
      score++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0f0c29),
              Color(0xFF302b63),
              Color(0xFF24243e),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Üst bar
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, color: Color(0xFFffd700)),
                        SizedBox(width: 5),
                        Text(
                          '$score',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: timeLeft <= 10
                            ? Colors.red.withOpacity(0.3)
                            : Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.timer,
                            color: timeLeft <= 10 ? Colors.red : Colors.white,
                            size: 20,
                          ),
                          SizedBox(width: 5),
                          Text(
                            '$timeLeft',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Oyun alanı
              Expanded(
                child: Stack(
                  children: [
                    // Yıldızlar
                    ...stars.map((star) => Positioned(
                          left: star.x,
                          top: star.y,
                          child: GestureDetector(
                            onTap: () => collectStar(star),
                            child: TweenAnimationBuilder(
                              tween: Tween<double>(begin: 0, end: 1),
                              duration: Duration(milliseconds: 300),
                              builder: (context, double value, child) {
                                return Transform.scale(
                                  scale: value,
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    child: Stack(
                                      children: [
                                        // Işıltı efekti
                                        Center(
                                          child: Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Color(0xFFffd700).withOpacity(0.6),
                                                  blurRadius: 20,
                                                  spreadRadius: 5,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        // Yıldız
                                        Center(
                                          child: Text(
                                            '✨',
                                            style: TextStyle(fontSize: 40),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        )),

                    // Başlangıç butonu
                    if (!isGameActive && timeLeft == 30)
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '✨',
                              style: TextStyle(fontSize: 100),
                            ),
                            SizedBox(height: 30),
                            Text(
                              'Yıldız Tozlarını Topla!',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Luma\'nın büyülü yıldız tozlarını\nyakalayabilir misin?',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 40),
                            ElevatedButton(
                              onPressed: startGame,
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xFFffd700),
                                onPrimary: Color(0xFF1a1a2e),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 50,
                                  vertical: 15,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: Text(
                                'Başla',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Star {
  final double x;
  final double y;
  final int id;

  Star({required this.x, required this.y, required this.id});
}
