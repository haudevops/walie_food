import 'package:flutter/material.dart';
import 'package:walie_food/routers/routers_export.dart';
import 'package:walie_food/utils/screen_util.dart';

class ViewImageWidget extends StatefulWidget {
  const ViewImageWidget({Key? key, this.data}) : super(key: key);
  static const routeName = '/ViewImageWidget';
  final ScreenArguments? data;

  @override
  State<ViewImageWidget> createState() => _ViewImageWidgetState();
}

class _ViewImageWidgetState extends State<ViewImageWidget> {
  String? image;

  @override
  void initState() {
    super.initState();
    image = widget.data?.arg1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent,
        elevation: 0,),
      extendBodyBehindAppBar: true,
      body: Container(
        height: ScreenUtil.getInstance().screenHeight,
        width: ScreenUtil.getInstance().screenWidth,
        child: Hero(
          tag: 'dash',
          child: Image.network(image ?? '', fit: BoxFit.cover,),
        ),
      ),
    );
  }
}
