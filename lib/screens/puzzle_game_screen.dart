import 'dart:math';
import 'package:flutter/material.dart';

class PuzzleGameScreen extends StatefulWidget {
  final int levelId;
  final VoidCallback onComplete;

  const PuzzleGameScreen({
    Key? key,
    required this.levelId,
    required this.onComplete,
  }) : super(key: key);

  @override
  _PuzzleGameScreenState createState() => _PuzzleGameScreenState();
}

class _PuzzleGameScreenState extends State<PuzzleGameScreen> {
  List<int> puzzlePieces = [];
  List<int?> boardSlots = [];
  int gridSize = 6; // 2x3 puzzle
  int rows = 2;
  int cols = 3;
  Random random = Random();
  int? selectedPiece;
  int completedPieces = 0;
  final String puzzleImage = 'assets/images/moonportal.png';

  @override
  void initState() {
    super.initState();
    initializePuzzle();
  }

  void initializePuzzle() {
    // 0'dan 5'e kadar parçalar
    puzzlePieces = List.generate(gridSize, (i) => i);
    puzzlePieces.shuffle(random);
    
    // Boş board
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
    if (boardSlots[slotIndex] != null) return; // Slot dolu

    // Parçayı yerleştir
    setState(() {
      boardSlots[slotIndex] = selectedPiece;
      puzzlePieces.remove(selectedPiece);
      
      // Doğru yerde mi kontrol et
      if (slotIndex == selectedPiece) {
        completedPieces++;
      }
      
      selectedPiece = null;
      
      // Tüm parçalar yerleştirildi mi?
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
    // Tüm parçalar doğru yerde mi?
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
      // Yanlış yerleştirme, tekrar dene
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
                '🎉🧩',
                style: TextStyle(fontSize: 80),
              ),
              SizedBox(height: 20),
              Text(
                'Muhteşem Luma!',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4A148C),
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Ay portalını tamamladın! Eve dönüş yolu açıldı 🌙✨',
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

  Color getPieceColor(int piece) {
    // Artık renklere gerek yok ama border için kullanabiliriz
    List<Color> colors = [
      Color(0xFF4A148C),
      Color(0xFF6A1B9A), 
      Color(0xFF8E24AA),
      Color(0xFF9C27B0),
      Color(0xFFAB47BC),
      Color(0xFFBA68C8),
    ];
    return colors[piece % colors.length];
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
              Color(0xFF2C3E50),
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
                      child: Text(
                        'Sihirli Yapboz',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(width: 100),
                  ],
                ),
              ),

              Text(
                'Ay Portalını Tamamla',
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFFFFD700),
                  fontWeight: FontWeight.w500,
                ),
              ),
              
              SizedBox(height: 30),

              // Puzzle tahtası
              Container(
                margin: EdgeInsets.symmetric(horizontal: 40),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Color(0xFFFFD700), width: 3),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.all(0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
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
                        puzzleImage: puzzleImage,
                        rows: rows,
                        cols: cols,
                      );
                    },
                  ),
                ),
              ),

              SizedBox(height: 40),

              Text(
                'Parçalar',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              SizedBox(height: 15),

              // Parça havuzu
              Container(
                height: 100,
                child: puzzlePieces.isEmpty
                    ? Center(
                        child: Text(
                          'Tüm parçalar yerleştirildi! 🎉',
                          style: TextStyle(
                            fontSize: 18,
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
                            puzzleImage: puzzleImage,
                            rows: rows,
                            cols: cols,
                          );
                        },
                      ),
              ),

              SizedBox(height: 20),
              
              if (selectedPiece != null)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFD700).withOpacity(0.3),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    'Boş bir yere dokun!',
                    style: TextStyle(
                      fontSize: 16,
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
  final String puzzleImage;
  final int rows;
  final int cols;

  const PuzzleSlot({
    Key? key,
    required this.slotIndex,
    required this.piece,
    required this.onTap,
    required this.onRemove,
    required this.color,
    required this.isCorrect,
    required this.puzzleImage,
    required this.rows,
    required this.cols,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int row = slotIndex ~/ cols;
    int col = slotIndex % cols;
    
    return GestureDetector(
      onTap: piece == null ? onTap : onRemove,
      child: Container(
        decoration: BoxDecoration(
          color: piece == null
              ? Colors.white.withOpacity(0.1)
              : Colors.transparent,
          border: Border.all(
            color: piece == null
                ? Colors.white.withOpacity(0.3)
                : isCorrect
                    ? Color(0xFFFFD700)
                    : Colors.transparent,
            width: isCorrect ? 3 : 1,
          ),
        ),
        child: piece == null
            ? Center(
                child: Text(
                  '${slotIndex + 1}',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white.withOpacity(0.5),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : Stack(
                children: [
                  _buildPuzzlePiece(piece!),
                  if (isCorrect)
                    Positioned(
                      top: 5,
                      right: 5,
                      child: Container(
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: Color(0xFFFFD700),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black54,
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.check,
                          color: Color(0xFF4A148C),
                          size: 16,
                        ),
                      ),
                    ),
                ],
              ),
      ),
    );
  }

  Widget _buildPuzzlePiece(int pieceIndex) {
    int pieceRow = pieceIndex ~/ cols;
    int pieceCol = pieceIndex % cols;

    return SizedBox.expand(
      child: FittedBox(
        fit: BoxFit.fill,
        child: ClipRect(
          child: Align(
            alignment: Alignment(
              pieceCol == 0 ? -1.0 : (pieceCol == cols - 1 ? 1.0 : 0.0),
              pieceRow == 0 ? -1.0 : (pieceRow == rows - 1 ? 1.0 : 0.0),
            ),
            widthFactor: 1 / cols,
            heightFactor: 1 / rows,
            child: Image.asset(
              puzzleImage,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: color,
                  child: Center(
                    child: Text(
                      '${pieceIndex + 1}',
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  ),
                );
              },
            ),
          ),
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
  final String puzzleImage;
  final int rows;
  final int cols;

  const PuzzlePiece({
    Key? key,
    required this.piece,
    required this.isSelected,
    required this.onTap,
    required this.color,
    required this.puzzleImage,
    required this.rows,
    required this.cols,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int row = piece ~/ cols;
    int col = piece % cols;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 90,
        height: 90,
        margin: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Color(0xFFFFD700) : Colors.white,
            width: isSelected ? 4 : 2,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected 
                  ? Color(0xFFFFD700).withOpacity(0.6)
                  : Colors.black45,
              blurRadius: isSelected ? 12 : 6,
              spreadRadius: isSelected ? 2 : 0,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.fill,
              child: ClipRect(
                child: Align(
                  alignment: Alignment(
                    col == 0 ? -1.0 : (col == cols - 1 ? 1.0 : 0.0),
                    row == 0 ? -1.0 : (row == rows - 1 ? 1.0 : 0.0),
                  ),
                  widthFactor: 1 / cols,
                  heightFactor: 1 / rows,
                  child: Image.asset(
                    puzzleImage,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: color,
                        child: Center(
                          child: Text(
                            '${piece + 1}',
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
