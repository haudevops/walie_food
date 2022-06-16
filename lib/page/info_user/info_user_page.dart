import 'package:flutter/material.dart';
import 'package:walie_food/generated/l10n.dart';
import 'package:walie_food/routers/routers_export.dart';
import 'package:walie_food/utils/util_export.dart';

class InfoUserPage extends StatefulWidget {
  const InfoUserPage({Key? key, required this.data}) : super(key: key);
  static const routeName = '/InfoUserPage';
  final ScreenArguments data;

  @override
  State<InfoUserPage> createState() => _InfoUserPageState();
}

class _InfoUserPageState extends State<InfoUserPage> {
  late String _image;
  late String _nameUser;

  @override
  void initState() {
    super.initState();
    _nameUser = widget.data.arg1;
    _image = widget.data.arg2;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            stretch: true,
            expandedHeight: ScreenUtil.getInstance().getAdapterSize(200),
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                _image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  height: ScreenUtil.getInstance().getAdapterSize(150),
                  width: ScreenUtil.getInstance().screenWidth,
                  margin: EdgeInsets.all(
                      ScreenUtil.getInstance().getAdapterSize(16)),
                  child: Column(
                    children: [
                      _infoUserWidget(
                          param1: S.current.name_user, param2: _nameUser),
                      Divider(thickness: 1),
                      _infoUserWidget(
                          param1: S.current.date_of_birth,
                          param2: '19/11/2000'),
                      Divider(thickness: 1),
                      _infoUserWidget(param1: S.current.age_user, param2: '21'),
                      Divider(thickness: 1),
                      _infoUserWidget(
                          param1: S.current.phone_user, param2: '01234567890'),
                    ],
                  ),
                ),
                Container(
                  height: ScreenUtil.getInstance().getAdapterSize(150),
                  width: ScreenUtil.getInstance().screenWidth,
                  margin: EdgeInsets.all(
                      ScreenUtil.getInstance().getAdapterSize(16)),
                  child: Column(
                    children: [
                      _infoUserWidget(
                          param1: S.current.gender_user, param2: 'Male'),
                      Divider(thickness: 1),
                      _infoUserWidget(param1: S.current.height, param2: '1.74'),
                      Divider(thickness: 1),
                      _infoUserWidget(param1: S.current.weight, param2: '53'),
                      Divider(thickness: 1),
                      _infoUserWidget(
                          param1: S.current.job, param2: 'Mobile Developer'),
                    ],
                  ),
                ),
                Container(
                  height: ScreenUtil.getInstance().getAdapterSize(150),
                  width: ScreenUtil.getInstance().screenWidth,
                  margin: EdgeInsets.all(
                      ScreenUtil.getInstance().getAdapterSize(16)),
                  child: Column(
                    children: [
                      _infoUserWidget(
                          param1: S.current.phone_user, param2: '01234567890'),
                      Divider(thickness: 1),
                      _infoUserWidget(
                          param1: S.current.relationship, param2: 'Marry'),
                      Divider(thickness: 1),
                      _infoUserWidget(
                          param1: S.current.interests, param2: 'Code'),
                      Divider(thickness: 1),
                      _infoUserWidget(
                          param1: S.current.zodiac, param2: 'Scorpio'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoUserWidget({String? param1, String? param2}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          param1 ?? '',
          style: TextStyle(
              fontSize: ScreenUtil.getInstance().getAdapterSize(16),
              fontWeight: FontWeight.w500),
        ),
        Text(
          param2 ?? '',
          style: TextStyle(
            fontSize: ScreenUtil.getInstance().getAdapterSize(16),
          ),
        ),
      ],
    );
  }
}
