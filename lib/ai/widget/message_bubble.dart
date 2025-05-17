import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:code_text_field/code_text_field.dart';
import 'package:highlight/highlight.dart';
import 'package:highlight/languages/all.dart';
import 'package:path/path.dart';

import '../../shared/utils/snacbar_helper.dart';

class MessageBubble extends StatelessWidget {
  final String content;
  final bool isUser;

  const MessageBubble({
    super.key,
    required this.content,
    required this.isUser,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.8,
        ),
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isUser ? Colors.blue : Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: isUser ? _buildUserText() : _buildMarkdownContent(),
      ),
    );
  }

  Widget _buildUserText() {
    return Text(
      content,
      style: GoogleFonts.inter(
        color: Colors.white,
        fontSize: 16,
      ),
    );
  }

  Widget _buildMarkdownContent() {
    return MarkdownBody(
      data: content,
      styleSheet: MarkdownStyleSheet(
        p: GoogleFonts.inter(fontSize: 16),
        code: GoogleFonts.firaCode(
          backgroundColor: Colors.grey[200],
          fontSize: 14,
        ),
        codeblockDecoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        h1: GoogleFonts.inter(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        h2: GoogleFonts.inter(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        listBullet: GoogleFonts.inter(fontSize: 16),
      ),
      selectable: true,
      builders: {
        'code': CodeBlockBuilder(),
      },
    );
  }
}

class CodeBlockBuilder extends MarkdownElementBuilder {
  @override
  Widget visitElementAfter(element, TextStyle? preferredStyle) {
    final language =
        element.attributes['class']?.replaceAll('language-', '') ?? '';
    final code = element.textContent;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (language.isNotEmpty) _buildLanguageHeader(language, code),
          _buildCodeField(code, language),
        ],
      ),
    );
  }

  Widget _buildLanguageHeader(String language, String code) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            language.toUpperCase(),
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.copy, color: Colors.white),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: code));
              SnackbarHelper.showInfoSnackBar(
                  context as BuildContext, 'Copied to clipboard');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCodeField(String code, String language) {
    return Container(
      constraints:
          BoxConstraints(maxHeight: 200), // Set a max height constraint
      child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: CodeField(
        controller: CodeController(
          text: code,
          language: allLanguages[language],
        ),
        readOnly: true,
        textStyle: GoogleFonts.firaCode(
          color: Colors.white,
          fontSize: 14,
        ),
      ),
      ),
    );
  }
}
