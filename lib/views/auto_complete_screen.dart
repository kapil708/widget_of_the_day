import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:widget_of_the_day/common/user_json.dart';

import '../common/constaint.dart';

// ignore: must_be_immutable
class AutoCompleteScreen extends StatelessWidget {
  AutoCompleteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Autocomplete")),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /*///Option 1
            stringBaseDropDown(),
            const SizedBox(height: 40),
*/
            ///Option 2
            classBaseDropDown(),
          ],
        ),
      ),
    );
  }
}

Widget stringBaseDropDown() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      //Simple option with string values
      const Text(
        "1. Simple view with string list",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
      const SizedBox(height: 16),
      Autocomplete<String>(
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text == '') {
            return const Iterable<String>.empty();
          }
          return names.where((String option) {
            //Option 1 : Start with
            return option.toLowerCase().startsWith(textEditingValue.text.toLowerCase());

            //Option 2: Contains
            return option.contains(textEditingValue.text.toLowerCase());
          });
        },
        onSelected: (String selection) {
          debugPrint('You just selected $selection');
        },
      ),
    ],
  );
}

Widget classBaseDropDown() {
  List<User> userList = List<User>.from(users.map((json) => User.fromJson(json)));

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        "2. Custom view with class",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
      const SizedBox(height: 16),
      Autocomplete<User>(
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text == '') {
            return const Iterable<User>.empty();
          }

          return userList.where((User option) {
            String fullName = '${option.name.title} ${option.name.first}  ${option.name.last}';
            return fullName.toLowerCase().toString().contains(textEditingValue.text.toLowerCase());
          });
        },
        displayStringForOption: (User val) {
          String fullName = '${val.name.title} ${val.name.first}  ${val.name.last}';

          return fullName;
        },
        optionsViewBuilder: (context, onSelected, options) {
          return Align(
            alignment: Alignment.topLeft,
            child: Material(
              elevation: 4.0,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: 400,
                  maxWidth: MediaQuery.of(context).size.width - 32,
                ),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: options.length,
                  itemBuilder: (context, index) {
                    return Material(
                      child: Builder(builder: (BuildContext context) {
                        final bool highlight = AutocompleteHighlightedOption.of(context) == index;
                        if (highlight) {
                          SchedulerBinding.instance.addPostFrameCallback((Duration timeStamp) {
                            Scrollable.ensureVisible(context, alignment: 0.5);
                          });
                        }

                        User user = options.elementAt(index);
                        String fullName = '${user.name.title} ${user.name.first}  ${user.name.last}';

                        return Container(
                          color: highlight ? Theme.of(context).focusColor : null,
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              ClipOval(
                                child: Image.network(
                                  user.picture.thumbnail,
                                  height: 24,
                                  width: 24,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                fullName,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    );
                  },
                ),
              ),
            ),
          );
        },
        onSelected: (User val) {
          String fullName = '${val.name.title} ${val.name.first}  ${val.name.last}';
          debugPrint('You just selected $fullName');
        },
        fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
          return TextFormField(
            controller: textEditingController,
            focusNode: focusNode,
            onFieldSubmitted: (String value) => onFieldSubmitted(),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: const BorderSide(width: 3, color: Colors.greenAccent),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          );
        },
      ),
    ],
  );
}

class User {
  late Name name;
  late String phone;
  late Picture picture;

  User({required this.name, required this.phone, required this.picture});

  User.fromJson(Map<String, dynamic> json) {
    name = Name.fromJson(json['name']);
    picture = Picture.fromJson(json['picture']);
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name.toJson();
    data['picture'] = picture!.toJson();
    data['phone'] = phone;
    return data;
  }
}

class Name {
  late String title;
  late String first;
  late String last;

  Name({required this.title, required this.first, required this.last});

  Name.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    first = json['first'];
    last = json['last'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['first'] = first;
    data['last'] = last;
    return data;
  }
}

class Picture {
  late String large;
  late String medium;
  late String thumbnail;

  Picture({required this.large, required this.medium, required this.thumbnail});

  Picture.fromJson(Map<String, dynamic> json) {
    large = json['large'];
    medium = json['medium'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['large'] = large;
    data['medium'] = medium;
    data['thumbnail'] = thumbnail;
    return data;
  }
}
