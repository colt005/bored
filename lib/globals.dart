
import 'dart:math';

import 'package:bored/views/chipList.dart';



String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
randomListItem(List lst) => lst[Random().nextInt(lst.length)];
List<String> dummyCategories = ['education','recreational','social','diy','charity','cooking','relaxation','music','busywork'];
List<String> categories = ['education','recreational','social','diy','charity','cooking','relaxation','music','busywork'];
List<TopicItem> cat = List.generate(
        dummyCategories.length,
        (index) => TopicItem(
            data: dummyCategories[index],
            isSelected: true));
Map<int, String> lookUpmap
 = Map.fromIterable(categories,
        key: (item) => categories.indexOf(item), value: (item) => item);

addToCategoryList(String toAdd) async {
  if (categories.contains(toAdd.toLowerCase())) {
    categories.remove(toAdd);
  } else {
    categories.add(toAdd.toLowerCase());
  }
  categories = categories.toSet().toList();

}