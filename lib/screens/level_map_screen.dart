import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../models/level.dart';
import '../data/levels_data.dart';
import '../services/admob_service.dart';
import 'crystal_game_screen.dart';
import 'memory_game_screen.dart';
import 'color_game_screen.dart';
import 'puzzle_game_screen.dart';
import 'puzzle_hard_game_screen.dart';
import 'coloring_game_screen.dart';
import 'luma_coloring_screen.dart';
import 'balloon_pop_screen.dart';

class LevelMapScreen extends StatefulWidget {
  const LevelMapScreen({Key? key}) : super(key: key);

  @override
  _LevelMapScreenState createState() => _LevelMapScreenState();
}

class _LevelMapScreenState extends State<LevelMapScreen> {
  List<Level> levels = List.from(initialLevels);
  BannerAd? _bannerAd;
  final AdMobManager _adManager = AdMobManager();
  bool _isBannerAdLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadAds();
  }

  void _loadAds() {
    if (kIsWeb) return;
    
    // Banner ad yükle
    _bannerAd = _adManager.createBannerAd();
    _bannerAd?.load().then((_) {
      setState(() {
        _isBannerAdLoaded = true;
      });
    });
    
    // Interstitial ad hazırla
    _adManager.loadInterstitialAd();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    _adManager.dispose();
    super.dispose();
  }

  void onLevelComplete(int levelId) {
    setState(() {
      int index = levels.indexWhere((l) => l.id == levelId);
      if (index != -1) {
        levels[index].completed = true;
        // Bir sonraki seviyeyi aç
        if (index + 1 < levels.length) {
          levels[index + 1].locked = false;
        }
      }
    });
    
    // Her 2 seviyede bir reklam göster
    if (!kIsWeb && levelId % 2 == 0) {
      _adManager.showInterstitialAd();
    }
  }

  void startLevel(Level level) {
    if (level.locked) return;
    
    // Oyun tipine göre ekrana git
    if (level.type == 'crystal') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CrystalGameScreen(
            levelId: level.id,
            onComplete: () => onLevelComplete(level.id),
          ),
        ),
      );
    } else if (level.type == 'memory') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MemoryGameScreen(
            levelId: level.id,
            onComplete: () => onLevelComplete(level.id),
          ),
        ),
      );
    } else if (level.type == 'color') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ColorGameScreen(
            levelId: level.id,
            onComplete: () => onLevelComplete(level.id),
          ),
        ),
      );
    } else if (level.type == 'puzzle') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PuzzleGameScreen(
            levelId: level.id,
            onComplete: () => onLevelComplete(level.id),
          ),
        ),
      );
    } else if (level.type == 'puzzle_hard') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PuzzleHardGameScreen(
            levelId: level.id,
            onComplete: () => onLevelComplete(level.id),
          ),
        ),
      );
    } else if (level.type == 'coloring') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ColoringGameScreen(
            onComplete: () => onLevelComplete(level.id),
          ),
        ),
      );
    } else if (level.type == 'luma_coloring') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LumaColoringScreen(
            onComplete: () => onLevelComplete(level.id),
          ),
        ),
      );
    } else if (level.type == 'balloon') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BalloonPopScreen(
            onComplete: () => onLevelComplete(level.id),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg-forest.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF4A148C).withOpacity(0.4),
                Colors.transparent,
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.home, color: Colors.white, size: 32),
                        onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
                        tooltip: 'Ana Menü',
                      ),
                      Text(
                        'Büyülü Orman Haritası',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 48), // Balance için
                    ],
                  ),
                ),
                
                Expanded(
                  child: GridView.builder(
                    padding: EdgeInsets.all(20),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      childAspectRatio: 0.9,
                    ),
                    itemCount: levels.length,
                    itemBuilder: (context, index) {
                      final level = levels[index];
                      return LevelCard(
                        level: level,
                        onTap: () => startLevel(level),
                      );
                    },
                  ),
                ),
                
                // Banner Ad
                if (_isBannerAdLoaded && _bannerAd != null)
                  Container(
                    width: _bannerAd!.size.width.toDouble(),
                    height: _bannerAd!.size.height.toDouble(),
                    color: Colors.white,
                    child: AdWidget(ad: _bannerAd!),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LevelCard extends StatelessWidget {
  final Level level;
  final VoidCallback onTap;

  const LevelCard({
    Key? key,
    required this.level,
    required this.onTap,
  }) : super(key: key);

  String _getEmoji() {
    switch (level.type) {
      case 'crystal':
        return '💎';
      case 'memory':
        return '🃏';
      case 'color':
        return '🌈';
      case 'puzzle':
        return '🧩';
      case 'puzzle_hard':
        return '👧🐱';
      case 'coloring':
        return '🎨';
      case 'luma_coloring':
        return '🐱🎨';
      case 'balloon':
        return '🎈';
      case 'number':
        return '🔢';
      default:
        return '✨';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: level.locked ? null : onTap,
      child: Container(
        decoration: BoxDecoration(
          color: level.locked
              ? Colors.grey[800]!.withOpacity(0.7)
              : Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: level.completed
                ? Color(0xFFFFD700)
                : level.locked
                    ? Colors.grey
                    : Color(0xFF4A148C),
            width: 3,
          ),
          boxShadow: [
            BoxShadow(
              color: level.completed
                  ? Color(0xFFFFD700).withOpacity(0.5)
                  : Colors.black26,
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  level.locked ? '🔒' : level.completed ? '⭐' : _getEmoji(),
                  style: TextStyle(fontSize: 50),
                ),
                
                SizedBox(height: 10),
                
                Text(
                  level.name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: level.locked ? Colors.grey[400] : Color(0xFF4A148C),
                  ),
                  textAlign: TextAlign.center,
                ),
                
                SizedBox(height: 5),
                
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    level.description,
                    style: TextStyle(
                      fontSize: 12,
                      color: level.locked ? Colors.grey[500] : Colors.grey[700],
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            
            if (level.completed)
              Positioned(
                top: 10,
                right: 10,
                child: Icon(
                  Icons.check_circle,
                  color: Color(0xFFFFD700),
                  size: 30,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
