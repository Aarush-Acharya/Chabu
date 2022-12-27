import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'Messages.dart';
import 'controllers/sendMessageController.dart';
import 'Splash_page.dart';
import 'bindings/initial_bindings.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chabu',
      theme: ThemeData(brightness: Brightness.dark),
      home: SplashScreen(),
      initialBinding: InitialBinding(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _controller = TextEditingController();
  var controller = Get.find<HomePageController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/my_boxes.png',
                scale: 7,
              ),
              Image.asset(
                'assets/images/My_project.png',
                scale: 4,
              ),
              SizedBox(
                width: 0.2,
              ),
              Text(
                'AruBot',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'RubikVinyl',
                    fontSize: 23), //<-- SEE HERE
              ),
              Image.asset(
                'assets/images/My_project.png',
                scale: 4,
              ),
              Image.asset(
                'assets/images/my_box_rev.png',
                scale: 7,
              ),
            ],
          ),
          backgroundColor: Colors.blue,
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: <Color>[Colors.deepPurple, Colors.cyan])),
          )),
      body: Container(
        child: Column(
          children: [
            Expanded(child: MessagesScreen()),
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.cyan,
                  Colors.deepPurple,
                ],
              )),
              padding: EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 8,
              ),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: _controller,
                    style: TextStyle(color: Colors.white),
                    textInputAction: TextInputAction.go,
                    onSubmitted: (value) {
                      controller.sendMessage(_controller.text);
                      _controller.clear();
                    },
                  )),
                  IconButton(
                      onPressed: () {
                        controller.sendMessage(_controller.text);
                        _controller.clear();
                      },
                      icon: Icon(Icons.send))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
