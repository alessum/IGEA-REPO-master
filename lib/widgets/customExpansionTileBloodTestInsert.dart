import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:igea_app/blocs/diary/diary_bloc.dart';
import 'package:igea_app/models/constants/constants.dart';
import 'package:igea_app/screens/camera/camera_screen.dart';
import 'package:igea_app/models/camera_file_manager.dart';

class CustomExpansionTileBloodTestInsert extends StatefulWidget {

  final String leading;
  final String trailing;
  CustomExpansionTileBloodTestInsert({this.leading = '', this.trailing=''});

  @override
  _CustomExpansionTileBloodTestInsertState createState() => _CustomExpansionTileBloodTestInsertState();
}

class _CustomExpansionTileBloodTestInsertState extends State<CustomExpansionTileBloodTestInsert> with SingleTickerProviderStateMixin {
  
  String triglycerides;
  final _formKey = GlobalKey<FormState>(); //we want associate the form below to this formkey
  String _isHypertensive;
  String totalCholesterol;
  String hdlCholesterol;
  String ldlCholesterol;
  String systolicPressure;
  AnimationController _controller;
  Animation<double> _expandAnimation;
  Animation<double> _rotateAnimation; 
  bool _expand = false;
  
  @override
  void initState() {
    super.initState();
    prepareAnimations();
    _runExpandCheck();
  }

  ///Setting up the animation
  void prepareAnimations() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200)
    );
     Animation curve = CurvedAnimation(
      parent: _controller,
      curve: Curves.ease,
    );
    _expandAnimation = Tween(begin: 0.0, end: 1.0).animate(curve)
      ..addListener(() {
        setState(() {
        });
      }
    );
    _rotateAnimation = Tween(begin: 0.0, end: pi/2).animate(curve)
      ..addListener(() {
        setState(() {
        });
      }
    );
  }

  void _runExpandCheck() {
    if(_expand) {
      _controller.forward();
    }
    else {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double mediaHeight = MediaQuery.of(context).size.height;
    double mediaWidth = MediaQuery.of(context).size.width;
    DiaryBloc diaryBloc = context.dependOnInheritedWidgetOfExactType();
    return Container(
          width: 340.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 50,
                width: 340,
                child: Card(
                elevation: 1.0,
                color: Color(0xff4768b7),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0)
                ),
                child: Padding(
                      padding: const EdgeInsets.only(left:15.0, right:5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                              widget.leading,
                              style: TextStyle(
                                fontSize: mediaWidth * 0.05,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                            ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                  widget.trailing,
                                  style: TextStyle(
                                    fontSize: mediaWidth * 0.06,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _expand = !_expand;
                                    });
                                    _runExpandCheck();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 15.0, right: 5.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xff142c85)
                                      ),
                                      child: Transform.rotate(
                                        angle: _rotateAnimation.value,
                                        child: Icon(Icons.expand_more,
                                        color: Color(0xff4768b7))
                                      ),
                                    ),
                                  )
                                )
                            ],
                          ),
                        ]
                      )
                    )
                ),
              ),
              SizeTransition(
                axisAlignment: 1.0,
                sizeFactor: _expandAnimation,
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal:20.0),
                    child: Container(
                      height: 500,
                      width: 320,
                      color: Colors.transparent,
                      child: Card(
                        elevation: 1.0,
                        color: Color(0xffebebeb),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text('Trigliceridi: ',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.grey[900]
                                      )
                                      ), 
                                      Row(
                                        children: <Widget>[
                                          SizedBox(width: 85,
                                          child: Container(
                                            height: 60,
                                            width: 10,
                                            child: Card(
                                            elevation: 0.0,
                                            color: Color(0xffdfdfdf),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(30.0)
                                            ),
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 6.0),                             
                                                child: Center(
                                                  child: TextFormField(
                                                    decoration: InputDecoration(
                                                      contentPadding: EdgeInsets.fromLTRB(10.0, 7.0, 10.0, 5.0),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.all(
                                                          Radius.circular(30.0)
                                                        ),
                                                        borderSide: BorderSide(
                                                          color: Colors.transparent,
                                                        )
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.all(
                                                          Radius.circular(30.0)
                                                        ),
                                                        borderSide: BorderSide(
                                                          color: Colors.transparent,
                                                        )
                                                      )
                                                    ),
                                                    keyboardType: TextInputType.number,
                                                    inputFormatters:[ FilteringTextInputFormatter.deny(RegExp("[.]")) ],
                                                    onChanged: (val) {
                                                      setState(() => triglycerides= val);
                                                    },
                                                  )
                                                ),
                                              )
                                            ),
                                          )
                                     ),
                                     Text('[mg/dl]',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[900]
                                      )
                                      ), 
                                        ],
                                      )
                                    ]
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text('Colesterolo\nTotale: ',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.grey[900]
                                      )
                                      ), 
                                      Row(
                                        children: <Widget>[
                                          SizedBox(width: 85,
                                          child: Container(
                                            height: 60,
                                            width: 10,
                                            child: Card(
                                              elevation: 0.0,
                                            color: Color(0xffdfdfdf),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(30.0)
                                            ),
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 6.0),                             
                                                child: Center(
                                                  child: TextFormField(
                                                    decoration: InputDecoration(
                                                      contentPadding: EdgeInsets.fromLTRB(10.0, 7.0, 10.0, 5.0),
                                                      hintStyle: TextStyle(
                                                        color: Color(0xff83b6bc),
                                                        fontFamily: 'FilsonSoft'
                                                      ),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.all(
                                                          Radius.circular(30.0)
                                                        ),
                                                        borderSide: BorderSide(
                                                          color: Colors.transparent,
                                                        )
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.all(
                                                          Radius.circular(30.0)
                                                        ),
                                                        borderSide: BorderSide(
                                                          color: Colors.transparent,
                                                        )
                                                      )
                                                    ),
                                                    keyboardType: TextInputType.number,
                                                    inputFormatters:[ FilteringTextInputFormatter.deny(RegExp("[.]")) ],
                                                    onChanged: (val) {
                                                      setState(() => totalCholesterol = val);
                                                    },
                                                  )
                                                ),
                                              )
                                            ),
                                          )
                                     ),
                                     Text('[mg/dl]',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[900]
                                      )
                                      ), 
                                        ],
                                      )
                                    ]
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text('Colesterolo\nHDL: ',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.grey[900]
                                      )
                                      ), 
                                      Row(
                                        children: <Widget>[
                                          SizedBox(width: 85,
                                          child: Container(
                                            height: 60,
                                            width: 10,
                                            child: Card(
                                              elevation: 0.0,
                                              color: Color(0xffdfdfdf),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(30.0)
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 6.0),                             
                                                child: Center(
                                                  child: TextFormField(
                                                    decoration: InputDecoration(
                                                      contentPadding: EdgeInsets.fromLTRB(10.0, 7.0, 10.0, 5.0),
                                                      hintStyle: TextStyle(
                                                        color: Color(0xff83b6bc),
                                                        fontFamily: 'FilsonSoft'
                                                      ),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.all(
                                                          Radius.circular(30.0)
                                                        ),
                                                        borderSide: BorderSide(
                                                          color: Colors.transparent,
                                                        )
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.all(
                                                          Radius.circular(30.0)
                                                        ),
                                                        borderSide: BorderSide(
                                                          color: Colors.transparent,
                                                        )
                                                      )
                                                    ),
                                                    keyboardType: TextInputType.number,
                                                    inputFormatters:[ FilteringTextInputFormatter.deny(RegExp("[.]")) ],
                                                    onChanged: (val) {
                                                      setState(() => hdlCholesterol = val);
                                                    },
                                                  )
                                                ),
                                              )
                                            ),
                                          )
                                     ),
                                     Text('[mg/dl]',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[900]
                                      )
                                      ), 
                                        ],
                                      )
                                    ]
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text('Colesterolo\nLDL: ',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.grey[900]
                                      )
                                      ), 
                                      Row(
                                        children: <Widget>[
                                          SizedBox(width: 85,
                                          child: Container(
                                            height: 60,
                                            width: 10,
                                            child: Card(
                                              elevation: 0.0,
                                              color: Color(0xffdfdfdf),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(30.0)
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 6.0),                             
                                                child: Center(
                                                  child: TextFormField(
                                                    decoration: InputDecoration(
                                                      contentPadding: EdgeInsets.fromLTRB(10.0, 7.0, 10.0, 5.0),
                                                      hintStyle: TextStyle(
                                                        color: Color(0xff83b6bc),
                                                        fontFamily: 'FilsonSoft'
                                                      ),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.all(
                                                          Radius.circular(30.0)
                                                        ),
                                                        borderSide: BorderSide(
                                                          color: Colors.transparent,
                                                        )
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.all(
                                                          Radius.circular(30.0)
                                                        ),
                                                        borderSide: BorderSide(
                                                          color: Colors.transparent,
                                                        )
                                                      )
                                                    ),
                                                    keyboardType: TextInputType.number,
                                                    inputFormatters:[ FilteringTextInputFormatter.deny(RegExp("[.]")) ],
                                                    onChanged: (val) {
                                                      setState(() => ldlCholesterol = val);
                                                    },
                                                  )
                                                ),
                                              )
                                            ),
                                          )
                                     ),
                                     Text('[mg/dl]',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[900]
                                      )
                                      ), 
                                        ],
                                      )
                                    ]
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0, right: 5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text('Pressione\nsistolica: ',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.grey[900]
                                      )
                                      ), 
                                      Row(
                                        children: <Widget>[
                                          SizedBox(width: 85,
                                          child: Container(
                                            height: 60,
                                            width: 10,
                                            child: Card(
                                              elevation: 0.0,
                                              color: Color(0xffdfdfdf),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(30.0)
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 6.0),                             
                                                child: Center(
                                                  child: TextFormField(
                                                    decoration: InputDecoration(
                                                      contentPadding: EdgeInsets.fromLTRB(10.0, 7.0, 10.0, 5.0),
                                                      hintStyle: TextStyle(
                                                        color: Color(0xff83b6bc),
                                                        fontFamily: 'FilsonSoft'
                                                      ),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.all(
                                                          Radius.circular(30.0)
                                                        ),
                                                        borderSide: BorderSide(
                                                          color: Colors.transparent,
                                                        )
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.all(
                                                          Radius.circular(30.0)
                                                        ),
                                                        borderSide: BorderSide(
                                                          color: Colors.transparent,
                                                        )
                                                      )
                                                    ),
                                                    keyboardType: TextInputType.number,
                                                    inputFormatters:[ FilteringTextInputFormatter.deny(RegExp("[.]")) ],
                                                    onChanged: (val) {
                                                      setState(() => systolicPressure = val);
                                                    },
                                                  )
                                                ),
                                              )
                                            ),
                                          )
                                     ),
                                     Text('[mmHg]',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[900]
                                      )
                                      ), 
                                        ],
                                      )
                                    ]
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0, right: 55.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text('Ipertensione: ',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.grey[900]
                                      )
                                      ), 
                                      SizedBox(width: 100,
                                      child: Container(
                                        height: 60,
                                        width: 10,
                                        child: Card(
                                          elevation: 0.0,
                                            color: Color(0xffdfdfdf),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20.0)
                                            ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 12.0),                             
                                            child: Center(
                                              child: FormField(
                                                builder: (FormFieldState state) {
                                                  return DropdownButtonHideUnderline(
                                                    child: new InputDecorator(
                                                      decoration: InputDecoration(
                                                        contentPadding: const EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                                                        errorMaxLines: 2,
                                                        fillColor: Colors.transparent, 
                                                        filled: true,
                                                        enabledBorder: OutlineInputBorder(
                                                          borderRadius: const BorderRadius.all(
                                                            const Radius.circular(20.0),
                                                          ),
                                                          borderSide: BorderSide(color: Colors.transparent)
                                                        ),
                                                        focusedBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(color: Colors.transparent)
                                                        )
                                                      ),
                                                      isEmpty: _isHypertensive == null,
                                                      child: Theme(
                                                        data: Theme.of(context).copyWith(
                                                          canvasColor: Colors.white
                                                        ),
                                                        child: new DropdownButton<String>(
                                                          value: _isHypertensive,
                                                          isDense: true,
                                                          onChanged: (String newValue) {
                                                            print('value change');
                                                            print(newValue);
                                                            setState(() {
                                                              _isHypertensive = newValue;
                                                            });
                                                          },
                                                          items: <String>['Sì', 'No'].map((String value) {
                                                            return DropdownMenuItem<String>(
                                                              value: value,
                                                              child: Text(value)
                                                            );
                                                          }).toList()
                                                        )
                                                      )
                                                    )
                                                  );
                                                }
                                              )
                                            ),
                                          )
                                        ),
                                      )
                                     )
                                    ]
                                  ),
                                ),
                                SizedBox(height:10.0),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0, right: 25.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text('Referto: ',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.grey[900]
                                      )
                                      ), 
                                      SizedBox(width: 150,
                                      child: Center(
                                        child: GestureDetector(
                                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CameraScreen())),
                                          child: RichText(                                        
                                          text: TextSpan(
                                            text: 'carica il referto',
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                decoration: TextDecoration.underline,
                                                fontFamily: 'FilsonSoft'
                                              )
                                          ),
                                          ),
                                        ),
                                      )
                                     )
                                    ]
                                  ),
                                ),
                                SizedBox(height:10.0),
                                RaisedButton(
                          elevation: 5.0,
                    onPressed: () {
                      // diaryBloc.inNewOutcome.add({
                      //   Constants.OUTCOME_KEY:'000',
                      //   Constants.OUTCOME_TRYGLIC_KEY: triglycerides,
                      //   Constants.OUTCOME_CHOL_TOT_KEY: totalCholesterol,
                      //   Constants.OUTCOME_CHOL_HDL_KEY: hdlCholesterol,
                      //   Constants.OUTCOME_CHOL_LDL_KEY: ldlCholesterol,
                      //   Constants.OUTCOME_SYST_PRESS_KEY : systolicPressure,
                      //   //Constants.OUTCOME_HYPERTENSION_KEY: _isHypertensive,
                      //   Constants.CAMERA_FILE_KEY: CameraFileManager.savedImage,
                      // });
                    },
                    shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(30.0),
),
                    padding: const EdgeInsets.all(0.0),
                    child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xff4768b7),
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    padding: const EdgeInsets.all(10.0),
                    child: const Text(
                        'Aggiungi all\'archivio',
                        style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'FilsonSoft')
                    ),
                    ),
        ),
                              ]
                            ),
                          ),
                        )
                      )
                    )
                 )
               )
              ]
            )
          );
  }

}