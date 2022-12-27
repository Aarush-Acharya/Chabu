import 'dart:html';
import 'dart:ui';
import 'controllers/sendMessageController.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'main.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class CustomMessage extends StatelessWidget {
  final payload;
  CustomMessage({super.key, required this.payload});
  var controller = Get.find<HomePageController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: payload['type'].toString() == 'description'
          ? Container(
              color: Colors.amber,
              child: Column(
                children: [
                  Text(payload['text'][0].toString()),
                  SizedBox(
                    height: 30,
                  ),
                  Text(payload['text'][1].toString()),
                ],
              ),
            )
          : payload['type'].toString() == 'image'
              ? Container(
                  color: Colors.green,
                  child: Column(
                    children: [
                      Text("Image is here"),
                      Image.network(payload['rawUrl'].toString()),
                      Text("Can you see the Image ?")
                    ],
                  ),
                )
              : payload['type'].toString() == 'link'
                  ? Container(
                      child: Column(
                        children: [
                          Text(payload['Message']),
                          SizedBox(
                            height: 30,
                          ),
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: "For More Information ",
                                style: TextStyle(color: Colors.white)),
                            TextSpan(
                                style: TextStyle(color: Colors.blue),
                                text: " Click Here ",
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    launchUrl(Uri.parse(payload['link']));
                                  })
                          ]))
                        ],
                      ),
                    )
                  : payload['type'].toString() == 'Image/Link'
                      ? Container(
                          child: Column(
                            children: [
                              Image.network(payload['Image'].toString()),
                              SizedBox(
                                height: 30,
                              ),
                              Text(payload['Message']),
                              SizedBox(
                                height: 30,
                              ),
                              RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    text: "For More Information ",
                                    style: TextStyle(color: Colors.white)),
                                TextSpan(
                                    style: TextStyle(color: Colors.blue),
                                    text: " Click Here ",
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        launchUrl(Uri.parse(payload['link']));
                                      })
                              ]))
                            ],
                          ),
                        )
                      : Container(
                          child: Column(children: [
                          Text(" Some suggestions are "),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    style: TextStyle(color: Colors.blue),
                                    text: " google? ",
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        controller.sendMessage("google?");
                                      }),
                              ])),
                              SizedBox(
                                width: 30,
                              ),
                              RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    style: TextStyle(color: Colors.blue),
                                    text: " who built you ",
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        controller.sendMessage("who built you");
                                      }),
                              ])),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                      style: TextStyle(color: Colors.blue),
                                      text: " How is Aarush Acharya? ",
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          controller.sendMessage(
                                              "How is Aarush Acharya?");
                                        }),
                                ])),
                                SizedBox(
                                  width: 30,
                                ),
                                //is Aarush Acharya a Student
                                RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                      style: TextStyle(color: Colors.blue),
                                      text: " is Aarush Acharya a Student? ",
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          controller.sendMessage(
                                              "is Aarush Acharya a Student");
                                        }),
                                ])),
                              ])
                        ])),
    );
  }
}

class MessagesScreen extends StatefulWidget {
  MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  var controller = Get.find<HomePageController>();

  bool isCustomMessage(int index) {
    return controller.messages[index]['message'].payload != null;
  }

  String getNormalMessage(int index) {
    return controller.messages[index]['message'].text.text[0];
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Obx(() => ListView.separated(
        itemBuilder: (context, index) {
          return Container(
            // alignment: isCustomMessage(index)
            //     ? Alignment.bottomLeft
            //     : Alignment.topLeft,
            margin: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: controller.messages[index]['isUserMessage']
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              children: [
                Container(
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(
                            controller.messages[index]['isUserMessage']
                                ? 0
                                : 20,
                          ),
                          topLeft: Radius.circular(
                            controller.messages[index]['isUserMessage']
                                ? 20
                                : 0,
                          ),
                        ),
                        color: controller.messages[index]['isUser'] != null &&
                                controller.messages[index]['isUser'] == true
                            ? Colors.grey.shade800
                            : Colors.grey.shade900.withOpacity(0.8)),
                    constraints: BoxConstraints(maxWidth: w * 2 / 3),
                    child: isCustomMessage(index)
                        ? CustomMessage(
                            payload:
                                controller.messages[index]['message'].payload)
                        : Text(
                            getNormalMessage(index),
                            style: TextStyle(color: Colors.white),
                          )),
              ],
            ),
          );
        },
        separatorBuilder: (_, i) => Padding(padding: EdgeInsets.only(top: 10)),
        itemCount: controller.messages.length));
  }
}
