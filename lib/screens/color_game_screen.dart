import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class ColorGameScreen extends StatefulWidget {
  final int levelId;
  final VoidCallback onComplete;

  const ColorGameScreen({
    Key? key,
    required this.levelId,
    required this.onComplete,
  }) : super(key: key);

  @override
  _ColorGameScreenState createState() => _ColorGameScreenState();
}

class _ColorGameScreenState extends State<ColorGameScreen> {
  int currentRound = 0;
  int totalRounds = 8;
  int score = 0;
  
  late Color targetColor;
  late String targetColorName;
  List<ColorOption> colorOptions = [];
  Random random = Random();
  bool isAnswering = false;
  
  final Map<String, Color> colorMap = {
    'Kırmızı': Color(0xFFFF0000),
    'Mavi': Color(0xFF0000FF),
    'Yeşil': Color(0xFF00FF00),
    'Sarı': Color(0xFFFFFF00),
    'Turuncu': Color(0xFFFF6600),
    'Mor': Color(0xFF9900FF),
    'Pembe': Color(0xFFFF69B4),
    'Turkuaz': Color(0xFF00CED1),
  };

  @override
  void initState() {
    super.initState();
    generateNewRound();
  }

  void generateNewRound() {
    List<String> colorNames = colorMap.keys.toList();
    colorNames.shuffle(random);
    
    targetColorName = colorNames[0];
    targetColor = colorMap[targetColorName]!;
    
    // 4 seçenek oluştur (1 doğru, 3 yanlış)
    colorOptions = [];
    colorOptions.add(ColorOption(
      name: targetColorName,
      color: targetColor,
      isCorrect: true,
    ));
    
    for (int i = 1; i < 4; i++) {
      colorOptions.add(ColorOption(
        name: colorNames[i],
        color: colorMap[colorNames[i]]!,
        isCorrect: false,
      ));
    }
    
    colorOptions.shuffle(random);
    setState(() {});
  }

  void selectColor(ColorOption option) {
    if (isAnswering) return;
    
    setState(() {
      isAnswering = true;
      option.isSelected = true;
    });

    if (option.isCorrect) {
      score++;
      Timer(Duration(milliseconds: 800), () {
        setState(() {
          currentRound++;
          isAnswering = false;
          
          if (currentRound >= totalRounds) {
            _showCompletionDialog();
          } else {
            generateNewRound();
          }
        });
      });
    } else {
      Timer(Duration(milliseconds: 800), () {
        setState(() {
          isAnswering = false;
          option.isSelected = false;
        });
      });
    }
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
                '🌈✨',
                style: TextStyle(fontSize: 80),
              ),
              SizedBox(height: 20),
              Text(
                'Harika Elara!',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4A148C),
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Gökkuşağı köprüsünü geçtin! Renkler harikaydı 🎨',
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
    double progress = currentRound / totalRounds;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFF6B6B),
              Color(0xFFFFD93D),
              Color(0xFF6BCF7F),
              Color(0xFF4D96FF),
              Color(0xFF9B59B6),
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
                            'Renk Köprüsü',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 5,
                                ),
                              ],
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
                                          Colors.white,
                                          Color(0xFFFFD700),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    '$currentRound / $totalRounds',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      shadows: [
                                        Shadow(
                                          color: Colors.black45,
                                          blurRadius: 2,
                                        ),
                                      ],
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
              
              SizedBox(height: 40),
              
              // Hedef renk gösterimi
              Text(
                'Bu rengi bul:',
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 10,
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 30),
              
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: targetColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 5),
                  boxShadow: [
                    BoxShadow(
                      color: targetColor.withOpacity(0.6),
                      blurRadius: 30,
                      spreadRadius: 10,
                    ),
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 20,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 50),
              
              Text(
                'Rengi seç:',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              
              SizedBox(height: 20),
              
              // Renk seçenekleri
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: 1.2,
                  ),
                  itemCount: colorOptions.length,
                  itemBuilder: (context, index) {
                    return ColorOptionWidget(
                      option: colorOptions[index],
                      onTap: () => selectColor(colorOptions[index]),
                      isDisabled: isAnswering,
                    );
                  },
                ),
              ),
              
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class ColorOption {
  final String name;
  final Color color;
  final bool isCorrect;
  bool isSelected;

  ColorOption({
    required this.name,
    required this.color,
    required this.isCorrect,
    this.isSelected = false,
  });
}

class ColorOptionWidget extends StatelessWidget {
  final ColorOption option;
  final VoidCallback onTap;
  final bool isDisabled;

  const ColorOptionWidget({
    Key? key,
    required this.option,
    required this.onTap,
    required this.isDisabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isDisabled ? null : onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: option.color,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: option.isSelected
                ? (option.isCorrect ? Colors.green : Colors.red)
                : Colors.white,
            width: option.isSelected ? 5 : 3,
          ),
          boxShadow: [
            BoxShadow(
              color: option.color.withOpacity(0.5),
              blurRadius: 15,
              spreadRadius: 5,
            ),
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Stack(
          children: [
            Center(
              child: Text(
                option.name,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.7),
                      blurRadius: 5,
                    ),
                  ],
                ),
              ),
            ),
            if (option.isSelected)
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black54,
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Icon(
                    option.isCorrect ? Icons.check_circle : Icons.cancel,
                    color: Colors.white,
                    size: 60,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
