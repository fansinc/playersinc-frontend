import 'package:flutter/material.dart';
import '/config/app_config.dart';
import 'home_stats_rating_widget.dart';
import 'home_stats_skills_widget.dart';

class HomeStatsWidget extends StatefulWidget {
  const HomeStatsWidget({Key? key}) : super(key: key);

  @override
  State<HomeStatsWidget> createState() => _HomeStatsWidgetState();
}

class _HomeStatsWidgetState extends State<HomeStatsWidget> {
  //List<SliderModel> slides = [];
  int currentIndex = 0;
  late PageController _controller;

/*   final bannerList = [
    AppConfig.banner1Image,
    AppConfig.banner2Image,
    AppConfig.banner3Image,
    AppConfig.banner4Image,
  ]; */

  final sliderWidgetList = [
    const HomeStatsRatingWidget(),
    const HomeStatsSkillsWidget(),
    //const HomeStatsRatingWidget()
  ];

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print(widget._planList);

    return Container(
        margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 270,
              child: PageView.builder(
                  controller: _controller,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (value) {
                    setState(() {
                      currentIndex = value;
                    });
                  },
                  itemCount: sliderWidgetList.length,
                  //slider.length,
                  itemBuilder: (context, index) {
                    // contents of slider

                    return Container(
                      child: sliderWidgetList[index],
                    );
                    /* Image.asset(
                      AppConfig.logoImage,
                    ); */
                  }),
              /* ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                      //margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                      //width: deviceWidth * .95,
                      child: (Image.asset(
                        bannerList[index],
                        fit: BoxFit.fill,
                        width: deviceWidth * .95,
                        //height: 100,
                      )),
                    );
                  },
                  itemCount: bannerList.length,
                ), */
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  sliderWidgetList.length,
                  //slider.length,
                  (index) {
                    return Container(
                      height: 10,
                      width: currentIndex == index ? 25 : 10,
                      margin: const EdgeInsets.only(right: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: currentIndex == index
                              ? const Color(
                                  AppConfig.blueColor,
                                )
                              : const Color(
                                  AppConfig.lightGrey,
                                )),
                    );
                  },
                ),
              ),
            ),
          ],
        ));
  }
}
