import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorageSecurity {
  final _storage = const FlutterSecureStorage();
  static const _authKeyId = 'authId';
  static const _authKeyToken = 'authToken';
  static const _authKeyFullName = 'authFullName';
  static const _authKeyAddress = 'authAddress';
  static const _authKeyProfile = 'authProfile';
  static const _authPhone = 'authKeyPhone';



  Future<void> saveAuthPhone(String phone) async {
    await _storage.write(key: _authPhone, value: phone);
  }

  Future<String?> getAuthPhone() async {
    return  _storage.read(key: _authPhone);
  }

  Future<void> deleteAuthPhone() async {
    await _storage.delete(key: _authPhone);
  }



  Future<void> saveAuthId(String id) async {
    await _storage.write(key: _authKeyId, value: id);
  }

  Future<String?> getAuthId() async {
    return  _storage.read(key: _authKeyId);
  }

  Future<void> deleteAuthId() async {
    await _storage.delete(key: _authKeyId);
  }


  Future<void> saveAuthToken(String token) async {
    await _storage.write(key: _authKeyToken, value: token);
  }

  Future<String?> getToken() async {
    return  _storage.read(key: _authKeyToken);
  }

  Future<void> deleteAuthToken() async {
    await _storage.delete(key: _authKeyToken);
  }

  Future<void> saveAuthFullName(String fullName) async {
    await _storage.write(key: _authKeyFullName, value: fullName);
  }

  Future<String?> getAuthFullName() async {
    return  _storage.read(key: _authKeyFullName);
  }

  Future<void> deleteAuthFullName() async {
    await _storage.delete(key: _authKeyFullName);
  }




  Future<void> saveAuthProfile(String profile) async {
    await _storage.write(key: _authKeyProfile, value: profile);
  }

  Future<String?> getAuthProfile() async {
    return  _storage.read(key: _authKeyProfile);
  }

  Future<void> deleteAuthProfile() async {
    await _storage.delete(key: _authKeyProfile);
  }


  Future<void> saveAuthAddress(String address) async {
    await _storage.write(key: _authKeyAddress, value: address);
  }

  Future<String?> getAuthAddress() async {
    return  _storage.read(key: _authKeyAddress);
  }

  Future<void> deleteAuthAddress() async {
    await _storage.delete(key: _authKeyAddress);
  }

   Future<void> clearAllExceptFirstOpenAppStorage() async {
    await _storage.deleteAll();

  }

}
