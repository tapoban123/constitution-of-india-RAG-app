import 'package:constitution_app/controllers/chat_data_bloc/chat_data_bloc.dart';
import 'package:constitution_app/controllers/chat_data_bloc/chat_data_events.dart';
import 'package:constitution_app/controllers/chat_data_bloc/chat_data_states.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:constitution_app/models/message_model.dart';
import 'package:constitution_app/utils/constants.dart';
import 'package:constitution_app/view/widgets/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uuid/uuid.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Chat",
          style: TextStyle(fontFamily: FontFamily.Lexend_Regular.name),
        ),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        systemOverlayStyle: SystemUiOverlayStyle(
          systemNavigationBarColor: Color(0xFF0F0E0E),
          systemNavigationBarIconBrightness: Brightness.light,
        ),
        // actions: [
        //   IconButton(onPressed: () {}, icon: Icon(Icons.search_rounded)),
        //   IconButton(onPressed: () {}, icon: Icon(Icons.history)),
        // ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0.w),
                child: BlocBuilder<ChatDataBloc, ChatDataState>(
                  builder: (context, state) {
                    final reversedMsgs = state.messages.reversed.toList();

                    if (reversedMsgs.isEmpty) {
                      return Center(
                        child: Text(
                          "Start asking queries...",
                          style: TextStyle(
                            fontFamily: FontFamily.Lexend_Medium.name,
                            fontSize: 25.sp,
                          ),
                        ),
                      );
                    }
                    return ListView.separated(
                      reverse: true,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            MessageBubble(message: reversedMsgs[index]),
                            state.status == ChatDataStatus.loading && index == 0
                                ? Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      padding: const EdgeInsets.all(10.0),
                                      decoration: BoxDecoration(
                                        color: Color(0xFF28282B),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: AnimatedTextKit(
                                        animatedTexts: [
                                          TypewriterAnimatedText(
                                            'Loading...',
                                            speed: Duration(milliseconds: 100),
                                            textStyle: TextStyle(
                                              fontSize: 15.sp,
                                              fontFamily: FontFamily
                                                  .Lexend_Regular
                                                  .name,
                                            ),
                                            cursor: "",
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : SizedBox.shrink(),
                          ],
                        );
                      },
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 6.h),
                      itemCount: state.messages.length,
                    );
                  },
                ),
              ),
            ),

            _ChatQueryInputField(),
          ],
        ),
      ),
    );
  }
}

class _ChatQueryInputField extends StatefulWidget {
  const _ChatQueryInputField({super.key});

  @override
  State<_ChatQueryInputField> createState() => _ChatQueryInputFieldState();
}

class _ChatQueryInputFieldState extends State<_ChatQueryInputField> {
  final TextEditingController _queryController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 6.w),
      padding: EdgeInsets.symmetric(vertical: 12.w, horizontal: 12.w),
      decoration: BoxDecoration(color: Color(0xFF0F0E0E)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 300.w,
            child: TextField(
              focusNode: _focusNode,
              onTapOutside: (event) {
                _focusNode.unfocus();
              },
              controller: _queryController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                filled: true,
                hintText: "Enter your query...",
              ),
              cursorColor: Colors.white70,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.sentences,
              textInputAction: TextInputAction.newline,
            ),
          ),
          IconButton(
            onPressed: () {
              final newMessage = MessageModel(
                id: Uuid().v4(),
                sender: SenderType.USER,
                message: _queryController.text,
                sentAt: DateTime.now(),
              );
              context.read<ChatDataBloc>().add(
                AddNewMessageEvent(newMessage: newMessage),
              );

              context.read<ChatDataBloc>().add(
                GenerateAiResponseEvent(query: _queryController.text.trim()),
              );

              _queryController.clear();
            },
            icon: Icon(Icons.send_rounded),
          ),
        ],
      ),
    );
  }
}
