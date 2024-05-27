import 'package:SmarterAI/aiProvider/gemini.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
 int id = 0;
class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
   List<types.Message> _messages = [];
  final _user = const types.User(
    id: '82091008-a484-4a89-ae75-a22bf8d6f3ac',
  );
   final _ai = const types.User(
    id: 'ai',
  );

    @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  void _addMessage(types.Message message, bool jsonMode) async {
    setState(() {
      _messages.insert(0, message);
    }); 
    if (message.author.id == "ai"){
      return;
    }
    final response = await GeminiProvider.chat( (message as types.TextMessage).text, jsonModeEnabled: jsonMode);
     print(response);
     final textMessage = types.TextMessage(
      author: _ai,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: "${id}",
      text: response,
    );
      id++;
    _addMessage(textMessage, false);
  }
   void _loadMessages() async {
    /*final response = await rootBundle.loadString('assets/messages.json');
    final messages = (jsonDe(response) as List)
        .map((e) => types.Message.fromJson(e as Map<String, dynamic>))
        .toList();*/

    setState(() {
      _messages = [];
    });
  }
// Suggested code may be subject to a license. Learn more: ~LicenseLog:56389232.
 void _handleSendPressed(String text, bool jsonMode) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: "${id}",
      text: text,
    );
      id++;
      messageController.clear();
    _addMessage(textMessage, jsonMode);
  }

  TextEditingController messageController = TextEditingController();
  bool jsonMode = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CHAT"),
      ),
      body: Chat(
        customBottomWidget: Container(
          height: 150,
          padding: EdgeInsets.symmetric(horizontal: 16),
          color: Color(0xff333333),
          child: Row(
            children: [
              Expanded(child: TextField(
                
                maxLines: 5,
                controller: messageController,
              )), 
              IconButton(onPressed: (){
                _handleSendPressed(messageController.text, false);
              }, icon: Icon(
                Icons.send
              )), 
              TextButton(
                onPressed: (){
                  setState(() {
                    jsonMode = !jsonMode;
                  });
                _handleSendPressed(messageController.text,jsonMode);
              }, child: Text(
                jsonMode?
                "JSON MODE": "NO JSON",
              ))
            ],
          ),
        ),
        messages: _messages, onSendPressed:(p0) {
          
        }, user: _user),
    );
  }
}