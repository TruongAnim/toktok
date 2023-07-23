import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toktok/Components/thumb_list.dart';
import 'package:toktok/Locale/locale.dart';
import 'package:toktok/Routes/routes.dart';
import 'package:toktok/Screens/explore/more_page.dart';
import 'package:toktok/Theme/colors.dart';
import 'package:toktok/controllers/hashtag_controller.dart';
import 'package:toktok/models/hashtag.dart';
import 'package:toktok/models/video.dart';

List<String> carouselImages = [
  "assets/images/banner 1.png",
  "assets/images/banner 2.png",
//  "assets/images/banner 1.png",
//  "assets/images/banner 2.png",
];

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ExploreBody();
  }
}

class ExploreBody extends StatefulWidget {
  const ExploreBody({super.key});

  @override
  _ExploreBodyState createState() => _ExploreBodyState();
}

class _ExploreBodyState extends State<ExploreBody> {
  // static const AdRequest request = AdRequest(
  //   keywords: <String>['foo', 'bar'],
  //   contentUrl: 'http://foo.com/bar.html',
  //   nonPersonalizedAds: true,
  // );

  // BannerAd? _anchoredBanner;
  // bool _loadingAnchoredBanner = false;
  bool showingAd = false;

  // Future<void> _createAnchoredBanner(BuildContext context) async {
  //   final AnchoredAdaptiveBannerAdSize? size =
  //       await AdSize.getAnchoredAdaptiveBannerAdSize(
  //     Orientation.portrait,
  //     MediaQuery.of(context).size.width.truncate(),
  //   );

  //   if (size == null) {
  //     print('Unable to get height of anchored banner.');
  //     return;
  //   }

  //   final BannerAd banner = BannerAd(
  //     size: size,
  //     request: request,
  //     adUnitId: Platform.isAndroid
  //         ? 'ca-app-pub-3940256099942544/6300978111'
  //         : 'ca-app-pub-3940256099942544/2934735716',
  //     listener: BannerAdListener(
  //       onAdLoaded: (Ad ad) {
  //         print('$BannerAd loaded.');
  //         setState(() {
  //           _anchoredBanner = ad as BannerAd?;
  //         });
  //       },
  //       onAdFailedToLoad: (Ad ad, LoadAdError error) {
  //         print('$BannerAd failedToLoad: $error');
  //         ad.dispose();
  //       },
  //       onAdOpened: (Ad ad) => print('$BannerAd onAdOpened.'),
  //       onAdClosed: (Ad ad) => print('$BannerAd onAdClosed.'),
  //     ),
  //   );
  //   return banner.load();
  // }

  late HashtagController _hashtagController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _hashtagController = Get.find();
    _hashtagController.getHashtags();
  }

  @override
  void dispose() {
    super.dispose();
    // _anchoredBanner?.dispose();
  }

  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        // if (!_loadingAnchoredBanner) {
        //   _loadingAnchoredBanner = true;
        //   _createAnchoredBanner(context);
        // }
        return Padding(
          padding: const EdgeInsets.only(bottom: 56.0, top: 20.0),
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(72.0),
              child: Container(
                margin: const EdgeInsets.all(20.0),
                padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 24.0),
                decoration: BoxDecoration(
                  color: darkColor,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: TextField(
                  readOnly: true,
                  onTap: () =>
                      Navigator.pushNamed(context, PageRoutes.searchPage),
                  decoration: InputDecoration(
                    icon: Icon(Icons.search, color: secondaryColor),
                    border: InputBorder.none,
                    hintText: AppLocalizations.of(context)!.search,
                    hintStyle: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              ),
            ),
            body: Obx(() {
              return FadedSlideAnimation(
                beginOffset: const Offset(0, 0.3),
                endOffset: const Offset(0, 0),
                slideCurve: Curves.linearToEaseOut,
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: <Widget>[
                    showingAd
                        ? Stack(
                            children: [
                              CarouselSlider(
                                items: carouselImages.map((i) {
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                            child: FadedScaleAnimation(
                                                child: Image.asset(i))),
                                      );
                                    },
                                  );
                                }).toList(),
                                options: CarouselOptions(
                                    enableInfiniteScroll: false,
                                    viewportFraction: 1.0,
                                    autoPlay: true,
                                    aspectRatio: 3,
                                    onPageChanged: (index, reason) {
                                      setState(() {
                                        _current = index;
                                      });
                                    }),
                              ),
                              Positioned.directional(
                                textDirection: Directionality.of(context),
                                end: 20.0,
                                bottom: 0.0,
                                child: Row(
                                  children: carouselImages.map((i) {
                                    int index = carouselImages.indexOf(i);

                                    return Container(
                                      width: 8.0,
                                      height: 8.0,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 16.0, horizontal: 4.0),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: _current == index
                                            ? const Color.fromRGBO(0, 0, 0, 0.9)
                                            : disabledTextColor
                                                .withOpacity(0.5),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              )
                            ],
                          )
                        : Container(),
                    // if (_anchoredBanner != null)
                    //   Container(
                    //     width: _anchoredBanner!.size.width.toDouble(),
                    //     height: _anchoredBanner!.size.height.toDouble(),
                    //     child: AdWidget(ad: _anchoredBanner!),
                    //   ),
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _hashtagController.hashtags.length,
                        itemBuilder: (context, index) {
                          Hashtag hashtag = _hashtagController.hashtags[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              TitleRow(
                                  '#${hashtag.name}',
                                  '${hashtag.videos.length} videos',
                                  hashtag.videos),
                              ThumbList(hashtag.videos),
                            ],
                          );
                        }),
                  ],
                ),
              );
            }),
          ),
        );
      },
    );
  }
}

class TitleRow extends StatelessWidget {
  final String title;
  final String subTitle;
  final List<Video> videos;

  TitleRow(this.title, this.subTitle, this.videos, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: darkColor,
        child: Text(
          '#',
          style: TextStyle(color: mainColor),
        ),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      subtitle: Row(
        children: <Widget>[
          Text(
            '$subTitle ${AppLocalizations.of(context)!.video!}',
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const Spacer(),
          Text(
            "${AppLocalizations.of(context)!.viewAll}",
            style: Theme.of(context).textTheme.labelLarge,
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: secondaryColor,
            size: 10,
          ),
        ],
      ),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MorePage(
            title: title,
            videos: videos,
          ),
        ),
      ),
    );
  }
}
