import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:ftp_app/model/data_model.dart';

const MaterialColor primaryColor = const MaterialColor(
  0xFF80379B,
  const <int, Color>{
    50: const Color(0xFF6b47ff),
    100: const Color(0xFF6b47ff),
    200: const Color(0xFF6b47ff),
    300: const Color(0xFF6b47ff),
    400: const Color(0xFF6b47ff),
    500: const Color(0xFF6b47ff),
    600: const Color(0xFF6b47ff),
    700: const Color(0xFF6b47ff),
    800: const Color(0xFF6b47ff),
    900: const Color(0xFF6b47ff),
  },
);

DataModel getDecryptedData(String data){
  final key =
  encrypt.Key.fromBase64("Jn0evvsplJkGmXSRwoNo252vogmqwfZOqa3tFi6NgOA=");

  final iv = encrypt.IV.fromBase64("08rxdn/twix5AIm0YMBetQ==");

  final encrypter = encrypt.Encrypter(
      encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: 'PKCS7'));
  final decrypted = encrypter.decrypt64(data, iv: iv);
  return DataModel.fromJson(jsonDecode(decrypted));
}