import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:walie_food/model/news_model.dart';
import 'package:walie_food/utils/screen_util.dart';
import 'package:walie_food/utils/util_export.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);
  static const routeName = '/NewsPage';

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  String? _data;
  NewsModel? _newsModel;

  @override
  void initState() {
    super.initState();
    _parseJson();
  }

  void _parseJson() async {
    _data = await DefaultAssetBundle.of(context)
        .loadString("assets/data/data_food_new.json");
    final jsonResult = jsonDecode(_data!);
    print(jsonResult);
    setState(() {
      _newsModel = NewsModel.fromJson(jsonResult);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tin tức',
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: AppColor.colorPrimaryButton,
        ),
        elevation: 0,
      ),
      body: Container(
        child: Column(
          children: [
            _listNews(),
          ],
        ),
      ),
    );
  }

  Widget _listNews() {
    return Expanded(
      child: ListView.builder(
        itemCount: _newsModel?.data?.length,
        itemBuilder: (builder, index) {
          return Card(
            elevation: 2,
            child: InkWell(
              onDoubleTap: () {},
              onTap: () {
                print('OnClick: ${_newsModel?.data?[index].nameProduct}');
              },
              child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal: ScreenUtil.getInstance().getAdapterSize(8),
                    vertical: ScreenUtil.getInstance().getAdapterSize(8)),
                width: ScreenUtil.getInstance().screenWidth,
                child: Column(
                  children: [
                    _newsModel?.data?[index].image != null
                        ? Image.network(
                            '${_newsModel?.data?[index].image}',
                            fit: BoxFit.cover,
                            width: ScreenUtil.getInstance().screenWidth,
                            height:
                                ScreenUtil.getInstance().getAdapterSize(150),
                          )
                        : Image.asset(
                            'assets/img/no_image.png',
                            fit: BoxFit.cover,
                            width: ScreenUtil.getInstance().screenWidth,
                            height:
                                ScreenUtil.getInstance().getAdapterSize(150),
                          ),
                    SizedBox(
                        height: ScreenUtil.getInstance().getAdapterSize(8)),
                    Center(
                        child: Text(
                      _newsModel?.data?[index].nameProduct ?? '',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    )),
                    SizedBox(
                        height: ScreenUtil.getInstance().getAdapterSize(8)),
                    Text(
                      _newsModel?.data?[index].descriptions ?? '',
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
