import '../models/level.dart';

final List<Level> initialLevels = [
  Level(
    id: 1,
    name: 'Kristal Vadisi',
    description: 'Elara ve Luma\'nın yolu kristallerle aydınlanıyor',
    type: 'crystal',
    locked: false,
  ),
  Level(
    id: 2,
    name: 'Hafıza Ormanı',
    description: 'Luma\'nın hafızası ormanda kayboldu, ona yardım et',
    type: 'memory',
    locked: false,
  ),
  Level(
    id: 3,
    name: 'Renk Köprüsü',
    description: 'Gökkuşağı köprüsünü geçmek için renkleri eşleştir',
    type: 'color',
    locked: false,
  ),
  Level(
    id: 4,
    name: 'Sihirli Yapboz',
    description: 'Kayıp portali bulmak için yapbozu tamamla',
    type: 'puzzle',
    locked: false,
  ),
  Level(
    id: 5,
    name: 'Elara & Luma Yapbozu',
    description: '16 parçalı büyük yapbozu tamamla!',
    type: 'puzzle_hard',
    locked: false,
  ),
  Level(
    id: 6,
    name: 'Renk Atölyesi',
    description: 'Elara ile birlikte renkleri öğren ve boya!',
    type: 'coloring',
    locked: false,
  ),
  Level(
    id: 7,
    name: 'Luma\'yı Boya',
    description: 'Büyülü kediyi renklendir ve hayat ver!',
    type: 'luma_coloring',
    locked: false,
  ),
  Level(
    id: 8,
    name: 'Balon Şenliği',
    description: 'Uçan balonları patlatarak eğlen!',
    type: 'balloon',
    locked: false,
  ),
];
