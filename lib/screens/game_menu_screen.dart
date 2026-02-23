import 'package:flutter/material.dart';
import 'stardust_game_screen.dart';
import 'repair_game_screen.dart';
import 'story_screen.dart';

class GameMenuScreen extends StatelessWidget {
  const GameMenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1a1a2e),
              Color(0xFF16213e),
              Color(0xFF0f3460),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 40),
              // Başlık
              Text(
                'Elara ve Luma',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Color(0xFFffd700),
                      blurRadius: 20,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Büyülü Dünya',
                style: TextStyle(
                  fontSize: 24,
                  color: Color(0xFFffd700),
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(height: 60),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildCharacterCard(
                    'Elara',
                    'assets/images/elara.png',
                    '👧✨',
                    Color(0xFFff6b9d),
                  ),
                  _buildCharacterCard(
                    'Luma',
                    'assets/images/luma.png',
                    '🐱✨',
                    Color(0xFF2d2d2d),
                  ),
                ],
              ),
              
              SizedBox(height: 60),
              
              // Oyun menü butonları
              _buildMenuButton(
                context,
                'Hikaye',
                Icons.book,
                Color(0xFFff6b9d),
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StoryScreen()),
                ),
              ),
              SizedBox(height: 20),
              _buildMenuButton(
                context,
                'Yıldız Tozu Toplama',
                Icons.star,
                Color(0xFFffd700),
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StardustGameScreen()),
                ),
              ),
              SizedBox(height: 20),
              _buildMenuButton(
                context,
                'Eşya Tamir Et',
                Icons.build,
                Color(0xFF4ecdc4),
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RepairGameScreen()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCharacterCard(String name, String imagePath, String fallbackEmoji, Color color) {
    return Container(
      width: 120,
      height: 140,
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color, width: 2),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 15,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              imagePath,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                // Görsel yoksa emoji göster
                return Text(
                  fallbackEmoji,
                  style: TextStyle(fontSize: 60),
                );
              },
            ),
          ),
          SizedBox(height: 10),
          Text(
            name,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuButton(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: 70,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color,
              color.withOpacity(0.7),
            ],
          ),
          borderRadius: BorderRadius.circular(35),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.4),
              blurRadius: 15,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 30),
            SizedBox(width: 15),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
