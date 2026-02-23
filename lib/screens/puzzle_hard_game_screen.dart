import 'dart:math';
import 'package:flutter/material.dart';

class PuzzleHardGameScreen extends StatefulWidget {
  final int levelId;
  final VoidCallback onComplete;

  const PuzzleHardGameScreen({
    Key? key,
    required this.levelId,
    required this.onComplete,
  }) : super(key: key);

  @override
  _PuzzleHardGameScreenState createState() => _PuzzleHardGameScreenState();
}

class _PuzzleHardGameScreenState extends State<PuzzleHardGameScreen> {
  List<int> puzzlePieces = [];
  List<int?> boardSlots = [];
  int gridSize = 16; // 4x4 puzzle
  int rows = 4;
  int cols = 4;
  Random random = Random();
  int? selectedPiece;
  int completedPieces = 0;
  
  // Parça görselleri
  List<String> getPieceImages() {
    return List.generate(16, (i) => 'assets/images/Bölünmüş görsel ${i + 1}.png');
  }

  @override
  void initState() {
    super.initState();
    initializePuzzle();
  }

  void initializePuzzle() {
    puzzlePieces = List.generate(gridSize, (i) => i);
    puzzlePieces.shuffle(random);
    boardSlots = List.generate(gridSize, (i) => null);
    setState(() {});
  }

  void onPieceSelected(int piece) {
    setState(() {
      selectedPiece = piece;
    });
  }

  void onSlotTapped(int slotIndex) {
    if (selectedPiece == null) return;
    if (boardSlots[slotIndex] != null) return;

    setState(() {
      boardSlots[slotIndex] = selectedPiece;
      puzzlePieces.remove(selectedPiece);
      
      if (slotIndex == selectedPiece) {
        completedPieces++;
      }
      
      selectedPiece = null;
      
      if (puzzlePieces.isEmpty) {
        _checkCompletion();
      }
    });
  }

  void onPieceRemoved(int slotIndex) {
    if (boardSlots[slotIndex] == null) return;
    
    setState(() {
      int piece = boardSlots[slotIndex]!;
      if (slotIndex == piece) {
        completedPieces--;
      }
      puzzlePieces.add(piece);
      boardSlots[slotIndex] = null;
    });
  }

  void _checkCompletion() {
    bool allCorrect = true;
    for (int i = 0; i < gridSize; i++) {
      if (boardSlots[i] != i) {
        allCorrect = false;
        break;
      }
    }

    if (allCorrect) {
      Future.delayed(Duration(milliseconds: 500), () {
        _showCompletionDialog();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Parçaları doğru yere yerleştir! 🧩'),
          duration: Duration(seconds: 2),
          backgroundColor: Color(0xFFFF6B6B),
        ),
      );
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
                '🎉👧🐱',
                style: TextStyle(fontSize: 80),
              ),
              SizedBox(height: 20),
              Text(
                'İnanılmaz!',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4A148C),
                ),
              ),
              SizedBox(height: 10),
              Text(
                '16 parçalı yapbozu tamamladın! Elara ve Luma çok mutlu! 🌟',
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
                  'Tebrikler!',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color getPieceColor(int piece) {
    List<Color> colors = [
      Color(0xFF4A148C), Color(0xFF6A1B9A), Color(0xFF8E24AA), Color(0xFF9C27B0),
      Color(0xFFAB47BC), Color(0xFFBA68C8), Color(0xFFCE93D8), Color(0xFFE1BEE7),
      Color(0xFFF3E5F5), Color(0xFF7B1FA2), Color(0xFF9C4DCC), Color(0xFFAA00FF),
      Color(0xFFD500F9), Color(0xFFE040FB), Color(0xFFEA80FC), Color(0xFFF8BBD0),
    ];
    return colors[piece % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    double progress = completedPieces / gridSize;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2C3E50),
              Color(0xFF4A148C),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
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
                            'Elara & Luma Yapbozu',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 5),
                          Container(
                            height: 15,
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
                                      color: Color(0xFFFFD700),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    '$completedPieces / $gridSize',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
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

              Text(
                '4x4 Yapboz - 16 Parça',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFFFFD700),
                  fontWeight: FontWeight.w500,
                ),
              ),
              
              SizedBox(height: 15),

              // Puzzle tahtası - Gerçek jigsaw parçaları
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Color(0xFFFFD700), width: 3),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: AspectRatio(
                    aspectRatio: 1.0,
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.all(0),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 0,
                      ),
                      itemCount: gridSize,
                      itemBuilder: (context, index) {
                        return PuzzleSlot(
                          slotIndex: index,
                          piece: boardSlots[index],
                          onTap: () => onSlotTapped(index),
                          onRemove: () => onPieceRemoved(index),
                          color: boardSlots[index] != null 
                              ? getPieceColor(boardSlots[index]!)
                              : Colors.transparent,
                          isCorrect: boardSlots[index] == index,
                          pieceImages: getPieceImages(),
                        );
                      },
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),

              Text(
                'Parçalar',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              SizedBox(height: 10),

              // Parça havuzu
              Container(
                height: 90,
                child: puzzlePieces.isEmpty
                    ? Center(
                        child: Text(
                          'Tüm parçalar yerleştirildi! 🎉',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFFFFD700),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        itemCount: puzzlePieces.length,
                        itemBuilder: (context, index) {
                          int piece = puzzlePieces[index];
                          return PuzzlePiece(
                            piece: piece,
                            isSelected: selectedPiece == piece,
                            onTap: () => onPieceSelected(piece),
                            color: getPieceColor(piece),
                            pieceImages: getPieceImages(),
                          );
                        },
                      ),
              ),

              SizedBox(height: 15),
              
              if (selectedPiece != null)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFD700).withOpacity(0.3),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    'Boş bir yere dokun!',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class PuzzleSlot extends StatelessWidget {
  final int slotIndex;
  final int? piece;
  final VoidCallback onTap;
  final VoidCallback onRemove;
  final Color color;
  final bool isCorrect;
  final List<String> pieceImages;

  const PuzzleSlot({
    Key? key,
    required this.slotIndex,
    required this.piece,
    required this.onTap,
    required this.onRemove,
    required this.color,
    required this.isCorrect,
    required this.pieceImages,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: piece == null ? onTap : onRemove,
      child: Container(
        decoration: BoxDecoration(
          color: piece == null
              ? Colors.white.withOpacity(0.05)
              : Colors.transparent,
          border: Border.all(
            color: piece == null
                ? Colors.white.withOpacity(0.2)
                : isCorrect
                    ? Color(0xFFFFD700)
                    : Colors.transparent,
            width: isCorrect ? 2 : 0.5,
          ),
        ),
        child: piece == null
            ? Center(
                child: Text(
                  '${slotIndex + 1}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.3),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : Stack(
                children: [
                  Image.asset(
                    pieceImages[piece!],
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: color,
                        child: Center(
                          child: Text(
                            '${piece! + 1}',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      );
                    },
                  ),
                  if (isCorrect)
                    Positioned(
                      top: 3,
                      right: 3,
                      child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Color(0xFFFFD700),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black54,
                              blurRadius: 3,
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.check,
                          color: Color(0xFF4A148C),
                          size: 12,
                        ),
                      ),
                    ),
                ],
              ),
      ),
    );
  }
}

class PuzzlePiece extends StatelessWidget {
  final int piece;
  final bool isSelected;
  final VoidCallback onTap;
  final Color color;
  final List<String> pieceImages;

  const PuzzlePiece({
    Key? key,
    required this.piece,
    required this.isSelected,
    required this.onTap,
    required this.color,
    required this.pieceImages,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 70,
        height: 70,
        margin: EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: isSelected ? Color(0xFFFFD700) : Colors.white,
            width: isSelected ? 3 : 2,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected 
                  ? Color(0xFFFFD700).withOpacity(0.6)
                  : Colors.black45,
              blurRadius: isSelected ? 10 : 5,
              spreadRadius: isSelected ? 2 : 0,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Image.asset(
            pieceImages[piece],
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: color,
                child: Center(
                  child: Text(
                    '${piece + 1}',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
