import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class CrystalGameScreen extends StatefulWidget {
  final int levelId;
  final VoidCallback onComplete;

  const CrystalGameScreen({
    Key? key,
    required this.levelId,
    required this.onComplete,
  }) : super(key: key);

  @override
  _CrystalGameScreenState createState() => _CrystalGameScreenState();
}

class _CrystalGameScreenState extends State<CrystalGameScreen> {
  int collected = 0;
  int total = 8;
  List<Crystal> crystals = [];
  Random random = Random();

  @override
  void initState() {
    super.initState();
    generateCrystals();
  }

  void generateCrystals() {
    crystals.clear();
    for (int i = 0; i < total; i++) {
      crystals.add(Crystal(
        id: i,
        x: random.nextDouble() * 0.8 + 0.1,
        y: random.nextDouble() * 0.7 + 0.15,
        color: _getRandomColor(),
      ));
    }
    setState(() {});
  }

  Color _getRandomColor() {
    List<Color> colors = [
      Color(0xFFFFD700), // Gold
      Color(0xFF00FFFF), // Cyan
      Color(0xFFFF00FF), // Magenta
      Color(0xFF00FF00), // Green
      Color(0xFFFF6B6B), // Red
      Color(0xFF4ECDC4), // Teal
    ];
    return colors[random.nextInt(colors.length)];
  }

  void collectCrystal(int id) {
    setState(() {
      crystals.removeWhere((c) => c.id == id);
      collected++;
      
      if (collected >= total) {
        _showCompletionDialog();
      }
    });
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '⭐',
                style: TextStyle(fontSize: 80),
              ),
              SizedBox(height: 20),
              Text(
                'Harika İş Elara!',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4A148C),
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Tüm kristalleri topladın! Yol artık aydınlatıldı ✨',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  widget.onComplete();
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFFFD700),
                  onPrimary: Color(0xFF4A148C),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Devam Et',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double progress = collected / total;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1A0033),
              Color(0xFF4A148C),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Üst bar
              Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
                      onPressed: () => Navigator.pop(context),
                    ),
                    IconButton(
                      icon: Icon(Icons.home, color: Colors.white, size: 30),
                      onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            'Kristal Vadisi',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            height: 20,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Stack(
                              children: [
                                FractionallySizedBox(
                                  widthFactor: progress,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xFFFFD700),
                                          Color(0xFFFFE55C),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    '$collected / $total',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 100),
                  ],
                ),
              ),
              
              // Oyun alanı
              Expanded(
                child: Stack(
                  children: crystals.map((crystal) {
                    return Positioned(
                      left: MediaQuery.of(context).size.width * crystal.x - 30,
                      top: MediaQuery.of(context).size.height * crystal.y - 30,
                      child: GestureDetector(
                        onTap: () => collectCrystal(crystal.id),
                        child: TweenAnimationBuilder(
                          tween: Tween<double>(begin: 0.8, end: 1.2),
                          duration: Duration(milliseconds: 800),
                          curve: Curves.easeInOut,
                          builder: (context, double scale, child) {
                            return Transform.scale(
                              scale: scale,
                              child: Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: RadialGradient(
                                    colors: [
                                      crystal.color,
                                      crystal.color.withOpacity(0.5),
                                    ],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: crystal.color.withOpacity(0.6),
                                      blurRadius: 15,
                                      spreadRadius: 5,
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    '💎',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                ),
                              ),
                            );
                          },
                          onEnd: () {
                            // Animasyonu tekrarla
                            if (mounted) {
                              setState(() {});
                            }
                          },
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class Crystal {
  final int id;
  final double x;
  final double y;
  final Color color;

  Crystal({
    required this.id,
    required this.x,
    required this.y,
    required this.color,
  });
}
