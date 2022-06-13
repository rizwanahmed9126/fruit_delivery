import 'package:flutter/material.dart';
import 'package:fruit_delivery_flutter/local/app_localization.dart';
import 'package:fruit_delivery_flutter/providers/app_language_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/select_account_widget.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:relative_scale/relative_scale.dart';

class SelectAccountScreen extends StatefulWidget {
  @override
  _SelectAccountScreenState createState() => _SelectAccountScreenState();
}

class _SelectAccountScreenState extends State<SelectAccountScreen> {
  String tagId = ' ';
  void active(
    dynamic val,
  ) {
    setState(() {
      tagId = val;
    });
  }

  var locale;
  void initState() {
    locale = Provider.of<AppLanguage>(context, listen: false).appCurrentLocale;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> selectAccountList = [
      {
        "id": "1",
        "label": AppLocalizations.of(context).translate('SelectUser'),
      },
      // {
      //   "id": "2",
      //   "label": AppLocalizations.of(context).translate('SelectGuest'),
      // },
      {
        "id": "2",
        "label": AppLocalizations.of(context).translate('SelectDriver'),
      },
    ];
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.only(top: sy(100)),
                child: Image.asset(
                  "assets/images/Logo1.png",
                  // color: Colors.transparent,
                  fit: BoxFit.fill,
                  height: sy(80),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, top: sy(30)),
              child: Text(
                // "Select Account",
                AppLocalizations.of(context).translate('selectAccount'),
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: sy(15)),
              ),
            ),
            SizedBox(
              height: sy(10),
            ),
            Container(
              // margin: EdgeInsets.only(left: 20, right: 20),
              width: sx(410),
              child: Text(
                "Lorem ipsum dolor sit amet, consectetur elit adipiscing elit, set do eiusmod.",
                style: TextStyle(color: HexColor('#8F9CA8'), fontSize: sy(10)),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Container(
                width: sy(200),
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: selectAccountList.length,
                  itemBuilder: (ctx, i) {
                    return SelectAccountWidget(
                      data: selectAccountList[i],
                      action: active,
                      tag: selectAccountList[i]['id'],
                      active:
                          tagId == selectAccountList[i]['id'] ? true : false,
                    );
                  },
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
