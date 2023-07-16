import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toktok/Components/sliver_app_delegate.dart';
import 'package:toktok/Components/tab_grid.dart';
import 'package:toktok/Locale/locale.dart';
import 'package:toktok/Screens/user_profile/widgets/user_info.dart';
import 'package:toktok/Theme/colors.dart';
import 'package:toktok/controllers/profile_controller.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = Get.arguments;
    return UserProfileBody(uid: data['uid']);
  }
}

class UserProfileBody extends StatefulWidget {
  final String uid;

  const UserProfileBody({super.key, required this.uid});
  @override
  _UserProfileBodyState createState() => _UserProfileBodyState();
}

class _UserProfileBodyState extends State<UserProfileBody> {
  late ProfileController _profileController;

  var followText;
  final key = UniqueKey();

  @override
  void initState() {
    super.initState();
    _profileController = Get.find();
    _profileController.updateUserId(widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: darkColor,
      body: DefaultTabController(
        length: 2,
        child: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  expandedHeight: 350,
                  actions: <Widget>[
                    PopupMenuButton(
                      color: backgroundColor,
                      icon: Icon(
                        Icons.more_vert,
                        color: secondaryColor,
                      ),
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide.none),
                      itemBuilder: (BuildContext context) {
                        return [
                          PopupMenuItem(
                            value: locale!.report,
                            textStyle: TextStyle(color: secondaryColor),
                            child: Text(locale.report!),
                          ),
                          PopupMenuItem(
                            value: locale.block,
                            textStyle: TextStyle(color: secondaryColor),
                            child: Text(locale.block!),
                          ),
                        ];
                      },
                    )
                  ],
                  flexibleSpace: const UserInfo(),
                ),
                SliverPersistentHeader(
                  delegate: SliverAppBarDelegate(
                    TabBar(
                      labelColor: mainColor,
                      unselectedLabelColor: lightTextColor,
                      indicatorColor: transparentColor,
                      tabs: const [
                        Tab(icon: Icon(Icons.dashboard)),
                        Tab(
                          icon: ImageIcon(AssetImage(
                            'assets/icons/ic_like.png',
                          )),
                        ),
                      ],
                    ),
                  ),
                  pinned: true,
                ),
              ];
            },
            body: TabBarView(
              children: <Widget>[
                FadedSlideAnimation(
                  beginOffset: const Offset(0, 0.3),
                  endOffset: const Offset(0, 0),
                  slideCurve: Curves.linearToEaseOut,
                  child: GetBuilder<ProfileController>(
                      builder: (ProfileController controller) {
                    if (controller.user.isEmpty) {
                      return Container();
                    }
                    return TabGrid(
                      _profileController.user['videos'],
                      viewIcon: Icons.remove_red_eye,
                      showView: true,
                    );
                  }),
                ),
                FadedSlideAnimation(
                    beginOffset: const Offset(0, 0.3),
                    endOffset: const Offset(0, 0),
                    slideCurve: Curves.linearToEaseOut,
                    child: GetBuilder<ProfileController>(
                        builder: (ProfileController controller) {
                      if (controller.user.isEmpty) {
                        return Container();
                      }
                      return TabGrid(
                        _profileController.user['favourites'],
                        icon: Icons.favorite,
                        showView: false,
                      );
                    })),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
