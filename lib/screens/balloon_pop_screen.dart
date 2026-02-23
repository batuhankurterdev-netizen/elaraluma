import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

class BalloonPopScreen extends StatefulWidget {
  final Function onComplete;

  const BalloonPopScreen({Key? key, required this.onComplete})
      : super(key: key);

  @override
  _BalloonPopScreenState createState() => _BalloonPopScreenState();
}

class _BalloonPopScreenState extends State<BalloonPopScreen>
    with TickerProviderStateMixin {
  List<Balloon> balloons = [];
  int poppedCount = 0;
  int targetCount = 20;
  Random random = Random();
  Timer? spawnTimer;

  @override
  void initState() {
    super.initState();
    _startSpawning();
  }

  void _startSpawning() {
    // Her 1.5 saniyede bir balon oluştur
    spawnTimer = Timer.periodic(Duration(milliseconds: 1500), (timer) {
      if (mounted) {
        _spawnBalloon();
      }
    });
  }

  void _spawnBalloon() {
    final controller = AnimationController(
      duration: Duration(seconds: 4 + random.nextInt(3)), // 4-6 saniye
      vsync: this,
    );

    final balloon = Balloon(
      id: DateTime.now().millisecondsSinceEpoch,
      color: _getRandomColor(),
      startX: random.nextDouble() * 0.8 + 0.1, // 0.1 - 0.9 arası
      controller: controller,
    );

    setState(() {
      balloons.add(balloon);
    });

    controller.forward();

    // Animasyon bitince balonu listeden çıkar
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (mounted) {
          setState(() {
            balloons.removeWhere((b) => b.id == balloon.id);
          });
        }
        controller.dispose();
      }
    });
  }

  Color _getRandomColor() {
    List<Color> colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.yellow,
      Colors.orange,
      Colors.purple,
      Colors.pink,
      Colors.cyan,
    ];
    return colors[random.nextInt(colors.length)];
  }

  void _popBalloon(Balloon balloon) {
    setState(() {
      balloons.removeWhere((b) => b.id == balloon.id);
      poppedCount++;
    });
    
    balloon.controller.dispose();

    // Hedefe ulaşıldı mı?
    if (poppedCount >= targetCount) {
      spawnTimer?.cancel();
      Future.delayed(Duration(milliseconds: 500), () {
        _showCompleteDialog();
      });
    }
  }

  void _showCompleteDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text('🎉 Tebrikler!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$targetCount balon patlattın!\n\nElara: "Harika işti!" 🎈✨',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              '🎈',
              style: TextStyle(fontSize: 64),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              widget.onComplete();
              Navigator.pop(context);
            },
            child: Text('Tamamla'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    spawnTimer?.cancel();
    for (var balloon in balloons) {
      balloon.controller.dispose();
    }
    super.dispose();
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
              Color(0xFF87CEEB), // Sky blue
              Color(0xFFB0E0E6),
              Color(0xFFFFFFFF),
            ],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Header
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.blue[900]),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              '🎈 Balon Patlatma',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[900],
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Patlattığın balon: $poppedCount / $targetCount',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 48),
                    ],
                  ),
                ),
              ),

              // Progress bar
              Positioned(
                top: 100,
                left: 20,
                right: 20,
                child: Column(
                  children: [
                    LinearProgressIndicator(
                      value: poppedCount / targetCount,
                      backgroundColor: Colors.white.withOpacity(0.5),
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                      minHeight: 10,
                    ),
                  ],
                ),
              ),

              // Balonlar
              ...balloons.map((balloon) {
                return AnimatedBuilder(
                  animation: balloon.controller,
                  builder: (context, child) {
                    final screenHeight = MediaQuery.of(context).size.height;
                    final screenWidth = MediaQuery.of(context).size.width;
                    
                    return Positioned(
                      left: screenWidth * balloon.startX - 40,
                      bottom: screenHeight * balloon.controller.value - 80,
                      child: GestureDetector(
                        onTap: () => _popBalloon(balloon),
                        child: _buildBalloon(balloon),
                      ),
                    );
                  },
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBalloon(Balloon balloon) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 80,
          height: 100,
          decoration: BoxDecoration(
            color: balloon.color,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(40),
              bottom: Radius.circular(60),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8,
                offset: Offset(2, 2),
              ),
            ],
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                balloon.color.withOpacity(0.8),
                balloon.color,
                balloon.color.withOpacity(0.9),
              ],
            ),
          ),
          child: Stack(
            children: [
              // Işık yansıması
              Positioned(
                top: 15,
                left: 15,
                child: Container(
                  width: 20,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
        // Balon ipi
        Container(
          width: 2,
          height: 30,
          color: Colors.grey[600],
        ),
      ],
    );
  }
}

class Balloon {
  final int id;
  final Color color;
  final double startX;
  final AnimationController controller;

  Balloon({
    required this.id,
    required this.color,
    required this.startX,
    required this.controller,
  });
}
