import 'dart:async';
import 'package:http/http.dart' show Client;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:todoapp/models/classes/user.dart';
//import 'package:fluttertoast/fluttertoast.dart';

class ApiProvider {
  Client client = new Client();
  // final _apiKey = 'your_api_key';

  Future<String> getData(String apiKey) async {
    final response = await client
      .get("http://niggelgame.pythonanywhere.com/api/data",//"http://10.0.2.2:5000/api/data",
      headers: {
        "Authorization": apiKey
      });
    print(response.statusCode.toString());
    if(response.statusCode == 201){
      return response.body.toString();
    }

    return null;
    
  }

  Future<bool> signinUser(String username, String password, String apiKey) async {
    print("\n\n\n\nentered\n\n\n");
    try{
      final response = await client
        .post("http://niggelgame.pythonanywhere.com/api/signin",//"http://10.0.2.2:5000/api/signin",
        headers: {
          "Authorization": apiKey
        },
        body: jsonEncode({
	        "username": username,
          "password": password,
        }) );
        final Map result = json.decode(response.body);
        // print(result["data"].toString());
        print(response.statusCode.toString());
        if (response.statusCode == 201) {
          // If the call to the server was successful, parse the JSON
          // print(result["data"]);
          await saveApiKey(result["data"]["api_key"]);
          return true;
          
        } else {
          // If that call was not successful, throw an error.
          // print(result["data"]);
          //throw Exception('Failed to load post');
          print("falsch!!!");
          // Fluttertoast.showToast(
          //   msg: "Falscher Benutzername oder Password",
          //   toastLength: Toast.LENGTH_SHORT,
          //   gravity: ToastGravity.CENTER,
          //   timeInSecForIos: 1,
            
          //   fontSize: 16.0
          // );
          return false;
        } 
    
    } catch (e) {
      // Fluttertoast.showToast(
      //       msg: "Keine Verbindung zum Server!",
      //       toastLength: Toast.LENGTH_SHORT,
      //       gravity: ToastGravity.CENTER,
      //       timeInSecForIos: 1,
            
      //       fontSize: 16.0
      //     );
      //     return false;
    }
  }

  Future<User> registerUser(String username, String firstname, String lastname, String password, String email) async {
    // print("\n\n\n\nentered\n\n\n");
    final response = await client
        .post("http://niggelgame.pythonanywhere.com/api/register",//"http://10.0.2.2:5000/api/register",
        //headers: {""},
        body: jsonEncode({
          "emailadress": email,
	        "username": username,
          "password": password,
          "firstname": firstname,
          "lastname": lastname
        }) );
    final Map result = json.decode(response.body);
    // print(result["data"].toString());
    print(response.statusCode.toString());
    if (response.statusCode == 201) {
      // If the call to the server was successful, parse the JSON
      await saveApiKey(result["data"]["api_key"]);
      return User.fromJson(result["data"]);
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }



  saveApiKey(String apikey) async {
    
    SharedPreferences prefs = await SharedPreferences.getInstance();  
    prefs.setString('API_Token', apikey);
    
  }
}