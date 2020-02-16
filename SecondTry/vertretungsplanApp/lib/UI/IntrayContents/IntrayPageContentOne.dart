

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:vertretungsplanApp/blocs/apitoken_bloc.dart';
import 'package:vertretungsplanApp/events/apitoken_event.dart';
import 'package:vertretungsplanApp/models/global.dart';
import 'package:vertretungsplanApp/repositories/userRepository.dart';
import 'package:vertretungsplanApp/states/apitoken_states.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';


class IntrayPageContentOne extends StatefulWidget {
  @override 
  State<IntrayPageContentOne> createState() => _IntrayPageContentOneState();
}

class _IntrayPageContentOneState extends State<IntrayPageContentOne> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;
  final Completer<WebViewController> _controller = Completer<WebViewController>();


  @override 
  Widget build(BuildContext context){
    return Container(
      color: Colors.white,
      child: BlocProvider<ApiTokenBloc>(
        create: (context) {
          return ApiTokenBloc(userRepository: UserRepository()) ..add(PageOpenedEvent());
        },
        child: BlocBuilder<ApiTokenBloc, ApiTokenState>(
          builder: (context, state){
            print(state);
            if(state is ApiTokenLoading){
              return Center(
                child: CupertinoActivityIndicator(animating: true, radius: 12,),
              );
            }
            if(state is ApiTokenFailure){
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  content: Text("${state.error}"),
                )
              );
              return Center(
                child: Text("Please login again", overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.red),),
              );
            }
            if(state is ApiTokenLoaded){
              return Container(
                margin: EdgeInsets.only(top: 80),
                color: Colors.white,
                child: Scaffold(
                  body: Stack(
                    children: <Widget>[
                      WebView(
                        gestureRecognizers: [Factory(() => PlatformViewVerticalGestureRecognizer())].toSet(),
                        javascriptMode: JavascriptMode.unrestricted,
                        onWebViewCreated: (WebViewController webViewController){
                          webViewController.loadUrl("https://niggelgame.pythonanywhere.com/api/data",
                            headers: {
                            "Authorization": state.apiToken
                          }).whenComplete(() {
                            _controller.complete(webViewController);
                          });
                        },
                      ),
                      
                    ],
                  ),
                  floatingActionButton: FutureBuilder(
                    future: _controller.future,
                    builder: (BuildContext context, AsyncSnapshot<WebViewController> controller){
                      if(controller.hasData){
                        return FloatingActionButton(
                          child: Icon(Icons.refresh, color: Colors.black,),
                          backgroundColor: redColor,
                          onPressed: () {
                            controller.data.loadUrl("https://niggelgame.pythonanywhere.com/api/data",
                            headers: {
                            "Authorization": state.apiToken
                            });
                          },
                        );
                      } else {
                        return FloatingActionButton(
                          onPressed: (){},
                          child: Icon(Icons.refresh),
                          backgroundColor: Colors.grey,
                        );
                      }
                    },
                  ),
                ),
              );
            }
            if(state is ApiTokenUninitialized){
              return Container();
            }
          },
        ),
      ),

    );
  }



  Widget getWebView(String apiToken){
    print("Getting WebView");
    try{
      return Container(
        margin: EdgeInsets.only(top: 80),
        child: Scaffold(
          body: WebView(
            gestureRecognizers: [Factory(() => PlatformViewVerticalGestureRecognizer())].toSet(),
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController){
              webViewController.loadUrl("https://niggelgame.pythonanywhere.com/api/data",
                headers: {
                "Authorization": apiToken
              }).whenComplete(() {
                _controller.complete(webViewController);
              });
            },
          ),
          floatingActionButton: FutureBuilder(
            future: _controller.future,
            builder: (BuildContext context, AsyncSnapshot<WebViewController> controller){
              if(controller.hasData){
                return FloatingActionButton(
                  child: Icon(Icons.refresh),
                  backgroundColor: redColor,
                  onPressed: () {
                    controller.data.loadUrl("https://niggelgame.pythonanywhere.com/api/data",
                    headers: {
                    "Authorization": apiToken
                    });
                  },
                );
              } else {
                return FloatingActionButton(
                  onPressed: (){},
                  child: Icon(Icons.refresh),
                  backgroundColor: Colors.grey,
                );
              }
            },
          ),
        ),
      );
    } catch (error) {
      print(error.toString());
      return Container();
    }
  }
  
}

class PlatformViewVerticalGestureRecognizer
    extends VerticalDragGestureRecognizer {
  PlatformViewVerticalGestureRecognizer({PointerDeviceKind kind})
      : super(kind: kind);

  Offset _dragDistance = Offset.zero;

  @override
  void addPointer(PointerEvent event) {
    startTrackingPointer(event.pointer);
  }

  @override
  void handleEvent(PointerEvent event) {
    _dragDistance = _dragDistance + event.delta;
    if (event is PointerMoveEvent) {
      final double dy = _dragDistance.dy.abs();
      final double dx = _dragDistance.dx.abs();

      if (dy > dx && dy > kTouchSlop) {
        // vertical drag - accept
        resolve(GestureDisposition.accepted);
        _dragDistance = Offset.zero;
      } else if (dx > kTouchSlop && dx > dy) {
        // horizontal drag - stop tracking
        stopTrackingPointer(event.pointer);
        _dragDistance = Offset.zero;
      }
    }
  }

  @override
  String get debugDescription => 'horizontal drag (platform view)';

  @override
  void didStopTrackingLastPointer(int pointer) {}
}