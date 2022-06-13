import 'package:flutter/material.dart';
import 'package:fruit_delivery_flutter/local/app_localization.dart';
import 'package:fruit_delivery_flutter/providers/app_language_provider.dart';
import 'package:provider/src/provider.dart';

import '../services/navigation_service.dart';
import '../utils/service_locator.dart';
import '../widgets/radioList_widget.dart';

class LanguagesScreen extends StatefulWidget {
  @override
  _LanguagesScreenState createState() => _LanguagesScreenState();
}

class _LanguagesScreenState extends State<LanguagesScreen> {
  var navigationService = locator<NavigationService>();

  String tagId = '1';
  void active(
    dynamic val,
  ) {
    setState(() {
      tagId = val;
      context.read<AppLanguage>().id = val;
    });
  }

  // @override
  // void initState() {
  //   tagId == "1";
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> languageList = [
      {
        "id": "1",
        "label": AppLocalizations.of(context).translate('English'),
      },
      {
        "id": "2",
        "label": AppLocalizations.of(context).translate('Spanish'),
      },
      {
        "id": "3",
        "label": AppLocalizations.of(context).translate('Vietnamese'),
      },
      {
        "id": "4",
        "label": AppLocalizations.of(context).translate('Combodian'),
      },
      {
        "id": "5",
        "label": AppLocalizations.of(context).translate('Portuguese'),
      },
      {"id": "6", "label": AppLocalizations.of(context).translate('Hindi')},
    ];
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.keyboard_arrow_left,
              color: Colors.black,
              size: 35,
            ),
            onPressed: () {
              Navigator.pop(context);
              // navigationService.navigateTo(MainDashboardScreenRoute);
            },
          ),
          centerTitle: true,
          title: Text(
            AppLocalizations.of(context).translate('selectLanguage'),
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Column(children: [
              SizedBox(
                height: 15,
              ),
              Expanded(
                child: ListView.builder(
                    padding: EdgeInsets.only(top: 5),
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: languageList.length,
                    itemBuilder: (ctx, i) {
                      return RadioButtionWidget(
                        data: languageList[i],
                        tag: languageList[i]['id'],
                        action: active,
                        active: context.read<AppLanguage>().id == ""
                            ? tagId == languageList[i]['id']
                                ? true
                                : false
                            : context.read<AppLanguage>().id ==
                                    languageList[i]['id']
                                ? true
                                : false,
                      );
                    }),
              ),
            ]),
          ),
        ));
  }
}
