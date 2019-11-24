import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/models/global.dart';
import 'package:webview_flutter/webview_flutter.dart';

class IntrayPage extends StatefulWidget {
  @override
  _IntrayPageState createState() => _IntrayPageState();
}

class _IntrayPageState extends State<IntrayPage> {
  
  bool _isLoadingPage = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: darkGreyColor,
      child: _buildHomePage(context),
      // child: ReorderableListView(
      //   padding: EdgeInsets.only(top: 300),
      //   children: todoItems,
      //   onReorder: _onReorder,
      // ),
    );
  }

  Widget _buildHomePage(BuildContext context){
    
    final Completer<WebViewController> _controller =
  Completer<WebViewController>();
    //WebViewController _controller;
    return Theme(
      data: ThemeData.dark(),
      
      child: Container(
        color: Colors.white,
          child: Container(
          //padding: EdgeInsets.only(top: 300),
          margin: EdgeInsets.only(top: 90),
          color: Colors.green,
          child: Scaffold(
            body: Stack(
              children: <Widget>[
                FutureBuilder<String>(
                  future: getApiToken(),
                  builder:(BuildContext context, AsyncSnapshot snapshot){ 

                    if(snapshot.hasData){
                      return WebView(
                      
                        //initialUrl: "https://pub.dev/packages/webview_flutter#-installing-tab-",

                        
                        javascriptMode: JavascriptMode.unrestricted,
                        onWebViewCreated: (WebViewController webViewController) {
                          
                          print(_controller);
                          webViewController.loadUrl("http://niggelgame.pythonanywhere.com/api/data",//"http://10.0.2.2:5000/api/data",
                           headers: {
                            "Authorization": snapshot.data
                          }).whenComplete(() {
                            
                            //print("HEYHOOOOOO\n\n\n\n\n\n");
                            setState(() {
                              _isLoadingPage = false;
                            });
                            
                            //print(_controller);
                          });

                          _controller.complete(webViewController);
                      
                        },
                      );
                    } else {
                      return Container(
                        child: Center(
                          child: Text("Bitte melden Sie sich neu an, da die Daten sonst nicht geladen werden können. Bitte überprüfen Sie auch ihr Internetverbindung", style: redTodoTitle,),
                        ),
                      );
                    }
                                  }
                ),
                _isLoadingPage
                  ? Container(
                      alignment: FractionalOffset.center,
                      child: CircularProgressIndicator(
                      ),
                      
                    )
                  : Container(
                      color: Colors.transparent,
                    ),
                  ],
            ),
            floatingActionButton: FutureBuilder(
              future: _controller.future,
                builder: (BuildContext context, AsyncSnapshot<WebViewController> controller) {
                  print(controller);
                  if(controller.hasData){
                    return FloatingActionButton(
                      child: Icon(Icons.refresh),
                      backgroundColor: redColor,
                      onPressed: () async {
                        print("HeyHO");
                        setState(() {
                          _isLoadingPage = true;
                        });
                        String apiToken = await getApiToken();
                        controller.data.loadUrl("http://niggelgame.pythonanywhere.com/api/data",//"http://10.0.2.2:5000/api/data",
                         headers: {
                                    "Authorization": apiToken
                                  }).whenComplete(() {
                                    
                                    //print("HEYHOOOOOO\n\n\n\n\n\n");
                                    setState(() {
                                      _isLoadingPage = false;
                                    });
                                    
                        //             print(_controller);
                                   });

                        // FutureBuilder(
                        //   future: _controller.future,
                        //   builder: (BuildContext context, AsyncSnapshot<WebViewController> controller){
                        //     if(controller.hasData){
                        //       controller.data.loadUrl("http://10.0.2.2:5000/api/data", headers: {
                        //             "Authorization": apiToken
                        //           }).whenComplete(() {
                                    
                        //             print("HEYHOOOOOO\n\n\n\n\n\n");
                        //             setState(() {
                        //               _isLoadingPage = false;
                        //             });
                                    
                        //             print(_controller);
                        //           });
                        //     }




                        //     return Container();
                        //   },
                        // );
                        

                        

                        
                        print(_controller);
                        
                        // _controller.loadUrl("http://10.0.2.2:5000/api/data", headers: {
                        //       "Authorization": "ejlRkxgXMXY9N3M43pcn8XZ5woDbtM1KweoasGPolK12EBch5h"
                        //     }).whenComplete(() {
                        //       print("HEYEYEYEYEYEY");
                        //       setState(() {
                        //         _isLoadingPage = false;
                        //       });
                        //     });
                        setState(() {
                          
                        });
                      },
                    );
                  } else {
                    print(controller);
                    return Container();
                  }
              }
            ),
          ),
          
        ),
      ),
    );
    
  }
  


  

  Future<String> getApiToken() async {
    String apiKey = "";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    apiKey = prefs.getString('API_Token');
    print(apiKey);

    return apiKey;
  }
}