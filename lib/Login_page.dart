import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lapp/Home_page.dart';
import 'package:lapp/api%20&%20bloc/api_controller.dart';
import 'package:lapp/api%20&%20bloc/index.dart';
import 'package:lapp/jolooch_home.dart';
import 'package:lapp/models/login.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formkey = GlobalKey<FormState>();
  final loginName = TextEditingController();
  final loginPass = TextEditingController();
  bool isValid = false;
  AjiltanEnum ajiltan = AjiltanEnum.Borluulagch;
  String Radvalue = "1";

  _validator(String value) {
    if (value.length > 5) {
      isValid = true;
      setState(() {});
      print("ene:::${isValid}");
    }
  }

  void onSubmit() async {
    if (_formkey.currentState!.validate()) {
      var map = new Map<String, dynamic>();
      map['phone'] = loginName.text;
      map['password'] = loginPass.text;
      var response = await ApiManager.login(map);
      if (response.role != 'seller') {
        print("role buruu bna");
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
      } else {
        Navigator.push(context, MaterialPageRoute(builder: (context) => JoloochPage()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp],
    );
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('images/background.jpg'), fit: BoxFit.fitWidth),
        ),
        child: SafeArea(
          child: Align(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Form(
                      child: Column(
                        children: [
                          Image(
                            image: AssetImage('images/baekseol.png'),
                            height: 254,
                            width: 253,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 100.0),
                          child: Radio(
                            value: AjiltanEnum.Borluulagch,
                            groupValue: ajiltan,
                            onChanged: ((value) {
                              if (value != null)
                                setState(() {
                                  // ajiltan = value;
                                });
                            }),
                          ),
                        ),
                        Text(
                          "Борлуулагч",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 100.0),
                          child: Radio(
                              value: AjiltanEnum.Hurgegch,
                              groupValue: ajiltan,
                              onChanged: ((value) {
                                if (value != null)
                                  setState(() {
                                    // ajiltan = value;
                                  });
                              })),
                        ),
                        Text(
                          "Жолооч",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Container(
                        decoration:
                            BoxDecoration(color: Colors.white, border: Border.all(color: Colors.white), borderRadius: BorderRadius.circular(30)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: TextFormField(
                            onChanged: ((value) {
                              _validator(value);
                            }),
                            controller: loginName,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Хоосон байж болохгүй";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                labelText: "Нэвтрэх нэр",
                                labelStyle: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
                                border: InputBorder.none),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Container(
                        decoration:
                            BoxDecoration(color: Colors.white, border: Border.all(color: Colors.white), borderRadius: BorderRadius.circular(30)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: TextFormField(
                            controller: loginPass,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Хоосон байж болохгүй";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: "Нууц үг",
                              labelStyle: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
                              border: InputBorder.none,
                            ),
                            obscureText: true,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 112),
                      child: Container(
                        padding: EdgeInsets.all(12),

                        decoration:
                            BoxDecoration(color: Colors.white, border: Border.all(color: Colors.white), borderRadius: BorderRadius.circular(30)),
                        // child: SizedBox(
                        //   width: 177,
                        //   height: 54,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.white),
                              foregroundColor: MaterialStateProperty.all(Colors.black),
                              elevation: MaterialStateProperty.all(0)),
                          onPressed: onSubmit,
                          child: Text(
                            "Нэвтрэх",
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ),
                        // ),
                      ),
                    ),
                    SizedBox(
                      height: 150,
                    ),
                  ], //Column Children
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

enum AjiltanEnum { Borluulagch, Hurgegch }
