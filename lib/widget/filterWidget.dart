import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/services.dart';
import 'package:nebulashoppy/uttils/sharedpref.dart';
import 'package:nebulashoppy/widget/common_widget.dart';
import 'package:nebulashoppy/widget/forgotpasswordDialoug.dart';

import '../model/getcartCountResponse/getAddToCartResponse.dart';
import '../network/service.dart';
import '../screen/webview.dart';
import '../uttils/constant.dart';
import 'package:page_transition/page_transition.dart';
import '../uttils/constant.dart';

class FilterWidget extends StatefulWidget {
  const FilterWidget(BuildContext context,
      {Key? key,
      required this.title,
      required this.description,
      required this.onFilterSelection,
      required this.onIndexSelected})
      : super(key: key);

  final String title, description;
  final VoidCallback onFilterSelection;
  final Function(int) onIndexSelected;

  @override
  _FilterWidgetState createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  static final _formKey = GlobalKey<FormState>();
  bool _passwordInVisible = true;

  String _selectedGender = 'All';
  final GlobalKey<State> _dialogKey = GlobalKey<State>();

  List<String> list_Filter = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addFilterList();
    print("SelectedAns" + int_SelectedFilterIndex.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Color(0xffffffff),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Visibility(
                    visible: false,
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(CommunityMaterialIcons.close_box),
                        color: Colors.cyan)),
              ),
              Padding(padding: EdgeInsets.all(0), child: Text("Sort By")),
              Container(
                margin: EdgeInsets.fromLTRB(0, 5, 10, 0),
                padding: EdgeInsets.fromLTRB(0, 5, 10, 0),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FutureBuilder(
                      builder: (context, snapshot) {
                        if (list_Filter.isEmpty) {
                          return Text("");
                        } else {
                          return ListView.builder(
                              itemCount: list_Filter.length,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext ctx, index) {
                                return Container(
                                    child: SizedBox(
                                        width: 50,
                                        height: 35,
                                        child: ListTile(
                                            leading: Radio<String>(
                                              value: list_Filter[index],
                                              groupValue: list_Filter[
                                                  int_SelectedFilterIndex],
                                              activeColor: buttonColor,
                                              onChanged: (value) {
                                                setState(() {
                                                  int_SelectedFilterIndex =
                                                      index;
                                                  _selectedGender = value!;
                                                  Navigator.pop(context);
                                                  widget.onIndexSelected(index);
                                                  widget.onFilterSelection();
                                                });
                                              },
                                            ),
                                            title: Text(list_Filter[index]))));
                              });
                        }
                      },
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }

  addFilterList() {
    list_Filter.add("All");
    list_Filter.add("Price: Low to High");
    list_Filter.add("Price: High to Low");
    list_Filter.add("A-Z");
    list_Filter.add("Z-A");
    list_Filter.add("Trending");
    list_Filter.add("New");
  }
}
