import 'package:flutter/material.dart';

class LumaColoringScreen extends StatefulWidget {
  final Function onComplete;

  const LumaColoringScreen({Key? key, required this.onComplete})
      : super(key: key);

  @override
  _LumaColoringScreenState createState() => _LumaColoringScreenState();
}

class _LumaColoringScreenState extends State<LumaColoringScreen> {
  Color selectedColor = Colors.purple;
  List<DrawingPoint> drawingPoints = [];
  double brushSize = 15.0;

  void _showCompleteDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text('🎉 Harika!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Luma\'yı muhteşem boyadın!\n\n"Miyav! Çok güzel oldum!" 🐱✨',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Image.asset(
              'assets/images/luma.png',
              width: 100,
              height: 100,
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFFF5F7),
              Color(0xFFF3E5F5),
              Color(0xFFE1F5FE),
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
                      child: Text(
                        '🐱 Luma\'yı Boya',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple[800],
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          drawingPoints.clear();
                        });
                      },
                      tooltip: 'Temizle',
                    ),
                  ],
                ),
              ),

              Text(
                'İstediğin gibi boya! 🎨',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.purple[600],
                ),
              ),

              SizedBox(height: 20),

              // Boyama alanı
              Expanded(
                flex: 3,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Stack(
                      children: [
                        // Arka plan resmi - tıklamayı engellemez
                        Center(
                          child: Image.asset(
                            'assets/images/lumaboya.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                        // Çizim katmanı - üstte
                        GestureDetector(
                          onPanStart: (details) {
                            setState(() {
                              drawingPoints.add(
                                DrawingPoint(
                                  offset: details.localPosition,
                                  color: selectedColor,
                                  size: brushSize,
                                ),
                              );
                            });
                          },
                          onPanUpdate: (details) {
                            setState(() {
                              drawingPoints.add(
                                DrawingPoint(
                                  offset: details.localPosition,
                                  color: selectedColor,
                                  size: brushSize,
                                ),
                              );
                            });
                          },
                          onPanEnd: (details) {
                            setState(() {
                              drawingPoints.add(DrawingPoint.separator());
                            });
                          },
                          child: CustomPaint(
                            painter: DrawingPainter(drawingPoints: drawingPoints),
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              color: Colors.transparent,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),

              // Fırça boyutu
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Row(
                  children: [
                    Text('Fırça: ', style: TextStyle(fontWeight: FontWeight.bold)),
                    Expanded(
                      child: Slider(
                        value: brushSize,
                        min: 5,
                        max: 40,
                        onChanged: (value) {
                          setState(() {
                            brushSize = value;
                          });
                        },
                      ),
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: selectedColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child: Center(
                        child: Container(
                          width: brushSize,
                          height: brushSize,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Tamamla butonu
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                child: ElevatedButton.icon(
                  onPressed: _showCompleteDialog,
                  icon: Icon(Icons.check),
                  label: Text('Boyama Tamamlandı!'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    onPrimary: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 12),
                    minimumSize: Size(double.infinity, 50),
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
                      'Renk Seç 👇',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple[800],
                      ),
                    ),
                    SizedBox(height: 12),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
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
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isSelected ? Colors.black : Colors.grey[400]!,
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
                                ? Icon(Icons.check, color: Colors.white, size: 24)
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
      Colors.pink,
      Colors.purple[300]!,
      Colors.purple,
      Colors.deepPurple,
      Colors.blue,
      Colors.lightBlue,
      Colors.cyan,
      Colors.teal,
      Colors.green,
      Colors.lightGreen,
      Colors.lime,
      Colors.yellow,
      Colors.amber,
      Colors.orange,
      Colors.deepOrange,
      Colors.brown,
      Colors.grey,
      Colors.black,
      Colors.white,
    ];
  }
}

class DrawingPoint {
  final Offset? offset;
  final Color color;
  final double size;

  DrawingPoint({
    this.offset,
    required this.color,
    required this.size,
  });

  DrawingPoint.separator()
      : offset = null,
        color = Colors.transparent,
        size = 0;
}

class DrawingPainter extends CustomPainter {
  final List<DrawingPoint> drawingPoints;

  DrawingPainter({required this.drawingPoints});

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < drawingPoints.length; i++) {
      final point = drawingPoints[i];
      
      if (point.offset != null) {
        final paint = Paint()
          ..color = point.color.withOpacity(0.7) // Şeffaflık ekledik
          ..strokeCap = StrokeCap.round
          ..strokeWidth = point.size
          ..blendMode = BlendMode.multiply; // Alttaki görsel görünsün

        // Eğer bir sonraki nokta varsa ve ayrıcı değilse, çizgi çiz
        if (i + 1 < drawingPoints.length && 
            drawingPoints[i + 1].offset != null) {
          canvas.drawLine(
            point.offset!,
            drawingPoints[i + 1].offset!,
            paint,
          );
        } else {
          // Tek nokta çiz
          canvas.drawCircle(point.offset!, point.size / 2, paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
