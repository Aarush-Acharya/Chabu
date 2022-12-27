import 'package:get/get.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';

class HomePageController extends GetxController {
  final DialogFlowtter dialogFlowtter;

  HomePageController({required this.dialogFlowtter});

  RxList messages = [].obs;

  sendMessage(String text) async {
    if (text.isEmpty) {
      print('Message is Empty');
    } else {
      addMessage(Message(text: DialogText(text: [text])), true);

      DetectIntentResponse response = await dialogFlowtter.detectIntent(
          queryInput: QueryInput(text: TextInput(text: text)));

      if (response.message == null) return;

      addMessage(response.message!);
    }
  }

  addMessage(Message message, [bool isUserMessage = false]) {
    messages.add({
      'message': message,
      'isUserMessage': isUserMessage,
    });
  }
}
