import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class MemoryGameScreen extends StatefulWidget {
  final int levelId;
  final VoidCallback onComplete;

  const MemoryGameScreen({
    Key? key,
    required this.levelId,
    required this.onComplete,
  }) : super(key: key);

  @override
  _MemoryGameScreenState createState() => _MemoryGameScreenState();
}

class _MemoryGameScreenState extends State<MemoryGameScreen> {
  List<MemoryCard> cards = [];
  List<int> selectedIndices = [];
  int matchedPairs = 0;
  int totalPairs = 6;
  bool isChecking = false;

  final List<String> emojis = ['🌟', '🌙', '🌈', '🦉', '🍄', '🌺'];

  @override
  void initState() {
    super.initState();
    initializeCards();
  }

  void initializeCards() {
    List<String> gameEmojis = [];
    for (var emoji in emojis) {
      gameEmojis.add(emoji);
      gameEmojis.add(emoji);
    }
    gameEmojis.shuffle(Random());

    cards = List.generate(
      gameEmojis.length,
      (index) => MemoryCard(
        id: index,
        emoji: gameEmojis[index],
        isFlipped: false,
        isMatched: false,
      ),
    );
    setState(() {});
  }

  void onCardTap(int index) {
    if (isChecking || 
        cards[index].isFlipped || 
        cards[index].isMatched || 
        selectedIndices.length >= 2) {
      return;
    }

    setState(() {
      cards[index].isFlipped = true;
      selectedIndices.add(index);
    });

    if (selectedIndices.length == 2) {
      isChecking = true;
      Timer(Duration(milliseconds: 800), checkMatch);
    }
  }

  void checkMatch() {
    int index1 = selectedIndices[0];
    int index2 = selectedIndices[1];

    if (cards[index1].emoji == cards[index2].emoji) {
      setState(() {
        cards[index1].isMatched = true;
        cards[index2].isMatched = true;
        matchedPairs++;
      });

      if (matchedPairs >= totalPairs) {
        Timer(Duration(milliseconds: 500), _showCompletionDialog);
      }
    } else {
      setState(() {
        cards[index1].isFlipped = false;
        cards[index2].isFlipped = false;
      });
    }

    selectedIndices.clear();
    isChecking = false;
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
                '🐱✨',
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
                'Hafızanı geri kazandın! Yola devam edebiliriz 🌟',
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
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1B5E20),
              Color(0xFF4CAF50),
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
                        'Hafıza Ormanı',
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
                'Eşleşmeleri Bul',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              
              SizedBox(height: 10),

              Text(
                '$matchedPairs / $totalPairs',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFFD700),
                ),
              ),

              SizedBox(height: 20),

              // Oyun alanı
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: cards.length,
                    itemBuilder: (context, index) {
                      return MemoryCardWidget(
                        card: cards[index],
                        onTap: () => onCardTap(index),
                      );
                    },
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

class MemoryCard {
  final int id;
  final String emoji;
  bool isFlipped;
  bool isMatched;

  MemoryCard({
    required this.id,
    required this.emoji,
    required this.isFlipped,
    required this.isMatched,
  });
}

class MemoryCardWidget extends StatelessWidget {
  final MemoryCard card;
  final VoidCallback onTap;

  const MemoryCardWidget({
    Key? key,
    required this.card,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: card.isMatched
              ? Color(0xFFFFD700).withOpacity(0.3)
              : card.isFlipped
                  ? Colors.white
                  : Color(0xFF1B5E20),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: card.isMatched
                ? Color(0xFFFFD700)
                : Colors.white.withOpacity(0.5),
            width: 3,
          ),
          boxShadow: [
            BoxShadow(
              color: card.isMatched
                  ? Color(0xFFFFD700).withOpacity(0.5)
                  : Colors.black26,
              blurRadius: 8,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Center(
          child: Text(
            card.isFlipped || card.isMatched ? card.emoji : '?',
            style: TextStyle(
              fontSize: card.isFlipped || card.isMatched ? 40 : 50,
              color: card.isFlipped || card.isMatched
                  ? Colors.black87
                  : Colors.white.withOpacity(0.7),
            ),
          ),
        ),
      ),
    );
  }
}
