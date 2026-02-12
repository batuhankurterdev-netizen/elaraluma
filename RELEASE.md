Android release (Keystore ve AAB oluşturma)

1) Gereksinimler
- Flutter SDK
- Android SDK (platform-tools, build-tools)
- Java JDK (11+)

2) Keystore oluşturma (örnek):

```bash
keytool -genkey -v -keystore C:\Users\<kullanici>\elaraluma-key.jks -alias elaraluma -keyalg RSA -keysize 2048 -validity 10000
```

3) `android/key.properties` dosyası oluşturun (Android klasöründe değil proje kökünde):

```
storePassword=<keystore-parolasi>
keyPassword=<anahtar-parolasi>
keyAlias=elaraluma
storeFile=C:\Users\<kullanici>\elaraluma-key.jks
```

Not: Projeye örnek olarak `key.properties.example` eklendi. Gerçek imzalama için bu dosyanın bir kopyasını `key.properties` adıyla proje köküne koyup değerleri doldurun.

4) `android/app/build.gradle` içine signingConfigs ve release yapılandırmasını ekleyin (örnek):

```gradle
def keystorePropertiesFile = rootProject.file('key.properties')
def keystoreProperties = new Properties()
keystoreProperties.load(new FileInputStream(keystorePropertiesFile))

android {
  // ...
  signingConfigs {
    release {
      keyAlias keystoreProperties['keyAlias']
      keyPassword keystoreProperties['keyPassword']
      storeFile file(keystoreProperties['storeFile'])
      storePassword keystoreProperties['storePassword']
    }
  }
  buildTypes {
    release {
      signingConfig signingConfigs.release
      shrinkResources false
      minifyEnabled false
    }
  }
}
```

5) AAB oluşturma (komut satırı, Android Studio gerekmez):

```bash
flutter build appbundle --release
```

6) Oluşan dosya: `build/app/outputs/bundle/release/app-release.aab` — bu dosyayı Google Play Console'a yükleyin.

7) Notlar
- Play Console'da uygulama bilgilerini (paket adı, görseller, politikalar) hazırlayın.
- Uygulamanın paket adını `android/app/src/main/AndroidManifest.xml` ve `android/app/build.gradle` içinde kontrol edin.
