import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toktok/Screens/my_profile/my_info.dart';
import 'package:toktok/Components/sliver_app_delegate.dart';
import 'package:toktok/Components/tab_grid.dart';
import 'package:toktok/Locale/locale.dart';
import 'package:toktok/Routes/routes.dart';
import 'package:toktok/Theme/colors.dart';
import 'package:toktok/Components/score_container.dart';
import 'package:toktok/constants.dart';
import 'package:toktok/controllers/profile_controller.dart';

class MyProfilePage extends StatelessWidget {
  const MyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    String uid = firebaseAuth.currentUser!.uid;
    return MyProfileBody(uid: uid);
  }
}

class MyProfileBody extends StatefulWidget {
  const MyProfileBody({super.key, required this.uid});
  final String uid;
  @override
  _MyProfileBodyState createState() => _MyProfileBodyState();
}

class _MyProfileBodyState extends State<MyProfileBody> {
  final key = UniqueKey();
  late ProfileController _profileController;

  @override
  void initState() {
    super.initState();
    _profileController = Get.find();
    _profileController.updateUserId(widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 56.0),
      child: Scaffold(
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
                    floating: false,
                    title: const CoinContainer(),
                    actions: <Widget>[
                      Theme(
                        data: Theme.of(context).copyWith(
                          cardColor: backgroundColor,
                        ),
                        child: PopupMenuButton(
                          icon: Icon(
                            Icons.more_vert,
                            color: secondaryColor,
                          ),
                          shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide.none),
                          onSelected: (dynamic value) {
                            if (value == locale!.changeLanguage) {
                              Navigator.pushNamed(
                                  context, PageRoutes.languagePage);
                            } else if (value == locale.help) {
                              Navigator.pushNamed(context, PageRoutes.helpPage);
                            } else if (value == locale.termsOfUse) {
                              Navigator.pushNamed(context, PageRoutes.tncPage);
                            } else if (value == locale.logout) {
                              firebaseAuth.signOut();
                            } else if (value == "Redeem Coins") {
                              Navigator.pushNamed(
                                  context, PageRoutes.redeemCoins);
                            }
                          },
                          itemBuilder: (BuildContext context) {
                            return [
                              PopupMenuItem(
                                value: locale!.changeLanguage,
                                textStyle: TextStyle(color: secondaryColor),
                                child: Text(locale.changeLanguage!),
                              ),
                              PopupMenuItem(
                                value: locale.help,
                                textStyle: TextStyle(color: secondaryColor),
                                child: Text(locale.help!),
                              ),
                              PopupMenuItem(
                                value: "Redeem Coins",
                                textStyle: TextStyle(color: secondaryColor),
                                child: const Text("Redeem Coins"),
                              ),
                              PopupMenuItem(
                                value: locale.termsOfUse,
                                textStyle: TextStyle(color: secondaryColor),
                                child: Text(locale.termsOfUse!),
                              ),
                              PopupMenuItem(
                                value: locale.logout,
                                textStyle: TextStyle(color: secondaryColor),
                                child: Text(locale.logout!),
                              )
                            ];
                          },
                        ),
                      )
                    ],
                    flexibleSpace: MyInfo(),
                  ),
                  SliverPersistentHeader(
                    delegate: SliverAppBarDelegate(
                      TabBar(
                        labelColor: mainColor,
                        unselectedLabelColor: lightTextColor,
                        indicatorColor: transparentColor,
                        tabs: const [
                          Tab(icon: Icon(Icons.dashboard)),
                          Tab(icon: Icon(Icons.favorite_border)),
                          // Tab(icon: Icon(Icons.bookmark_border)),
                        ],
                      ),
                    ),
                    pinned: true,
                  ),
                ];
              },
              body: Obx(() {
                if (_profileController.user.isEmpty) {
                  return Container();
                }
                return TabBarView(
                  children: <Widget>[
                    FadedSlideAnimation(
                      beginOffset: const Offset(0, 0.3),
                      endOffset: const Offset(0, 0),
                      slideCurve: Curves.linearToEaseOut,
                      child: TabGrid(
                        _profileController.user['videos'],
                        viewIcon: Icons.remove_red_eye,
                        showView: true,
                        onTap: () => print('video click'),
                      ),
                    ),
                    FadedSlideAnimation(
                      beginOffset: const Offset(0, 0.3),
                      endOffset: const Offset(0, 0),
                      slideCurve: Curves.linearToEaseOut,
                      child: TabGrid(
                        _profileController.user['favourites'],
                        icon: Icons.favorite,
                        showView: false,
                      ),
                    ),
                    // FadedSlideAnimation(
                    //   beginOffset: const Offset(0, 0.3),
                    //   endOffset: const Offset(0, 0),
                    //   slideCurve: Curves.linearToEaseOut,
                    //   child: TabGrid(
                    //     _profileController.user['videos'],
                    //     icon: Icons.bookmark,
                    //     showView: false,
                    //   ),
                    // ),
                  ],
                );
              }),
            ),
          ),
        ),
        // floatingActionButton:  AppConfig.isDemoMode ? BuyThisApp.button(
        //         AppConfig.appName,
        //         'https://dashboard.vtlabs.dev/projects/envato-referral-buy-link?project_slug=qvid_flutter',
        //       ) : null,
        // bottomNavigationBar: AppConfig.isDemoMode ? Container(
        //   padding: const EdgeInsets.all(1.0),
        //   // margin: const EdgeInsets.fromLTRB(10, 0, 0, 60),
        //   child: BuyThisApp.developerRowOpusDark(
        //       Colors.transparent, Theme.of(context).primaryColorLight),
        // )  : const SizedBox.shrink() ,
      ),
    );
  }
}
