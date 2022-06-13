import 'package:flutter/material.dart';

class AddPopupWidget extends StatefulWidget {
  @override
  _AddPopupWidgetState createState() => _AddPopupWidgetState();
}

class _AddPopupWidgetState extends State<AddPopupWidget> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        Container(
          height: 500,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: [
                  Container(height: 45, width: 45, child: CircleAvatar()),
                  Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          hintText: "Name",
                          focusedBorder:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                          enabledBorder:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                        ),
                      ),
                      TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.shade400,
                          hintText: "Price",
                          focusedBorder:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                          enabledBorder:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(onPressed: () {}, child: Text("Add Items"))
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
