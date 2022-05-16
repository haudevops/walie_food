import 'package:flutter/material.dart';
import 'package:walie_food/utils/util_export.dart';

import '../../generated/l10n.dart';

class SaveItemPage extends StatefulWidget {
  const SaveItemPage({Key? key}) : super(key: key);
  static const routeName = '/SaveItemPage';

  @override
  State<SaveItemPage> createState() => _SaveItemPageState();
}

class _SaveItemPageState extends State<SaveItemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.current.save_item,
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: AppColor.colorPrimaryButton,
        ),
        elevation: 0,
      ),
    );
  }
}
