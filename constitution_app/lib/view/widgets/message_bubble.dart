import 'package:constitution_app/models/message_model.dart';
import 'package:constitution_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:markdown_widget/markdown_widget.dart';

enum SenderType { USER, AI }

class MessageBubble extends StatelessWidget {
  final MessageModel message;

  const MessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    String msg = message.message;
    if (message.page_nos != null) {
      msg =
          "${message.message}\n\n\n**Page numbers: ${message.page_nos!.join(", ")}**";
    }
    return Align(
      alignment: message.sender == SenderType.USER
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(maxWidth: screenWidth(context) * 0.8),
        child: Card(
          color: message.sender == SenderType.USER
              ? Color(0xFF50C878)
              : Color(0xFF28282B),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: MarkdownBlock(
              data: msg,
              selectable: true,
              config: MarkdownConfig(
                configs: [
                  PConfig(
                    textStyle: TextStyle(
                      fontSize: 15.sp,
                      fontFamily: FontFamily.Lexend_VariableWgt.name,
                      color: message.sender == SenderType.USER
                          ? Colors.black
                          : Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            // child: Text(
            //   message.message,
            //   style: TextStyle(
            //     fontSize: 14,
            //     fontFamily: FontFamily.Lexend_Regular.name,
            //   ),
            // ),
          ),
        ),
      ),
    );
  }
}
