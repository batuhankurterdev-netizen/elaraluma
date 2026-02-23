import 'package:flutter/material.dart';

class StoryScreen extends StatefulWidget {
  const StoryScreen({Key? key}) : super(key: key);

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  int currentPage = 0;
  
  final List<Map<String, String>> storyPages = [
    {
      'text': 'Elara, sabahları güneş ışığıyla uyanmayı severdi. Her sabah, eski taş evlerinin çatısından sızan yumuşak ışık, yüzüne dans ederek düşerdi.',
      'emoji': '🌅',
    },
    {
      'text': 'Bu ev, büyükannesinden kalmaydı. İçinde zaman durmuş gibiydi; gıcırdayan ahşap merdivenler, çatlamış duvar boyaları ve bir köşede yavaşça tıkırdayan eski saat…',
      'emoji': '🏚️',
    },
    {
      'text': 'Gözlüğünü burnunun ucuna yerleştirip saçlarını kabaca bir tokayla toparladı. Uzun, turuncu, kıvırcık saçları ne yapsa söz dinlemezdi zaten.',
      'emoji': '👧',
    },
    {
      'text': 'Elara\'nın en çok sevdiği şey, eski eşyaları tamir etmekti. Bir çaydanlık kapağını yerleştirir, kırık bir kol saati onarır, çatlamış bir kuklaya ip eklerdi.',
      'emoji': '🔧',
    },
    {
      'text': 'Ama bu sabah bir şey farklıydı. Evin içinde alışık olmadığı bir sessizlik vardı. Sanki zaman, bir anlığına nefesini tutmuş gibiydi.',
      'emoji': '⏰',
    },
    {
      'text': 'Pencere kenarındaki yastığın üstünde, Luma oturuyordu. Elara\'nın siyah kedisi. Ama sıradan bir kedi değildi o.',
      'emoji': '🐱',
    },
    {
      'text': 'Simsiyah tüylerinin arasında parıldayan minicik tozlar vardı; sanki gece gökyüzünden kopup gelmişti. Gözleri kehribar rengiyle ışıldardı.',
      'emoji': '✨',
    },
    {
      'text': 'Luma bu sabah da cam kenarında oturmuş, gökyüzüne bakıyordu. Kulakları yıldızların şarkısını dinliyormuş gibi hafifçe kıpırdıyor, kuyruğu ritmik bir şekilde sallanıyordu.',
      'emoji': '🌌',
    },
    {
      'text': 'Elara usulca yaklaştı, pencereye birlikte baktılar. Uzakta, köyün ortasındaki eski saat kulesi, sessizce ve hareketsiz duruyordu.',
      'emoji': '🗼',
    },
    {
      'text': 'Birden, Luma başını Elara\'ya çevirdi. Göz göze geldiler. O an bir şey oldu. Sanki evin içindeki hava bir anlığına kıpırtısızlaştı.',
      'emoji': '👁️',
    },
    {
      'text': 'Ve Luma konuştu.\n\nSesi yıldızlar kadar yumuşak, gece kadar sakindi:\n\n"Elara… artık zamanı geldi."',
      'emoji': '💫',
    },
    {
      'text': 'Elara\'nın gözleri kocaman açıldı. Bir şey söylemek istedi ama kelimeler boğazına düğümlendi.\n\nLuma başını hafifçe yana eğdi.\n\n"Şaşırma. Her şeyin bir zamanı vardır. Ve şimdi… seninle konuşmam gerekiyordu."',
      'emoji': '😮',
    },
    {
      'text': 'Elara sadece bakabildi. Kalbi pır pır atıyor, avuç içleri terliyordu.\n\nO, kedisinin... konuştuğunu duymuştu.',
      'emoji': '💗',
    },
    {
      'text': 'Ve işte o an, Elara\'nın bildiği dünya değişmeye başladı.\n\nKüçük şeylerin büyük anlamlar taşıdığı, yıldızların fısıldadığı ve zamanın yeniden akmaya başlayacağı o yolculuk, sessiz bir pencere kenarında başladı.',
      'emoji': '🌟',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
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
              // Başlık
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Expanded(
                      child: Text(
                        'Hikaye',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: 48),
                  ],
                ),
              ),
              
              // Sayfa göstergesi
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  '${currentPage + 1} / ${storyPages.length}',
                  style: TextStyle(
                    color: Color(0xFFffd700),
                    fontSize: 16,
                  ),
                ),
              ),
              
              // Hikaye içeriği
              Expanded(
                child: PageView.builder(
                  itemCount: storyPages.length,
                  onPageChanged: (index) {
                    setState(() {
                      currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Emoji
                          Text(
                            storyPages[index]['emoji']!,
                            style: TextStyle(fontSize: 80),
                          ),
                          SizedBox(height: 40),
                          
                          // Hikaye metni
                          Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Color(0xFFffd700).withOpacity(0.3),
                                width: 2,
                              ),
                            ),
                            child: Text(
                              storyPages[index]['text']!,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                height: 1.6,
                                letterSpacing: 0.5,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              
              // Sayfa noktaları
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    storyPages.length,
                    (index) => Container(
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      width: currentPage == index ? 12 : 8,
                      height: currentPage == index ? 12 : 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: currentPage == index
                            ? Color(0xFFffd700)
                            : Colors.white.withOpacity(0.3),
                      ),
                    ),
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
