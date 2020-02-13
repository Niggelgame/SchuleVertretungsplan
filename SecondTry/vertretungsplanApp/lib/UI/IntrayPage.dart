import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vertretungsplanApp/UI/IntrayContents/IntrayPageContentOne.dart';
import 'package:vertretungsplanApp/UI/IntrayContents/IntrayPageContentTwo.dart';
import 'package:vertretungsplanApp/blocs/authentication_bloc.dart';
import 'package:vertretungsplanApp/events/authentication_events.dart';
import 'package:vertretungsplanApp/models/global.dart';

class IntrayPage extends StatefulWidget {
  @override 
  State<IntrayPage> createState() => _IntrayPageState();
}


class _IntrayPageState extends State<IntrayPage> {

  @override 
  Widget build(BuildContext context){
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: DefaultTabController(
          length: 3,
          child: Scaffold(
            body: Stack(
              children: <Widget>[
                TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    IntrayPageContentOne(),
                    IntrayPageContentTwo(),
                    Container(
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                          colors: [
                                //Color(0xFFABDCFF),
                                //Color(0xFF0396FF)
                                Color(0xFF5EFCE8),
                                Color(0xFF736EFE)
                              ],
                              center: const Alignment(-0.7, -1),
                              radius: 2.5
                        )
                      ),
                      child: Center(
                        child: FlatButton(
                          color: redColor,
                          child: Text("Logout"),
                          onPressed: (){
                            BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
                          },
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(left:50),
                    height: 80,
                    
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
                )
              ],
            ),
            appBar: AppBar(
              elevation: 0,
              title: TabBar(
                tabs: <Widget>[
                  Tab(icon: Icon(Icons.today),),
                  Tab(icon: Icon(Icons.calendar_today)),
                  Tab(icon: Icon(Icons.settings))
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
    );
  }
}