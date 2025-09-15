import 'dart:convert';
import 'dart:io';

import 'package:encrypt/encrypt.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:path_provider/path_provider.dart';

class EncryptionModel {
  // Your secret key (must match the Laravel decryption key)
  static final secretKey = dotenv.get('SECRET_KEY');
  // final secretKey = 'aw62h3ioeRB9K2rnFFVQ+bohzZo4gl0x/u8OaXbRoFM=';

  String encryptData(Map<String, dynamic> data) {
    // Decode the Base64 secret key
    final key = Key(base64Decode(secretKey));
    // final key = Key.fromUtf8(secretKey);

    // Create an encrypter with AES, using ECB mode and PKCS7 padding
    final encrypter = Encrypter(AES(key, mode: AESMode.ecb, padding: 'PKCS7'));

    // Convert the JSON data to a string
    final jsonData = jsonEncode(data);

    // Encrypt the data
    final encrypted = encrypter.encrypt(jsonData);

    // Return the encrypted data as a Base64 encoded string
    return encrypted.base64;
  }

  String decryptData(String encryptedData) {
    // Decode the Base64 secret key
    final key = Key(base64Decode(secretKey));

    // Create an encrypter with AES, using ECB mode and PKCS7 padding
    final encrypter = Encrypter(AES(key, mode: AESMode.ecb, padding: 'PKCS7'));

    // Decrypt the data
    final decrypted = encrypter.decrypt64(encryptedData);

    // Return the decrypted data as a JSON string
    return decrypted;
  }

  static String encryptImage(File imageFile) {
    // Decode the Base64 secret key
    final key = Key(base64Decode(secretKey));

    // Create an encrypter with AES, using ECB mode and PKCS7 padding
    final encrypter = Encrypter(AES(key, mode: AESMode.ecb, padding: 'PKCS7'));

    // Read the image as bytes
    final imageBytes = imageFile.readAsBytesSync();

    // Encrypt the image bytes
    final encrypted = encrypter.encryptBytes(imageBytes);

    // Return the encrypted data as a Base64 encoded string
    return encrypted.base64;
  }

  static Future<File> decryptImage(String encryptedBase64) async {
    // Decode the Base64 secret key
    final key = Key(base64Decode(secretKey));

    // Create an encrypter with AES, using ECB mode and PKCS7 padding
    final encrypter = Encrypter(AES(key, mode: AESMode.ecb, padding: 'PKCS7'));

    // Decode the Base64 encrypted image data to bytes
    final encryptedBytes = base64Decode(encryptedBase64);

    // Decrypt the bytes
    final decryptedBytes = encrypter.decryptBytes(Encrypted(encryptedBytes));

    // Get the cache directory
    final cacheDir = await getTemporaryDirectory();
    final outputPath = '${cacheDir.path}/decrypted_image.jpg';

    // Save the decrypted bytes as an image file in the cache directory
    File outputFile = File(outputPath);
    await outputFile.writeAsBytes(decryptedBytes);

    return outputFile;
  }
}
