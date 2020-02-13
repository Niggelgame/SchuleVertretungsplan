

import 'dart:convert';

import 'package:http/http.dart';
import 'package:vertretungsplanApp/customenums/ServerState.dart';


class ApiProvider{
  Client client = new Client();
  String groundURL = "https://niggelgame.pythonanywhere.com/api";
  Future<String> registerUser(String firstname, String lastname, String email, String username, String password) async{
    if(firstname.isEmpty || lastname.isEmpty || email.isEmpty || username.isEmpty || password.isEmpty){
      throw Exception("You have to enter Text in every field");
    }
    if(!RegExp(r"(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)").hasMatch(email)){
      throw Exception("You have to enter a valid email adress!");
    }
    
    final response = await client
      .post(groundURL + "/register",
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "firstname": firstname,
	      "lastname": lastname,
        "username": username,
        "email": email,
        "password": password
      })
    );
    final Map result = json.decode(response.body);
    print(response.statusCode);
    if(response.statusCode == 201){
      //print(result["api_key"]);
      //saveApiKey(result["api_key"]);
      return result["data"]["api_key"];
    } else if(response.statusCode == 409){
      throw Exception(result["error"]);
    } else{
      throw Exception("Something went wrong while signing up!");
      print(result);
    }

  }


  Future<String> loginUser(String username, String password) async {
    final response = await client
      .post(groundURL + "/signin",
      headers: {"Content-Type": "application/json", "Authorization": ""},
      body: jsonEncode({
        "username": username,
        "password": password
        })
      );
    final Map result = jsonDecode(response.body);
    print(response.statusCode);
    if(response.statusCode == 202){
      //saveApiKey(result["api_key"]);
      print(result["data"]["api_key"]);
      return result["data"]["api_key"];
    } else if(response.statusCode == 401) {
      throw Exception("Wrong Password or username");
      print(result);
    } else {
      throw Exception("Something went wrong while trying to log in!");
    }
  }


  Future<ServerState> checkApiToken(String apiKey) async {
    try{
      final response = await client
        .post(groundURL + "/signin",
        headers: {"Content-Type": "application/json", "Authorization": apiKey},
        body: jsonEncode({
        "username": "",
        "password": ""
        })
        );
        
      final Map result = jsonDecode(response.body);
      print(response.statusCode);
      if(response.statusCode == 202){
        return ServerState.authed;
      } else if (response.statusCode == 401){
        return ServerState.unauthed;
      } else {
        return await checkApiToken(apiKey);
      }
    } catch (error) { 
        client.close();
        
        return ServerState.noConnection;
    }
  }



}