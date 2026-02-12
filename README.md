# Elaraluma Oyun (Flutter)

Bu repo React Native projesinden taşınmış temel Flutter UI bileşenlerini içerir.

Gereksinimler
- Flutter SDK (stable)
- Android SDK (komut satırı araçları)
- Java JDK 11 veya üstü

Hızlı başlatma

```
flutter pub get
flutter run
```

Android için release AAB oluşturma

```
# (1) Keystore oluşturun (örneğin):
keytool -genkey -v -keystore ~/elaraluma-key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias elaraluma

# (2) Projeye anahtar bilgilerini ekleyin (android/key.properties)
# (3) AAB oluşturun:
flutter build appbundle --release
```

Daha fazla bilgi için `RELEASE.md` dosyasına bakın.

CI (GitHub Actions) ile AAB oluşturma (Android Studio gerekmez)

1) GitHub deposuna push edin.
2) Repository > Settings > Secrets bölümüne aşağıdaki secret'leri ekleyin (release imzalama için):
	- `KEYSTORE_BASE64` : `elaraluma-key.jks` dosyasının base64 kodlanmış içeriği
	- `KEYSTORE_PASSWORD`
	- `KEY_ALIAS`
	- `KEY_PASSWORD`

`KEYSTORE_BASE64` oluşturmak için (Linux/mac):
```bash
base64 -w0 elaraluma-key.jks > keystore.b64
```
Windows (PowerShell):
```powershell
[Convert]::ToBase64String([IO.File]::ReadAllBytes('C:\path\to\elaraluma-key.jks')) > keystore.b64
```

3) GitHub Actions -> Actions -> `Build Flutter AAB` workflow'unu çalıştırın (workflow otomatik olarak keystore varsa kullanır).

Oluşan AAB artefaktını Actions arayüzünden indirip Play Console'a yükleyebilirsiniz.
