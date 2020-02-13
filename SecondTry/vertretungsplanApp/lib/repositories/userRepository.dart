import 'package:flutter/cupertino.dart';
import 'package:vertretungsplanApp/customenums/ServerState.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vertretungsplanApp/resources/api.dart';

class UserRepository {
  Future<String> authenticate({
    @required String username,
    @required String password
  }) async {
    return await ApiProvider().loginUser(username, password);
  }

  Future<String> signUp({
    @required String firstname,
    @required String lastname,
    @required String email,
    @required String username,
    @required String password
  }) async {
    return await ApiProvider().registerUser(firstname, lastname, email, username, password);
  }

  Future<void> deleteToken() async {
    await deleteApiKey();
    return;
  }

  Future<void> persistToken(String token) async {
    await saveApiKey(token);
  }

  Future<ServerState> hasToken() async {
    String token = await getApiKey();
    return ApiProvider().checkApiToken(token);
  }

  deleteApiKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("API_Token", null);
  }

  saveApiKey(String apiKey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("API_Token", apiKey);
  }

  Future<String> getApiKey() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token;
    try{
      token = prefs.getString("API_Token");
    } catch (Exception) {
      token = "";
    }
    if(token == null){
      return "";
    }
    return token;
  }


}