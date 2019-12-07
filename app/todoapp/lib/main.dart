import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/UI/Intray/intray_page.dart';
import 'package:todoapp/UI/Login/loginscreen.dart';
import 'package:todoapp/models/global.dart';
import 'package:todoapp/bloc/blocs/user_bloc_provider.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    OneSignal.shared.init(
      "5c2db3b9-64d0-4c42-b2c9-2054484b4da3",
      iOSSettings: {
        OSiOSSettings.autoPrompt: true,
        OSiOSSettings.inAppLaunchUrl: true
      }
    );
    OneSignal.shared.setInFocusDisplayType(OSNotificationDisplayType.notification);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      theme: ThemeData(
        
        primarySwatch: whiteMaterial,
      ),
      home: MyHomePage(),
      
      
      // LoginPage(),
      // FutureBuilder(
      //   future: getUser(), // a previously-obtained Future<String> or null
      //   builder: (BuildContext context, AsyncSnapshot snapshot) {
      //     if(snapshot.connectionState == ConnectionState.none && snapshot.hasData == null){
      //       return Container();

      //     }

      //     return ListView.builder(
      //       itemCount: snapshot.data.length,
      //       itemBuilder: (context, index) {
              
      //         return Column(
      //           children: <Widget>[


      //           ],
      //         );
      //       },
      //     );
          
      //   },
      // ),
      //home: MyHomePage(title: 'Todo App'),
    );
  }



  

  
}

class MyHomePage extends StatefulWidget {
  // MyHomePage({Key key, this.title}) : super(key: key);

  // final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  

  @override
  Widget build(BuildContext context) {
    
    
    return FutureBuilder(
        future: signinUser(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          String apiKey = "";
          if(snapshot.hasData){
            apiKey = snapshot.data;

          } else {
            print("No data");
          }
          //String apiKey = snapshot.data;
          
          return  apiKey.length > 0 ? getHomePage() : LoginPage(login: login, newUser: false,);
          //return LoginPage();
          
        },


    );

    
    }
  void login(){
    setState(() {
      build(context);
    });
  }

  Future signinUser() async {
    // String userName = "";
    String apikey = await getApiKey();
    if (apikey.length > 0) {
      bloc.signinUser("", "", apikey).then((reallyloggedin){
        if(!reallyloggedin){
          logout();
          return "";
        }
        return apikey;
      });
    } else {
      print("No api key");
    }
    return apikey;
  }
 
  Future getApiKey() async {  
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('API_Token');
  }

    Widget getHomePage() {
      return MaterialApp(
      debugShowCheckedModeBanner: false,
        color: Colors.yellow,
        home: Container(
          color: darkGreyColor,
            child: SafeArea(
              child: DefaultTabController(
              length: 2,
              child: new Scaffold(
                body: Stack(
                  children: <Widget>[
                    TabBarView(
                      children: [
                        IntrayPage(),
                        new Container(
                          child: Center(
                            child: FlatButton(
                              color: redColor,
                              child: Text("Logout"),
                              onPressed: () {
                                logout();
                              },
                            ),
                          ),
                          color: Colors.lightGreen,
                        ),
                        
                      ],
                    ),
                  Container(
                    padding: EdgeInsets.only(left:50),
                    height: 90,
                    
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      ),
                      color: Colors.grey,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Vertretungsplan", style: intrayTitleStyle,),
                        Container(
                          
                        )
                      ],
                    )
                  ),
                  /*Container(
                    height: 80,
                    width: 80,
                    margin: EdgeInsets.only(top: 120, left: MediaQuery.of(context).size.width * 0.5 - 40),
                    child: FloatingActionButton(
                      
                    
                      child: Icon(Icons.add, size: 70,),
                      backgroundColor: redColor,
                      onPressed: () {
                        
                      },
                    ),
                  )*/

                  ],
                ),
                appBar: AppBar(
                  elevation: 0,
                    title: new TabBar(
                    tabs: [
                      Tab(
                        icon: new Icon(Icons.home),
                      
                      ),
                      Tab(
                        icon: new Icon(Icons.perm_identity),
                      ),
                      
                    ],
                    labelColor: Colors.blue,
                    unselectedLabelColor: darkGreyColor,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorPadding: EdgeInsets.all(5.0),
                    indicatorColor: Colors.transparent,
                  ),
                  backgroundColor: Colors.grey,
                ),
                backgroundColor: Colors.grey,
              ),
            ),
          ),
        ),
    );
  }

  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('API_Token', "");
    setState(() {
      build(context);
    });
    
  }

  @override
  void initState() {
    super.initState();

    // SharedPreferences.getInstance().then((SharedPreferences sp){
    //   print("Initialized");
    //   prefs = sp; 
    // });
  }
}
