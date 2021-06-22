import 'dart:async';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Clock extends StatefulWidget {
  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {

  isPortrait()=> MediaQuery.of(context).size.height/MediaQuery.of(context).size.width >=1;

  double screenWidth(){
    if( isPortrait() /*MediaQuery.of(context).orientation == Orientation.portrait*/ )
      return MediaQuery.of(context).size.width ;
    else return MediaQuery.of(context).size.height ;
  }
  double screenHeight(){
    if(  isPortrait() /*MediaQuery.of(context).orientation == Orientation.portrait*/ )
      return MediaQuery.of(context).size.height ;
    else return MediaQuery.of(context).size.width ;
  }
  double textScale([ratio=20])=> MediaQuery.textScaleFactorOf(context)*ratio;

  DateTime time = DateTime.now();

  int hour(DateTime _time)=> _time.hour<=12? _time.hour : _time.hour-12;

  String fieldHour(int _hour)=> _hour>=10? '$_hour' : '0$_hour';
  String fieldMnt(int _minute)=> _minute>=10? '$_minute' : '0$_minute';
  String fieldScnd(int _second)=> _second>=10? '$_second' : '0$_second';


  String month(int _month){
    if(_month<10) return "0"+_month.toString() ;
    else return _month.toString();
  }
  String day(int _day){
    if(_day<10) return "0"+_day.toString() ;
    else return _day.toString();
  }

  TextStyle timeStyle()=> TextStyle(
      fontFamily: 'DS' ,
      color: Colors.greenAccent ,
      fontWeight: FontWeight.w900);

  @override
  Widget build(BuildContext context) {

    Timer(Duration(milliseconds: 1), (){
      setState(() {
        time = DateTime.now().toLocal();
      });
    });


    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          boxShadow: [BoxShadow(color: Colors.black54, spreadRadius: 5 ,blurRadius: 20)],
          color: Colors.grey[300]
        ),
        margin: EdgeInsets.symmetric(
            vertical: isPortrait() ? screenHeight()/8 :screenWidth()/8,
            horizontal: screenWidth()/15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [


            /*RichText(
              text: TextSpan(
                  style: TextStyle(fontSize: textScale(30) ,fontFamily: 'SourceCodePro' ,color: Colors.black ,fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                        text: time.year.toString() +'/'
                    ),
                    TextSpan(
                        text: month(time.month) +'/'
                    ),
                    TextSpan(
                        text: day(time.day),
                        style: TextStyle(color:Colors.greenAccent ,shadows: [Shadow(blurRadius: 2)])
                    ),

                  ]
              ),
            ),*/


            Expanded(
              child: Container(
                width: screenWidth()/2.7,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Expanded(
                      child: Container(
                          alignment: Alignment.center,
                          child: AutoSizeText(
                            '${fieldHour( hour(time) )}',
                            style: timeStyle(),
                            minFontSize: textScale(15),
                            maxFontSize: textScale(40),
                          )),
                    ),

                    AutoSizeText(':',
                      style: TextStyle(fontFamily: 'DS',),
                      minFontSize: textScale(15),
                      maxFontSize: textScale(40),
                    ),

                    Expanded(
                      child: Container(
                          alignment: Alignment.center,
                          child: AutoSizeText('${fieldMnt(time.minute)}' ,
                            style: timeStyle().copyWith(fontWeight: FontWeight.w700),
                            minFontSize: textScale(15),
                            maxFontSize: textScale(40),
                          )),
                    ),


                    AutoSizeText(':',
                      style: TextStyle(fontFamily: 'DS',),
                      minFontSize: textScale(15),
                      maxFontSize: textScale(40),
                    ),

                    Expanded(
                      child: Container(
                          alignment: Alignment.center,
                          child: AutoSizeText('${fieldScnd(time.second)}' ,
                            style: timeStyle().copyWith(fontWeight: FontWeight.normal ,color: Colors.black87),
                            minFontSize: textScale(15),
                            maxFontSize: textScale(40),
                          )),
                    ),

                  ],
                ),
              ),
            ),


            Container(
              alignment: Alignment.center,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/clockWithNums.png'),
                    fit: BoxFit.contain,
                  )
                ),
                width: screenWidth()*0.70,
                height: screenWidth()*0.70,
                child: Stack(
                  alignment: Alignment.center,
                  children: [

                    Stack(
                      alignment: Alignment.center,
                      children: [


                        //minute
                        Transform.rotate(
                            angle: ( ( (time.minute + time.second/60 )*6) *pi)/180,
                            child: Container(
                              margin: EdgeInsets.only(bottom: screenWidth() * 0.23),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage('assets/images/clock_mnt_3a2rab.png'),
                                      //fit: BoxFit.contain
                                  )
                              ),
                              height: screenWidth()*0.27,
                            )),


                        //hour
                        Transform.rotate(
                            angle: ( ( (hour(time) + time.minute/60 )*30 ) *pi)/180,
                            child: Container(
                              margin: EdgeInsets.only(bottom: screenWidth() * 0.18),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/images/clock_hor_3a2rab.png'),
                                    //fit: BoxFit.contain
                                  )
                              ),
                              height: screenWidth()*0.22,
                            )),


                        //second
                        Transform.rotate(
                            angle: (((time.second + (time.millisecond / 1000)) * 6) * pi) / 180,
                              child: VerticalDivider(color: Colors.greenAccent,thickness: 3,endIndent: screenWidth()*0.3,indent: screenWidth()/17,)),

                        //centerCircle
                        CircleAvatar(backgroundColor: Colors.greenAccent,radius: 5,),


                      ],
                    ),

                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
