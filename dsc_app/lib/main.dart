import 'dart:async';
import 'package:flushbar/flushbar.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Data {
  String imageUrL;

  Data({this.imageUrL});
}

class Indicator extends StatelessWidget {
  int index;

  Indicator({this.index});

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment(0, 0.8),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          buildContainer(index == 0 ? Colors.yellow : Colors.grey),
          buildContainer(index == 1 ? Colors.yellow : Colors.grey),
          buildContainer(index == 2 ? Colors.yellow : Colors.grey),
        ]));
  }
}

Container buildContainer(col) {
  return Container(
    height: 10,
    width: 10,
    margin: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: col,
      shape: BoxShape.circle,
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyPageView(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  bool visible = false, agree = false;
  List<String> gender = ['Male', 'Female'];
  String selected;
  TextEditingController nameControl = TextEditingController();
  TextEditingController passControl = TextEditingController();
  TextEditingController emailControl = TextEditingController();
  TextEditingController phoneControl = TextEditingController();
  var buttoncontext;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              leading: Image.asset('images/macicon.png'),
              title: Text('McDonalds'),
              backgroundColor: Colors.red,
            ),
            body: Container(
                color: Colors.yellow,
                height: double.infinity,
                width: double.infinity,
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Center(
                            child: Text('Join Us Now !',
                                style: TextStyle(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                )),
                          ),
                          SizedBox(height: 30),
                          TextFormField(
                            controller: nameControl,
                            decoration: InputDecoration(
                              labelText: 'Name',
                              prefixIcon: Icon(Icons.person),
                              labelStyle: TextStyle(
                                fontSize: 25,
                                color: Colors.black,
                              ),
                              hintText: 'Enter your name',
                            ),
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(height: 30),
                          TextFormField(
                            controller: passControl,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              prefixIcon: IconButton(
                                icon: Icon(visible
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    visible = !visible;
                                  });
                                },
                              ),
                              labelStyle: TextStyle(
                                fontSize: 25,
                                color: Colors.black,
                              ),
                              hintText: 'Enter your password',
                            ),
                            keyboardType: TextInputType.text,
                            obscureText: visible,
                          ),
                          SizedBox(height: 30),
                          TextFormField(
                            controller: emailControl,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              prefixIcon: Icon(Icons.email_rounded),
                              labelStyle: TextStyle(
                                fontSize: 25,
                                color: Colors.black,
                              ),
                              hintText: 'Enter your Email',
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(height: 30),
                          TextFormField(
                            controller: phoneControl,
                            decoration: InputDecoration(
                                labelText: 'Phone',
                                prefixIcon: Icon(Icons.phone),
                                labelStyle: TextStyle(
                                  fontSize: 25,
                                  color: Colors.black,
                                ),
                                hintText: 'Enter your Phone Number',
                                prefixText: '+20',
                                prefixStyle: TextStyle(
                                  fontSize: 20,
                                )),
                            keyboardType: TextInputType.number,
                          ),
                          SizedBox(height: 30),
                          Row(children: [
                            Icon(Icons.person_pin_rounded),
                            DropdownButton(
                              hint: Text('Select Gender'),
                              value: selected,
                              items: gender.map((item) {
                                return DropdownMenuItem(
                                  child: Text(item),
                                  value: item,
                                );
                              }).toList(),
                              onChanged: (newval) {
                                setState(() {
                                  selected = newval;
                                });
                              },
                            ),
                          ]),
                          SizedBox(height: 30),
                          CheckboxListTile(
                              value: agree,
                              controlAffinity: ListTileControlAffinity.leading,
                              title: Text(
                                'Agree on Our Terms & Conditions',
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              onChanged: (val) {
                                setState(() {
                                  agree = val;
                                });
                              }),
                          SizedBox(height: 30),
                          ElevatedButton(
                            onPressed: () {
                              if (nameControl.text == "" ||
                                  passControl.text == "" ||
                                  emailControl.text == "" ||
                                  phoneControl.text == "" ||
                                  !agree ||
                                  !gender.contains(selected)) {
                                Flushbar(
                                  duration: Duration(seconds: 5),

                                  flushbarPosition: FlushbarPosition.TOP,
                                  icon: Icon(Icons.error_outline_rounded),
                                  title: "Error",
                                  backgroundColor: Colors.red,
                                  messageText: Text('Some information is missing', style:TextStyle(
                                    color: Colors.white,

                                  )),
                                ).show(context);
                              } else {
                                final alert = AlertDialog(
                                  content: Container(

                                      child: Column(

                                          children: [
                                        Text('Thank you for registering'),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(buttoncontext).pop();
                                            },
                                            child: Text(
                                              'Close',
                                              style:
                                                  TextStyle(color: Colors.blue),
                                            ))
                                      ]),
                                      height: 80),
                                  title: Text('Success'),
                                );
                                showDialog(
                                    context: context,
                                    builder: (BuildContext ctx) {
                                      buttoncontext = ctx;
                                      return alert;
                                    });
                              }
                            },
                            child: Text('Sign Up',
                                style: TextStyle(
                                    fontSize: 25, color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.orange),
                          ),
                        ],
                      ),
                    )))));
  }
}

class MySplash extends StatefulWidget {
  @override
  MySplashState createState() => MySplashState();
}

class MySplashState extends State<MySplash> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: SplashScreen(
        seconds: 5,
        image: Image.asset('images/macicon.png'),
        photoSize: 200,
        backgroundColor: Colors.red,
        loaderColor: Colors.orangeAccent,
        loadingText: Text(
          'Loading..Please Wait',
          style: Theme.of(context).textTheme.headline5,
        ),
        navigateAfterSeconds: MyHomePage(),
      )),
    );
  }
}

class MyPageView extends StatefulWidget {
  MyPageView({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyPageViewState createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
  int currindex = 0;
  var mycontroller = PageController(
    initialPage: 0,
  );

  List<Data> myData = [
    Data(imageUrL: 'images/image1.png'),
    Data(imageUrL: 'images/image2.jpg'),
    Data(imageUrL: 'images/image4.jpg')
  ];

  @override
  void initState() {
    Timer.periodic(Duration(seconds: 2), (timer) {
      if (currindex < 2)
        currindex++;
      else
        currindex = 0;
      mycontroller.animateToPage(currindex,
          duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: buildImageSlider()),
    );
  }

  Stack buildImageSlider() {
    return Stack(
      children: [buildPageView(), buildGetStarted(), buildIndicator()],
    );
  }

  Center buildIndicator() => Center(child: Indicator(index: currindex));

  Align buildGetStarted() {
    return Align(
        alignment: Alignment.bottomCenter,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.blue),
              child: Text('Get Started',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ))),
        );
  }

  PageView buildPageView() {
    return PageView(
        onPageChanged: (val) {
          setState(() {
            currindex = val;
          });
        },
        controller: mycontroller,
        children: myData
            .map((item) => Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: ExactAssetImage(item.imageUrL),
                          fit: BoxFit.fill)),
                ))
            .toList());
  }
}
