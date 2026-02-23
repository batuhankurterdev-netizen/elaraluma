# Google Play için paket hazırlama

Aşağıdaki adımlar uygulamayı Play Store'a yüklemek üzere imzalanmış bir AAB (App Bundle) üretmenize yardımcı olur.

1) Keystore (imza anahtarı) oluşturma

Windows/macOS/Linux terminalinde (Java JDK kurulu olmalı):

```bash
# android/ dizinine gidin
cd android

# Aşağıdaki komut sizin için bir keystore oluşturur (parolaları kendinize göre değiştirin)
keytool -genkey -v -keystore key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias elaraluma
```

Komut çalışınca sizden ad-soyad, organizasyon vb. ve parolalar istenecektir. `key.jks` dosyası `android/` klasöründe oluşturulacak.

2) `android/key.properties` dosyası oluşturma

`android/key.properties.template` dosyasını kopyalayarak `android/key.properties` oluşturun ve içini doldurun:

```
storeFile=key.jks
storePassword=BU_SENIN_STORE_PAROLAN
keyPassword=BU_SENIN_KEY_PAROLAN
keyAlias=elaraluma
```

`key.properties` dosyasını sürüm kontrolüne eklemeyin (ör. `.gitignore` ile dışlayın).

3) Play için AAB üretme

Proje kökünde çalıştırın:

```bash
flutter build appbundle --release
```

Üretim başarılı olursa `build/app/outputs/bundle/release/app.aab` oluşacaktır; bunu Play Console'a yükleyin.

Notlar:
- Play Console artık uygulamanızı yüklediğinizde bir "upload key" ve "app signing key" düzenler; detaylar için Play Console belgelerine bakın.
- Web sürümünde otomatik çalma gibi farklı davranışlar tarayıcı politikalarına bağlıdır.
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
