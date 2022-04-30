import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sariyor/features/events/models/base/base_category_model.dart';

import '../enums/image_route_enum.dart';

class CategoryPicker extends StatelessWidget {
  CategoryPicker({Key? key, required this.categories, required this.onSelected})
      : super(key: key);

  List<Category> categories;
  late Category selectedCategory;
  Function(Category) onSelected;

  @override
  Widget build(BuildContext context) {
    selectedCategory = categories[0];
    return ElevatedButton(
        onPressed: () async {
          await showModalBottomSheet(
              context: context,
              builder: (context) {
                return Wrap(children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: CupertinoPicker(
                      itemExtent: 90.0,
                      onSelectedItemChanged: (item) {
                        selectedCategory = categories[item];
                      },
                      children: List.generate(
                          categories.length,
                          (index) => ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  backgroundImage: NetworkImage(ImageRouteType
                                      .category
                                      .url(categories[index].imagePath)),
                                ),
                                title: Text(categories[index].name),
                                subtitle: Text(categories[index].id.toString()),
                              )),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: ElevatedButton(
                          onPressed: () {
                            onSelected(selectedCategory);
                            Navigator.pop(context);
                          },
                          child: const Text("Seç")),
                    ),
                  )
                ]);
              });
        },
        child: const Text("Kategori Seçiniz."));
  }
}
