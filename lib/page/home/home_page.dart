import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:walie_food/model/model_export.dart';
import 'package:walie_food/utils/screen_util.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const routeName = '/HomePage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _data;
  SocialModel? _socialModel;

  @override
  void initState() {
    super.initState();
    _parseJson();
  }

  void _parseJson() async {
    _data = await DefaultAssetBundle.of(context)
        .loadString("assets/data/data_food_social.json");
    final jsonResult = jsonDecode(_data!);
    print(jsonResult);
    setState(() {
      _socialModel = SocialModel.fromJson(jsonResult);
    });
  }

  Future<void> _refresh() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              expandedHeight: ScreenUtil.getInstance().getAdapterSize(200),
              stretch: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Culinary Recipes",
                      style: TextStyle(
                          fontSize: ScreenUtil.getInstance().getAdapterSize(25),
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                centerTitle: true,
                stretchModes: [
                  StretchMode.zoomBackground,
                  StretchMode.blurBackground,
                  StretchMode.fadeTitle,
                ],
                background: Image.asset(
                  'assets/img/img_food_background.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              backgroundColor: Colors.black45,
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Card(
                  elevation: 2,
                  child: InkWell(
                    onDoubleTap: () {},
                    onTap: () {
                      print(
                          'OnClick: ${_socialModel?.data?[index].nameProduct}');
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal:
                              ScreenUtil.getInstance().getAdapterSize(8),
                          vertical: ScreenUtil.getInstance().getAdapterSize(8)),
                      width: ScreenUtil.getInstance().screenWidth,
                      child: Column(
                        children: [
                          _socialModel?.data?[index].image != null
                              ? Image.network(
                                  '${_socialModel?.data?[index].image}',
                                  fit: BoxFit.cover,
                                  width: ScreenUtil.getInstance().screenWidth,
                                  height: ScreenUtil.getInstance()
                                      .getAdapterSize(150),
                                )
                              : Image.asset(
                                  'assets/img/no_image.png',
                                  fit: BoxFit.cover,
                                  width: ScreenUtil.getInstance().screenWidth,
                                  height: ScreenUtil.getInstance()
                                      .getAdapterSize(150),
                                ),
                          SizedBox(
                              height:
                                  ScreenUtil.getInstance().getAdapterSize(8)),
                          Center(
                              child: Text(
                            _socialModel?.data?[index].nameProduct ?? '',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          )),
                          SizedBox(
                              height:
                                  ScreenUtil.getInstance().getAdapterSize(8)),
                          Text(
                            _socialModel?.data?[index].descriptions ?? '',
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 10),
            ),
          ],
        ),
      ),
    );
  }
}
