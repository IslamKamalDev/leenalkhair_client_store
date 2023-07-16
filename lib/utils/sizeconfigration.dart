import 'package:flutter/material.dart';
enum ScreenType{
  SMALL,MEDIUM,LARGE
}
class ScreenConfig{
  BuildContext? context;
  late double screenWidth;
  double? screenHeight;
  ScreenType? screenType;

  ScreenConfig(BuildContext context){
    this.screenWidth=MediaQuery.of(context).size.width;
    this.screenHeight=MediaQuery.of(context).size.height;
    _setScreen();
  }
  void _setScreen(){
    if(this.screenWidth>=320&&this.screenWidth<375){
      this.screenType=ScreenType.SMALL;
    }
    if(this.screenWidth>=375&&this.screenWidth<414){
      this.screenType=ScreenType.MEDIUM;
    }
    if(this.screenWidth>=414){
      this.screenType=ScreenType.LARGE;
    }

  }
}
class WidigetSize{
  late ScreenConfig screenConfig;

  double? height;
  WidigetSize( ScreenConfig screenConfig){
    this.screenConfig = screenConfig;
    _init();
  }

  void _init() {
    switch(this.screenConfig.screenType){
      case ScreenType.SMALL:

        this.height=450;

        break;
      case ScreenType.MEDIUM:
        this.height=450;
        break;
      case ScreenType.LARGE:
        this.height=450;
        break;
      default:
      this.height=450;
        break;

    }


  }
}