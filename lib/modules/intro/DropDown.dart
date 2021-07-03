import 'package:flutter/material.dart';
import 'package:give_up_drugs/shared/components/constants.dart';

class DropDown extends StatefulWidget {
  @override
  _DropDownState createState() => _DropDownState();
}

List typesOFAddiction = [
  "المخدارت",
  "الالعاب الالكترونية",
  'الاباحية',
];

List stagesOFAddiction = [
  "قبل الادمان",
  "الادمان",
  'بعد الادمان',
];

class _DropDownState extends State<DropDown> {
  bool isStrechedDropDown = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey, width: 1.0),
                  ),
                  child: DropdownButton(
                    dropdownColor: Colors.white60,
                    icon: Icon(Icons.arrow_circle_down_rounded),
                    iconSize: 36,
                    underline: SizedBox(),
                    isExpanded: true,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                    hint: Text('نوع الادمان'),
                    value: valueChose1,
                    onChanged: (typeVideo) {
                      setState(() {
                        valueChose1 = typeVideo;
                      });
                    },
                    items: typesOFAddiction.map((vlaueItem) {
                      return DropdownMenuItem(
                        value: vlaueItem,
                        child: Text(vlaueItem),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey, width: 1.0),
                  ),
                  child: DropdownButton(
                    dropdownColor: Colors.white60,
                    icon: Icon(Icons.arrow_circle_down_rounded),
                    iconSize: 36,
                    underline: SizedBox(),
                    isExpanded: true,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                    hint: Text('مرحله الادمان'),
                    value: valueChose2,
                    onChanged: (levelVideo) {
                      setState(() {
                        valueChose2 = levelVideo;
                      });
                    },
                    items: stagesOFAddiction.map((vlaueItem) {
                      return DropdownMenuItem(
                        value: vlaueItem,
                        child: Text(vlaueItem),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
