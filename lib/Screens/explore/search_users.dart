import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart' hide SearchController;
import 'package:get/get.dart';
import 'package:toktok/Locale/locale.dart';
import 'package:toktok/Routes/routes.dart';
import 'package:toktok/Theme/colors.dart';
import 'package:toktok/Components/tab_grid.dart';
import 'package:toktok/controllers/search_controller.dart';
import 'package:toktok/models/user.dart';

class SearchUsers extends StatefulWidget {
  @override
  _SearchUsersState createState() => _SearchUsersState();
}

class _SearchUsersState extends State<SearchUsers> {
  late SearchController _searchController;
  var _controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchController = Get.find();
  }

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(66.0),
            child: Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 12.0),
                  decoration: BoxDecoration(
                    color: darkColor,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                        icon: IconButton(
                          icon: const Icon(Icons.arrow_back),
                          color: secondaryColor,
                          onPressed: () => Navigator.pop(context),
                        ),
                        border: InputBorder.none,
                        hintText: AppLocalizations.of(context)!.search,
                        hintStyle: Theme.of(context).textTheme.titleSmall,
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.search),
                          color: secondaryColor,
                          onPressed: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            _searchController
                                .searchUser(_controller.text.toLowerCase());
                            _searchController
                                .searchVideo(_controller.text.toLowerCase());
                          },
                        )),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TabBar(
                    indicator: BoxDecoration(color: transparentColor),
                    isScrollable: true,
                    labelColor: mainColor,
                    labelStyle: Theme.of(context).textTheme.titleMedium,
                    unselectedLabelColor: disabledTextColor,
                    tabs: <Widget>[
                      Tab(text: GetStringUtils(local.video!).capitalize),
                      Tab(text: local.users),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        body: Obx(() {
          return TabBarView(
            children: <Widget>[
              FadedSlideAnimation(
                beginOffset: const Offset(0, 0.3),
                endOffset: const Offset(0, 0),
                slideCurve: Curves.linearToEaseOut,
                child: TabGrid(
                  _searchController.listVideo,
                  showView: true,
                  onTap: () =>
                      Navigator.pushNamed(context, PageRoutes.videoOptionPage),
                ),
              ),
              FadedSlideAnimation(
                beginOffset: const Offset(0, 0.3),
                endOffset: const Offset(0, 0),
                slideCurve: Curves.linearToEaseOut,
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: _searchController.listUser.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      AppUser user = _searchController.listUser[index];
                      return Column(
                        children: <Widget>[
                          Divider(
                            color: darkColor,
                            height: 1.0,
                            thickness: 1,
                          ),
                          ListTile(
                            leading: FadedScaleAnimation(
                              child: CircleAvatar(
                                backgroundColor: darkColor,
                                backgroundImage:
                                    NetworkImage(user.profilePhoto),
                              ),
                            ),
                            title: Text(
                              user.name,
                              style: const TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(user.email.split('@')[0]),
                            onTap: () => Get.toNamed(PageRoutes.userProfilePage,
                                arguments: {'uid': user.uid}),
                          ),
                        ],
                      );
                    }),
              )
            ],
          );
        }),
      ),
    );
  }
}
