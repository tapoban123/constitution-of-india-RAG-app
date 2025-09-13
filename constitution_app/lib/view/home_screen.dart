import 'package:constitution_app/controllers/chat_data_bloc/chat_data_bloc.dart';
import 'package:constitution_app/controllers/chat_data_bloc/chat_data_events.dart';
import 'package:constitution_app/controllers/chat_data_bloc/chat_data_states.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:constitution_app/controllers/chat_history_cubit.dart';
import 'package:constitution_app/models/message_model.dart';
import 'package:constitution_app/utils/constants.dart';
import 'package:constitution_app/view/widgets/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<ChatHistoryCubit>().fetchChatHistory();
    super.initState();
  }

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
        actions: [
          IconButton(
            onPressed: () async {
              final url = Uri.parse(
                "https://drive.google.com/drive/folders/13bKADgN7D-VFHxy2gbbHJZLtPlTXdsMw?usp=sharing",
              );
              if (await canLaunchUrl(url)) {
                await launchUrl(url, mode: LaunchMode.externalApplication);
              }
            },
            icon: Icon(Icons.library_books),
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => Dialog(
                  child: Padding(
                    padding: EdgeInsets.all(24.w),
                    child: Column(
                      spacing: 30.h,
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: screenWidth(context) * 0.6,
                          child: Text(
                            "Are you sure you want to delete the entire chat history?",
                            style: TextStyle(
                              fontFamily: FontFamily.Lexend_Regular.name,
                              color: Colors.white,
                              fontSize: 18.sp,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextButton(
                              onPressed: () {
                                final chats = context
                                    .read<ChatDataBloc>()
                                    .state
                                    .messages;

                                if (chats.isEmpty) {
                                  showFlutterToast(
                                    context,
                                    "No chats present to delete.",
                                  );
                                } else {
                                  context.read<ChatDataBloc>().add(
                                    DeleteChatHistoryEvent(),
                                  );
                                  showFlutterToast(
                                    context,
                                    "Entire chat history has been deleted.",
                                  );
                                }
                                Navigator.pop(context);
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                              child: Text(
                                "Yes",
                                style: TextStyle(
                                  fontFamily: FontFamily.Lexend_Regular.name,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            50.horizontalSpace,
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.blueAccent,
                              ),
                              child: Text(
                                "No",
                                style: TextStyle(
                                  fontFamily: FontFamily.Lexend_Regular.name,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            icon: Icon(Icons.auto_delete_rounded, color: Colors.red),
          ),
        ],
      ),
      body: BlocBuilder<ChatHistoryCubit, ChatHistoryState>(
        builder: (context, state) {
          if (state.status == ChatHistoryStatus.loading) {
            return Center(child: CircularProgressIndicator());
          }
          context.read<ChatDataBloc>().add(
            ReceiveOldMessagesEvent(oldMessages: state.msgs),
          );
          return SafeArea(
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
                                state.status == ChatDataStatus.loading &&
                                        index == 0
                                    ? Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          padding: const EdgeInsets.all(10.0),
                                          decoration: BoxDecoration(
                                            color: Color(0xFF28282B),
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          child: AnimatedTextKit(
                                            animatedTexts: [
                                              TypewriterAnimatedText(
                                                'Loading...',
                                                speed: Duration(
                                                  milliseconds: 100,
                                                ),
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
          );
        },
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
              onTap: () {
                Fluttertoast.cancel();
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
                hintStyle: TextStyle(
                  fontFamily: FontFamily.Lexend_Regular.name,
                ),
              ),
              cursorColor: Colors.white70,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.sentences,
              textInputAction: TextInputAction.newline,
              style: TextStyle(fontFamily: FontFamily.Lexend_Regular.name),
            ),
          ),
          IconButton(
            onPressed: () {
              if (_queryController.text.isEmpty) {
                Fluttertoast.cancel();

                showFlutterToast(context, "Please enter your query.");
                return;
              }
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
