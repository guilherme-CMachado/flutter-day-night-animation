import 'package:animation/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'land.dart';
import 'rounded_text_field.dart';
import 'tabs.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool _fullSun = false;
  bool _daymod = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _fullSun = true;
      });
    });
  }

  void changedMod(int activeTab) {
    if (activeTab == 0) {
      setState(() {
        _daymod = true;
      });
      Future.delayed(Duration(milliseconds: 300), () {
        setState(() {
          _fullSun = true;
        });
      });
      //É dia!
    } else {
      setState(() {
        _daymod = false;
      });
      Future.delayed(Duration(milliseconds: 300), () {
        setState(() {
          _fullSun = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Color> lightBgColors = [
      Color(0xFF8C2480),
      Color(0xFFCE587D),
      Color(0xFFFF9485),
      if (_fullSun) Color(0xFFFF9D80)
    ];
    var darkBgColors = [
      Color(0xFF0D1441),
      Color(0xFF283584),
      Color(0xFF376AB2),
    ];

    Duration _duration = Duration(seconds: 1);
    return AnimatedContainer(
      duration: _duration,
      width: double.infinity,
      height: SizeConfig.screenHeight,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: _daymod ? lightBgColors : darkBgColors),
      ),
      child: Stack(
        children: [
          AnimatedPositioned(
            curve: Curves.easeInOut,
            duration: _duration,
            left: getProportionateScreenWidth(30),
            bottom: getProportionateScreenWidth(_fullSun ? -45 : -120),
            child: SvgPicture.asset("assets/icons/Sun.svg"),
          ),
          Land(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  VerticalSpacing(of: 50),
                  Tabs(
                    press: (value) {
                      changedMod(value);
                    },
                  ),
                  VerticalSpacing(),
                  Text(
                    "Good Morning",
                    style: Theme.of(context).textTheme.headline3.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  VerticalSpacing(of: 10),
                  Text(
                    "Enter your Informations below",
                    style: TextStyle(color: Colors.white),
                  ),
                  VerticalSpacing(of: 50),
                  RoundedTextField(
                    initialValue: "ourdemo@email.com",
                    hintText: "Email",
                  ),
                  VerticalSpacing(),
                  RoundedTextField(
                    initialValue: "XXXXXXX",
                    hintText: "Password",
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
