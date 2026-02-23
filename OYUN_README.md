# 🌟 Elara ve Luma Oyunu

Elara ve Luma'nın büyülü dünyasında geçen eğlenceli ve eğitici çocuk oyunu!

## 📖 Hikaye

Elara ve Luma büyülü bir dünyada yaşıyor. Luma siyah büyülü bir kedi, konuşabiliyor ve yıldız tozları var. Elara ise küçük bir kız çocuğu, unutulan anıları canlandırıyor.

## 🎮 Oyun Özellikleri

### 1. 📚 Hikaye Modu
- Elara ve Luma'nın hikayesini okuyun
- Sayfa sayfa ilerleyin
- Güzel görseller eşliğinde

### 2. ✨ Yıldız Tozu Toplama
- Ekranda beliren yıldız tozlarını toplayın
- 30 saniye içinde en çok puanı kazanın
- Luma'nın büyülü tozlarını yakalayın

### 3. 🔧 Eşya Tamir Etme
- Eski eşyaları tamir edin
- Parçaları sürükle-bırak ile yerleştirin
- Her seviyede farklı eşyalar

## 💰 Reklam Sistemi

### Reklam Türleri:
- **Banner Reklamlar**: Ekranın alt kısmında (isteğe bağlı)
- **Interstitial Reklamlar**: Her 3 oyunda bir gösterilir
- **Rewarded Reklamlar**: İzleyince +10 bonus yıldız kazanırsınız

### COPPA Uyumluluğu
Çocuk odaklı içerik olduğu için COPPA uyumlu ayarlar kullanılmaktadır.

## 🚀 Kurulum ve Çalıştırma

### Gereksinimler:
- Flutter SDK (3.0 veya üzeri)
- Android Studio veya VS Code
- Android SDK

### Adımlar:

1. **Bağımlılıkları yükleyin:**
```bash
flutter pub get
```

2. **Uygulamayı çalıştırın:**
```bash
flutter run
```

## 📱 Play Store'a Yüklemek

### 1. AdMob Hesabı Oluşturun
1. [AdMob](https://admob.google.com) hesabı açın
2. Yeni uygulama ekleyin
3. Reklam birimleri oluşturun (Banner, Interstitial, Rewarded)
4. Uygulama ID'sini ve Reklam Birim ID'lerini alın

### 2. AdMob ID'lerini Değiştirin

**android/app/src/main/AndroidManifest.xml:**
```xml
<meta-data
    android:name="com.google.android.gms.ads.APPLICATION_ID"
    android:value="GERÇEKAdMobUygulamaID"/>
```

**lib/services/admob_service.dart:**
- `bannerAdUnitId` değerini değiştirin
- `interstitialAdUnitId` değerini değiştirin
- `rewardedAdUnitId` değerını değiştirin

### 3. Karakter Görsellerini Ekleyin

1. Elara ve Luma görsellerini `assets/images/` klasörüne ekleyin:
   - `elara.png`
   - `luma.png`

2. **lib/screens/game_menu_screen.dart** dosyasında emoji yerine görselleri kullanın:
```dart
// Emoji yerine:
Image.asset('assets/images/elara.png', width: 80, height: 80),
Image.asset('assets/images/luma.png', width: 80, height: 80),
```

### 4. Uygulama İkonu Değiştirin

1. [App Icon Generator](https://www.appicon.co/) kullanarak ikon oluşturun
2. `android/app/src/main/res/` klasörüne kopyalayın

### 5. Build Alın

**Android APK:**
```bash
flutter build apk --release
```

**Android App Bundle (Play Store için önerilen):**
```bash
flutter build appbundle --release
```

### 6. Keystore Oluşturun (İlk kez için)

```bash
keytool -genkey -v -keystore ~/elaraluma-key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias elaraluma
```

**android/key.properties** dosyası oluşturun:
```
storePassword=ŞİFRENİZ
keyPassword=ŞİFRENİZ
keyAlias=elaraluma
storeFile=../elaraluma-key.jks
```

**android/app/build.gradle** dosyasında signing yapılandırması:
```gradle
def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}

android {
    ...
    signingConfigs {
        release {
            keyAlias keystoreProperties['keyAlias']
            keyPassword keystoreProperties['keyPassword']
            storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
            storePassword keystoreProperties['storePassword']
        }
    }
    buildTypes {
        release {
            signingConfig signingConfigs.release
        }
    }
}
```

### 7. Play Console'da Uygulama Oluşturun

1. [Google Play Console](https://play.google.com/console) hesabı açın
2. Yeni uygulama oluşturun
3. Uygulama bilgilerini doldurun
4. Ekran görüntüleri ekleyin (en az 2 adet)
5. Gizlilik politikası URL'si ekleyin
6. İçerik derecelendirmesi alın (Çocuk/Aile kategorisi seçin)
7. AAB dosyasını yükleyin
8. İncelemeye gönderin

### 8. Önemli Notlar

- **Çocuk kategorisi** seçildiği için ek gereksinimler var
- **COPPA** uyumluluğu gerekli
- Gizlilik politikası zorunlu
- Reklamlar çocuk dostu olmalı
- Yaş sınırlaması belirtin (3+ veya 6+)

## 🎨 Özelleştirme

### Renkleri Değiştirme
**lib/screens/** dosyalarında renk kodlarını değiştirebilirsiniz:
- `Color(0xFFffd700)` - Altın sarısı (yıldızlar)
- `Color(0xFFff6b9d)` - Pembe (Elara)
- `Color(0xFF4ecdc4)` - Turkuaz (tamir)

### Yeni Hikaye Sayfaları Eklemek
**lib/screens/story_screen.dart** içinde `storyPages` listesine ekleyin:
```dart
{
  'text': 'Yeni hikaye metni...',
  'emoji': '🌟',
},
```

### Yeni Tamir Eşyaları
**lib/screens/repair_game_screen.dart** içinde `items` listesine ekleyin:
```dart
RepairItem(name: 'Yeni Eşya', emoji: '🎁', broken: '📦', difficulty: 2),
```

## 📊 Kazanç Optimizasyonu

1. **Rewarded reklamları** en çok kazanç sağlar
2. **Interstitial** sıklığını ayarlayın (çok sık göstermeyin)
3. **Banner** reklamlar sürekli gelir sağlar
4. Kullanıcı deneyimini bozmayın

## 🐛 Sorun Giderme

**Reklamlar gösterilmiyor:**
- Test ID'leri gerçek ID'lerle değiştirin
- İnternet bağlantısını kontrol edin
- AdMob hesabınızın aktif olduğundan emin olun

**Build hatası:**
- `flutter clean` çalıştırın
- `flutter pub get` tekrar yapın
- Android SDK'nın güncel olduğundan emin olun

## 📝 Lisans

Bu proje Mukaddes Kurter tarafından geliştirilmiştir.

## 📧 İletişim

Sorularınız için: mukaddeskurter@example.com

---

**Başarılar! 🎉**
