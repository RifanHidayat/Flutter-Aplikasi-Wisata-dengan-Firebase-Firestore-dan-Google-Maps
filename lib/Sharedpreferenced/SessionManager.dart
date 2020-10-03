import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  void saveData(int value,String id, String nama,email,photo) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt("value", value);
    sharedPreferences.setString("nama", nama);
    sharedPreferences.setString("email", email);
    sharedPreferences.setString("photo", photo);
    sharedPreferences.setString("uid", id);
  }
  void logout() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.remove("value");
    sharedPreferences.remove("nama");
    sharedPreferences.remove("photo");
    sharedPreferences.remove("uid");
    sharedPreferences.remove("email");

  }
void onBoardingof() async{
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setInt("shared", 1);


}

  }

