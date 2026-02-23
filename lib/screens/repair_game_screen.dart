import 'package:flutter/material.dart';
import 'dart:math';

class RepairGameScreen extends StatefulWidget {
  const RepairGameScreen({Key? key}) : super(key: key);

  @override
  State<RepairGameScreen> createState() => _RepairGameScreenState();
}

class _RepairGameScreenState extends State<RepairGameScreen> {
  int level = 1;
  int score = 0;
  bool isRepairing = false;
  double repairProgress = 0;
  
  final List<RepairItem> items = [
    RepairItem(name: 'Çaydanlık', emoji: '🫖', broken: '🔧', difficulty: 1),
    RepairItem(name: 'Kol Saati', emoji: '⌚', broken: '⏱️', difficulty: 2),
    RepairItem(name: 'Kukla', emoji: '🪆', broken: '🧸', difficulty: 2),
    RepairItem(name: 'Lamba', emoji: '💡', broken: '🔦', difficulty: 3),
    RepairItem(name: 'Müzik Kutusu', emoji: '🎵', broken: '📦', difficulty: 3),
    RepairItem(name: 'Anahtar', emoji: '🔑', broken: '🗝️', difficulty: 2),
    RepairItem(name: 'Çerçeve', emoji: '🖼️', broken: '🪟', difficulty: 1),
    RepairItem(name: 'Kitap', emoji: '📕', broken: '📄', difficulty: 2),
  ];
  
  late RepairItem currentItem;
  List<RepairPart> parts = [];
  RepairPart? draggedPart;
  
  @override
  void initState() {
    super.initState();
    loadNewItem();
  }
  
  void loadNewItem() {
    final random = Random();
    setState(() {
      currentItem = items[random.nextInt(items.length)];
      isRepairing = false;
      repairProgress = 0;
      
      // 3-5 arası parça oluştur
      int partCount = 3 + random.nextInt(3);
      parts = List.generate(
        partCount,
        (index) => RepairPart(
          id: index,
          x: 50.0 + random.nextDouble() * 250,
          y: 400.0 + random.nextDouble() * 200,
          isPlaced: false,
        ),
      );
    });
  }
  
  void startRepairing() {
    setState(() {
      isRepairing = true;
    });
    
    // Tamir animasyonu
    Future.delayed(Duration(milliseconds: 100), () {
      if (mounted && isRepairing) {
        setState(() {
          repairProgress += 0.05;
        });
        
        if (repairProgress < 1.0) {
          startRepairing();
        } else {
          completeRepair();
        }
      }
    });
  }
  
  void completeRepair() {
    setState(() {
      score += currentItem.difficulty * 10;
      level++;
    });
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: Color(0xFF1a1a2e),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          '✨ Harika!',
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              currentItem.emoji,
              style: TextStyle(fontSize: 80),
            ),
            SizedBox(height: 15),
            Text(
              '${currentItem.name} tamir edildi!',
              style: TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              '+${currentItem.difficulty * 10} puan',
              style: TextStyle(
                color: Color(0xFFffd700),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              loadNewItem();
            },
            child: Text(
              'Sonrakine Geç',
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
  
  void onPartPlaced(RepairPart part) {
    setState(() {
      part.isPlaced = true;
    });
    
    // Tüm parçalar yerleştirildi mi?
    if (parts.every((p) => p.isPlaced)) {
      startRepairing();
    }
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
              Color(0xFF2c3e50),
              Color(0xFF3498db),
              Color(0xFF2980b9),
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
                        Icon(Icons.emoji_events, color: Color(0xFFffd700)),
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
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        'Seviye $level',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 20),
              
              // Tamir edilecek eşya
              Text(
                'Tamir Et:',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 10),
              
              // Eşya gösterimi
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Color(0xFF4ecdc4),
                    width: 3,
                  ),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Text(
                        isRepairing || parts.every((p) => p.isPlaced)
                            ? currentItem.emoji
                            : currentItem.broken,
                        style: TextStyle(fontSize: 100),
                      ),
                    ),
                    
                    // Tamir progress bar
                    if (isRepairing)
                      Positioned(
                        bottom: 10,
                        left: 10,
                        right: 10,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: repairProgress,
                            backgroundColor: Colors.white.withOpacity(0.3),
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Color(0xFF4ecdc4),
                            ),
                            minHeight: 10,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              
              SizedBox(height: 20),
              
              Text(
                currentItem.name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              SizedBox(height: 30),
              
              // Oyun alanı
              Expanded(
                child: Stack(
                  children: [
                    // Drop bölgesi (üstte)
                    Positioned(
                      top: 20,
                      left: 20,
                      right: 20,
                      height: 150,
                      child: DragTarget<RepairPart>(
                        onAccept: (part) => onPartPlaced(part),
                        builder: (context, candidateData, rejectedData) {
                          return Container(
                            decoration: BoxDecoration(
                              color: candidateData.isNotEmpty
                                  ? Color(0xFF4ecdc4).withOpacity(0.3)
                                  : Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Color(0xFF4ecdc4),
                                width: 2,
                                style: BorderStyle.solid,
                              ),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.build_circle,
                                    color: Colors.white.withOpacity(0.5),
                                    size: 50,
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'Parçaları buraya sürükle',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.7),
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    '${parts.where((p) => p.isPlaced).length}/${parts.length}',
                                    style: TextStyle(
                                      color: Color(0xFFffd700),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    
                    // Sürüklenebilir parçalar
                    ...parts.where((p) => !p.isPlaced).map(
                          (part) => Positioned(
                            left: part.x,
                            top: part.y,
                            child: Draggable<RepairPart>(
                              data: part,
                              feedback: Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Color(0xFF4ecdc4),
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xFF4ecdc4).withOpacity(0.5),
                                      blurRadius: 20,
                                      spreadRadius: 5,
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.extension,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                              ),
                              childWhenDragging: Container(),
                              child: Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Color(0xFF4ecdc4),
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xFF4ecdc4).withOpacity(0.3),
                                      blurRadius: 10,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.extension,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
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

class RepairItem {
  final String name;
  final String emoji;
  final String broken;
  final int difficulty;
  
  RepairItem({
    required this.name,
    required this.emoji,
    required this.broken,
    required this.difficulty,
  });
}

class RepairPart {
  final int id;
  double x;
  double y;
  bool isPlaced;
  
  RepairPart({
    required this.id,
    required this.x,
    required this.y,
    this.isPlaced = false,
  });
}
