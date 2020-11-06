import 'package:shared_preferences/shared_preferences.dart';



/**
 * Singleton class for storing sharedPreferrence instance
 * you can access it without using async/await methodology
 */
class StorageService {
  SharedPreferences _storage;

  registerService() async {
    _storage = await SharedPreferences.getInstance();
  }
  SharedPreferences get getStorage => _storage;

  StorageService._();
  static final _instance = StorageService._();
  factory StorageService.instance() => _instance;


  /// @key,value 
  /// accepts a map save all key and values
  void saveTempData(Map args){
    args.forEach((key,value) {
      _storage.setString(key, value);
    });
  }


}
