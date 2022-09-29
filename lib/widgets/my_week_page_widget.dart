import 'package:cached_network_image/cached_network_image.dart';
import '/models/my_week_model.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '/config/app_config.dart';

import '/widgets/logo_profile_widget.dart';
import 'package:flutter/material.dart';

class MyWeekPageWidget extends StatefulWidget {
  final List<MyWeekModel> myWeekList;
  const MyWeekPageWidget(this.myWeekList, {Key? key}) : super(key: key);

  @override
  _MyWeekPageWidgetState createState() => _MyWeekPageWidgetState();
}

class _MyWeekPageWidgetState extends State<MyWeekPageWidget> {
  @override
  Widget build(BuildContext context) {
    //final deviceWidth = MediaQuery.of(context).size.width;
    //final deviceHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.center,
        color: const Color(AppConfig.healthyMindPageColor),
        //Colors.black,
        child: Column(
          children: [
            const LogoProfileWidget(
                Color(AppConfig.healthyMindPageColor), Colors.white),
            /* ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.myWeekList.length,
                itemBuilder: (context, index) {
                  return  */
            Container(
              margin: const EdgeInsets.fromLTRB(10, 2, 10, 2),
              child: StaggeredGridView.countBuilder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 2,
                  itemCount: widget.myWeekList.length,
                  staggeredTileBuilder: (index) =>
                      //const StaggeredTile.extent(20, 200),
                      //const StaggeredTile.fit(2),
                      //StaggeredTile.count(2, index.isEven ? 2 : 1),
                      StaggeredTile.count(1, index.isEven ? 1 : 2),
                  mainAxisSpacing: 10.0,
                  //crossAxisSpacing: 300.0,
                  itemBuilder: (ctx, indexVal) {
                    return Container(
                      // width: deviceWidth * .92,
                      margin: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: widget.myWeekList[indexVal].image[0],
                          placeholder: (context, url) => Image.asset(
                            AppConfig.defaultImage,
                            //width: 50,
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                            AppConfig.defaultImage,
                            // width: 50,
                          ),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
