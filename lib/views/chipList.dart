import 'package:bored/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopicItem {
  String data;
  bool isSelected;

  Function onTap;
  TopicItem({String data, bool isSelected}) {
    this.data = data;

    this.isSelected = isSelected;
  }
}
class ChipList extends StatefulWidget {
  ChipList({Key key}) : super(key: key);

  @override
  _ChipListState createState() => _ChipListState();
}

class _ChipListState extends State<ChipList> {
  Color _getChipBG(String currentThemeColor) {
    switch (currentThemeColor) {
      case 'Color(0xff000000)':
        return Color.fromRGBO(240, 238, 246, 1);
      case 'Color(0xffffffff)':
        return Color.fromRGBO(34, 34, 36, 1);

      default:
        return Color.fromRGBO(34, 30, 37, 1);
    }
  }

  Color _getUnselectedChipTextColor(String currentThemeColor) {
    switch (currentThemeColor) {
      case 'Color(0xff000000)':
        return Colors.black;
      case 'Color(0xffffffff)':
        return Colors.white;

      default:
        return Colors.black;
    }
  }

  Color _getSelectedChipTextColor(String currentThemeColor) {
    switch (currentThemeColor) {
      case 'Color(0xff000000)':
        return Colors.white;
      case 'Color(0xffffffff)':
        return Colors.black;

      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (cat == null) {
      return CupertinoActivityIndicator();
    }
    return Padding(
      padding:  EdgeInsets.fromLTRB(1, 15, 1, 2),
      child: Wrap(
          alignment: WrapAlignment.start,
          // crossAxisAlignment: WrapCrossAlignment.start,
          spacing: 2,
          runSpacing: -3,
          children: List<Widget>.generate(
            cat.length,
            (index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: ChoiceChip(
                // visualDensity: VisualDensity.compact,
                labelPadding: EdgeInsets.fromLTRB(7, 0, 7, 0),
                selectedColor: Colors.white,
                backgroundColor: cat[index].isSelected ? Colors.white : Colors.black26,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(14))),
                label: Text(capitalize(cat[index].data),
                    style: cat[index].isSelected
                        ? Theme.of(context).textTheme.bodyText1.copyWith(
                              color: Colors.black,
                              fontFamily: 'Helvetica',
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            )
                        : Theme.of(context).textTheme.bodyText1.copyWith(
                            fontFamily: 'Helvetica',
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w600)),
                selected: cat[index].isSelected,
                onSelected: (bl) {
                  cat[index].isSelected =
                      !cat[index].isSelected;

                  /* 
                          if (value) {
                            selectedList.add(topicList[index]);
                          } else {
                            List<String> removeList = List();
                            selectedList.forEach((element) {
                              if (topicList[index] == element) {
                                removeList.add(element);
                              }
                            });
                            selectedList
                                .removeWhere((element) => removeList.contains(element));
                          }
                         */
                  

                  setState(() {
                   addToCategoryList(cat[index].data); 
                  });
                },
              ),
            ),
          )),
    );
  }
}
