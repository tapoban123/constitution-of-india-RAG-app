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
    return Align(
      alignment: message.sender == SenderType.USER
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: screenWidth(context) * 0.8
        ),
        child: Card(
          color: message.sender == SenderType.USER
              ? Color(0xFF4169E1)
              : Colors.white30,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: MarkdownBlock(
              data: message.message,
              selectable: true,
              config: MarkdownConfig(
                configs: [
                  PConfig(
                    textStyle: TextStyle(
                      fontSize: 15.sp,
                      fontFamily: FontFamily.Lexend_VariableWgt.name,
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
