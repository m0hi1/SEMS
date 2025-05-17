import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/gemini_services.dart';
import '../widget/message_bubble.dart';

class SemsAiAssistant extends StatefulWidget {
  const SemsAiAssistant({super.key});

  @override
  State<SemsAiAssistant> createState() => _SemsAiAssistantState();
}

class _SemsAiAssistantState extends State<SemsAiAssistant> {
  final ScrollController _scrollController = ScrollController();

  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, String>> _messages = [];
  final GeminiService _geminiService = GeminiService();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'SEMS AI Assistant',
            style: GoogleFonts.inter(fontWeight: FontWeight.bold),
          ),
          elevation: 2,
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue.shade50, Colors.white],
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: _messages.length,
                  padding: const EdgeInsets.all(16),
                  itemBuilder: (context, index) {
                    final message = _messages[index];
                    return MessageBubble(
                      content: message['content']!,
                      isUser: message['role'] == 'user',
                    );
                  },
                ),
              ),
              if (_isLoading)
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: LinearProgressIndicator(),
                ),
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        maxLines: null,
                        decoration: InputDecoration(
                          hintText: 'Ask anything...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    FloatingActionButton(
                      onPressed: _sendMessage,
                      child: const Icon(Icons.send),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Future<void> _sendMessage() async {
    if (_messageController.text.trim().isEmpty) return;

    final userMessage = _messageController.text;
    setState(() {
      _messages.add({'role': 'user', 'content': userMessage});
      _isLoading = true;
    });
    _messageController.clear();
    _scrollToBottom();

    try {
      final response = await _geminiService.getResponse(userMessage);
      setState(() {
        _messages.add({'role': 'assistant', 'content': response});
        _isLoading = false;
      });
      _scrollToBottom();
    } catch (e) {
      setState(() {
        _messages.add({
          'role': 'assistant',
          'content': 'Sorry, I encountered an error. Please try again.'
        });
        _isLoading = false;
      });
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }
}
