import 'package:flutter/material.dart';
import 'dart:math';

class ColoringGameScreen extends StatefulWidget {
  final Function onComplete;

  const ColoringGameScreen({Key? key, required this.onComplete})
      : super(key: key);

  @override
  _ColoringGameScreenState createState() => _ColoringGameScreenState();
}

class _ColoringGameScreenState extends State<ColoringGameScreen> {
  int currentLevel = 1;
  Color? selectedColor;
  List<ColorShape> shapes = [];
  int totalLevels = 3;

  @override
  void initState() {
    super.initState();
    _initLevel();
  }

  void _initLevel() {
    shapes = _getShapesForLevel(currentLevel);
    selectedColor = null;
  }

  List<ColorShape> _getShapesForLevel(int level) {
    if (level == 1) {
      // Kolay: 3 büyük şekil
      return [
        ColorShape(
          id: 1,
          targetColor: Colors.red,
          colorName: 'Kırmızı',
          shape: BoxShape.circle,
          size: 100,
        ),
        ColorShape(
          id: 2,
          targetColor: Colors.blue,
          colorName: 'Mavi',
          shape: BoxShape.circle,
          size: 100,
        ),
        ColorShape(
          id: 3,
          targetColor: Colors.yellow,
          colorName: 'Sarı',
          shape: BoxShape.circle,
          size: 100,
        ),
      ];
    } else if (level == 2) {
      // Orta: 4 şekil (daire ve kare karışık)
      return [
        ColorShape(
          id: 1,
          targetColor: Colors.green,
          colorName: 'Yeşil',
          shape: BoxShape.circle,
          size: 90,
        ),
        ColorShape(
          id: 2,
          targetColor: Colors.orange,
          colorName: 'Turuncu',
          shape: BoxShape.rectangle,
          size: 90,
        ),
        ColorShape(
          id: 3,
          targetColor: Colors.purple,
          colorName: 'Mor',
          shape: BoxShape.circle,
          size: 90,
        ),
        ColorShape(
          id: 4,
          targetColor: Colors.pink,
          colorName: 'Pembe',
          shape: BoxShape.rectangle,
          size: 90,
        ),
      ];
    } else {
      // Zor: 6 şekil (daha çok şekil, daha küçük boyut)
      return [
        ColorShape(
          id: 1,
          targetColor: Colors.red,
          colorName: 'Kırmızı',
          shape: BoxShape.circle,
          size: 70,
        ),
        ColorShape(
          id: 2,
          targetColor: Colors.blue,
          colorName: 'Mavi',
          shape: BoxShape.rectangle,
          size: 70,
        ),
        ColorShape(
          id: 3,
          targetColor: Colors.green,
          colorName: 'Yeşil',
          shape: BoxShape.circle,
          size: 70,
        ),
        ColorShape(
          id: 4,
          targetColor: Colors.yellow,
          colorName: 'Sarı',
          shape: BoxShape.rectangle,
          size: 70,
        ),
        ColorShape(
          id: 5,
          targetColor: Colors.purple,
          colorName: 'Mor',
          shape: BoxShape.circle,
          size: 70,
        ),
        ColorShape(
          id: 6,
          targetColor: Colors.brown,
          colorName: 'Kahverengi',
          shape: BoxShape.rectangle,
          size: 70,
        ),
      ];
    }
  }

  void _colorShape(ColorShape shape) {
    if (selectedColor == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Önce bir renk seçin! 🎨'),
          duration: Duration(seconds: 1),
        ),
      );
      return;
    }

    setState(() {
      shape.currentColor = selectedColor;
    });

    // Tüm şekiller doğru mu kontrol et
    if (_checkAllCorrect()) {
      Future.delayed(Duration(milliseconds: 500), () {
        if (currentLevel < totalLevels) {
          _showLevelCompleteDialog();
        } else {
          _showGameCompleteDialog();
        }
      });
    }
  }

  bool _checkAllCorrect() {
    return shapes.every((shape) =>
        shape.currentColor != null &&
        _colorsMatch(shape.currentColor!, shape.targetColor));
  }

  bool _colorsMatch(Color c1, Color c2) {
    return c1.value == c2.value;
  }

  void _showLevelCompleteDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text('🎨 Harika!'),
        content: Text(
          'Seviye $currentLevel tamamlandı!\n${_getLevelCompleteMessage()}',
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                currentLevel++;
                _initLevel();
              });
            },
            child: Text('Sonraki Seviye →'),
          ),
        ],
      ),
    );
  }

  String _getLevelCompleteMessage() {
    List<String> messages = [
      'Elara: "Çok güzel boyadın!" 🌈',
      'Luma: "Renkler mükemmel!" ✨',
      'Elara: "Sen gerçek bir sanatçısın!" 🎨',
    ];
    return messages[Random().nextInt(messages.length)];
  }

  void _showGameCompleteDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text('🎉 Tebrikler!'),
        content: Text(
          'Tüm boyama seviyeleri tamamlandı!\n\nElara ve Luma: "Orman harika renklerle doldu!" 🌈✨',
          textAlign: TextAlign.center,
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
  Widget build(BuildContext context) {
    int completedShapes =
        shapes.where((s) => s.currentColor != null).length;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFFF5E6),
              Color(0xFFFFE4E1),
              Color(0xFFE6F3FF),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.purple),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            '🎨 Renk Atölyesi',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple[800],
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Seviye $currentLevel / $totalLevels',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.purple[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 48),
                  ],
                ),
              ),

              // Progress
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    LinearProgressIndicator(
                      value: completedShapes / shapes.length,
                      backgroundColor: Colors.grey[300],
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.purple),
                      minHeight: 8,
                    ),
                    SizedBox(height: 8),
                    Text(
                      '$completedShapes / ${shapes.length} şekil boyandı',
                      style: TextStyle(color: Colors.purple[700]),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // Şekiller
              Expanded(
                flex: 3,
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 20,
                    runSpacing: 20,
                    children: shapes.map((shape) {
                      return GestureDetector(
                        onTap: () => _colorShape(shape),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: shape.size,
                              height: shape.size,
                              decoration: BoxDecoration(
                                shape: shape.shape,
                                color: shape.currentColor ??
                                    Colors.grey[200],
                                border: Border.all(
                                  color: Colors.black,
                                  width: 3,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 4,
                                    offset: Offset(2, 2),
                                  ),
                                ],
                              ),
                            ),
                            if (shape.colorName != null) ...[
                              SizedBox(height: 8),
                              Text(
                                shape.colorName!,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.purple[800],
                                ),
                              ),
                            ],
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),

              // Renk Paleti
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      selectedColor == null
                          ? 'Bir renk seçin 👇'
                          : 'Renk seçildi! Şekle dokunun 👆',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple[800],
                      ),
                    ),
                    SizedBox(height: 16),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      alignment: WrapAlignment.center,
                      children: _getPaletteColors().map((color) {
                        bool isSelected = selectedColor == color;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedColor = color;
                            });
                          },
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isSelected
                                    ? Colors.black
                                    : Colors.grey[700]!,
                                width: isSelected ? 4 : 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 4,
                                  offset: Offset(2, 2),
                                ),
                              ],
                            ),
                            child: isSelected
                                ? Icon(Icons.check,
                                    color: Colors.white, size: 30)
                                : null,
                          ),
                        );
                      }).toList(),
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

  List<Color> _getPaletteColors() {
    return [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.yellow,
      Colors.orange,
      Colors.purple,
      Colors.pink,
      Colors.brown,
    ];
  }
}

class ColorShape {
  final int id;
  final Color targetColor;
  final String? colorName;
  final BoxShape shape;
  final double size;
  Color? currentColor;

  ColorShape({
    required this.id,
    required this.targetColor,
    this.colorName,
    required this.shape,
    required this.size,
    this.currentColor,
  });
}
