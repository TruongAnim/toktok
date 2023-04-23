import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toktok/BottomNavigation/Explore/explore_page.dart';
import 'package:toktok/Components/profile_page_button.dart';
import 'package:toktok/Components/row_item.dart';
import 'package:toktok/Components/sliver_app_delegate.dart';
import 'package:toktok/Components/tab_grid.dart';
import 'package:toktok/Locale/locale.dart';
import 'package:toktok/Routes/routes.dart';
import 'package:toktok/BottomNavigation/MyProfile/followers.dart';
import 'package:toktok/Theme/colors.dart';
import 'package:toktok/BottomNavigation/MyProfile/following.dart';
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
    // TODO: implement initState
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
                  expandedHeight: 400.0,
                  floating: false,
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
                  flexibleSpace: GetBuilder<ProfileController>(
                      builder: (ProfileController controller) {
                    print(_profileController.user);
                    if (_profileController.user.isEmpty) {
                      return Container();
                    }
                    return FlexibleSpaceBar(
                      centerTitle: true,
                      title: Column(
                        children: <Widget>[
                          Spacer(flex: 10),
                          FadedScaleAnimation(
                            child: CircleAvatar(
                              radius: 28.0,
                              backgroundImage: NetworkImage(
                                  _profileController.user['profilePhoto']),
                            ),
                          ),
                          Spacer(),
                          Row(
                            children: [
                              Spacer(flex: 12),
                              Text(
                                _profileController.user['name'],
                                style: const TextStyle(fontSize: 16),
                              ),
                              Spacer(),
                              Image.asset(
                                'assets/icons/ic_verified.png',
                                scale: 4,
                              ),
                              Spacer(flex: 8),
                            ],
                          ),
                          Text(
                            '@${_profileController.user['email'].toString().split('@')[0]}',
                            style: TextStyle(
                                fontSize: 10, color: disabledTextColor),
                          ),
                          Spacer(),
                          FadedScaleAnimation(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                ImageIcon(
                                  AssetImage(
                                    "assets/icons/ic_fb.png",
                                  ),
                                  color: secondaryColor,
                                  size: 10,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                ImageIcon(
                                  AssetImage("assets/icons/ic_twt.png"),
                                  color: secondaryColor,
                                  size: 10,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                ImageIcon(
                                  AssetImage("assets/icons/ic_insta.png"),
                                  color: secondaryColor,
                                  size: 10,
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          Text(
                            locale!.comment7!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.w500),
                          ),
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              ProfilePageButton(
                                  locale.message,
                                  () => Navigator.pushNamed(
                                      context, PageRoutes.chatPage)),
                              SizedBox(width: 16),
                              _profileController.user['isFollowing']
                                  ? ProfilePageButton(locale.following, () {
                                      _profileController.followUser();
                                    })
                                  : ProfilePageButton(
                                      locale.follow,
                                      () {
                                        _profileController.followUser();
                                      },
                                      color: mainColor,
                                      textColor: secondaryColor,
                                    ),
                            ],
                          ),
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              RowItem(
                                  _profileController.user['likes'],
                                  locale.liked,
                                  Scaffold(
                                    appBar: AppBar(
                                      title: const Text('Liked'),
                                    ),
                                    body: TabGrid(
                                      _profileController.user['videos'],
                                      showView: false,
                                    ),
                                  )),
                              RowItem(_profileController.user['followers'],
                                  locale.followers, FollowersPage()),
                              RowItem(_profileController.user['following'],
                                  locale.following, FollowingPage()),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
                ),
                SliverPersistentHeader(
                  delegate: SliverAppBarDelegate(
                    TabBar(
                      labelColor: mainColor,
                      unselectedLabelColor: lightTextColor,
                      indicatorColor: transparentColor,
                      tabs: [
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
                  beginOffset: Offset(0, 0.3),
                  endOffset: Offset(0, 0),
                  slideCurve: Curves.linearToEaseOut,
                  child: GetBuilder<ProfileController>(
                      builder: (ProfileController controller) {
                    if (controller.user.isEmpty) {
                      return Container();
                    }
                    return TabGrid(
                      _profileController.user['videos'],
                      showView: false,
                    );
                  }),
                ),
                FadedSlideAnimation(
                    beginOffset: Offset(0, 0.3),
                    endOffset: Offset(0, 0),
                    slideCurve: Curves.linearToEaseOut,
                    child: GetBuilder<ProfileController>(
                        builder: (ProfileController controller) {
                      if (controller.user.isEmpty) {
                        return Container();
                      }
                      return TabGrid(
                        _profileController.user['videos'],
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
