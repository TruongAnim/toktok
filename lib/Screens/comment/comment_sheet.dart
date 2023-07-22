import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toktok/Components/custom_button.dart';
import 'package:toktok/Components/entry_field.dart';
import 'package:toktok/Locale/locale.dart';
import 'package:toktok/Theme/colors.dart';
import 'package:toktok/controllers/auth_controller.dart';
import 'package:toktok/Screens/comment/controllers/comment_controller.dart';
import 'package:toktok/models/comment.dart';
import 'package:timeago/timeago.dart' as TimeAgo;

void commentSheet(BuildContext context, String postId) async {
  var locale = AppLocalizations.of(context)!;
  CommentController _commentController = Get.find();
  _commentController.updatePostId(postId);
  TextEditingController editingController = TextEditingController();

  await showModalBottomSheet(
    enableDrag: false,
    isScrollControlled: true,
    backgroundColor: backgroundColor,
    shape: const OutlineInputBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        borderSide: BorderSide.none),
    context: context,
    builder: (context) => Container(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      height: MediaQuery.of(context).size.height / 1.5,
      child: Obx(
        () {
          return Stack(
            children: <Widget>[
              FadedSlideAnimation(
                beginOffset: const Offset(0, 0.3),
                endOffset: const Offset(0, 0),
                slideCurve: Curves.linearToEaseOut,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        locale.comments!,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: lightTextColor),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.only(bottom: 60.0),
                          itemCount: _commentController.comments.length,
                          itemBuilder: (context, index) {
                            Comment comment =
                                _commentController.comments[index];
                            return Column(
                              children: <Widget>[
                                Divider(
                                  color: darkColor,
                                  thickness: 1,
                                ),
                                ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      comment.profileImage,
                                      scale: 1,
                                    ),
                                  ),
                                  title: Text(comment.username,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                              height: 2,
                                              color: disabledTextColor)),
                                  subtitle: RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                        text: '${comment.comment}  ',
                                      ),
                                      TextSpan(
                                          text: TimeAgo.format(
                                              (comment.publicDate).toDate()),
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge),
                                    ]),
                                  ),
                                  trailing: CustomButton(
                                    Icon(
                                      comment.likes.contains(
                                              AuthController.instance.user.uid)
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: comment.likes.contains(
                                              AuthController.instance.user.uid)
                                          ? Colors.red
                                          : disabledTextColor,
                                    ),
                                    comment.likes.length.toString(),
                                    onPressed: () {
                                      _commentController
                                          .likeComment(comment.id);
                                    },
                                    padding: 8,
                                  ),
                                ),
                              ],
                            );
                          }),
                    )
                  ],
                ),
              ),
              PositionedDirectional(
                bottom: -10,
                start: 0,
                end: 0,
                child: EntryField(
                  controller: editingController,
                  counter: null,
                  padding: EdgeInsets.zero,
                  hint: locale.writeYourComment,
                  fillColor: darkColor,
                  prefix: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          AuthController.instance.appUser.value.profilePhoto),
                    ),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.send,
                      color: mainColor,
                    ),
                    onPressed: () {
                      _commentController.postComment(editingController.text);
                      editingController.text = '';
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    ),
  );
}
