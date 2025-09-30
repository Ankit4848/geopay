import 'package:bounce/bounce.dart';
import 'package:geopay/core/core.dart';
import 'package:geopay/features/home/model/drop_down_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DropdownBottomsheet extends StatefulWidget {
  final String label;
  final List<DropDownModel> dropDownItemList;
  final Function(String?)? onChange;     // can be removed if not used externally
  final Function(int index) onTap;

  const DropdownBottomsheet({
    super.key,
    required this.label,
    this.onChange,
    required this.dropDownItemList,
    required this.onTap,
  });

  @override
  State<DropdownBottomsheet> createState() => _DropdownBottomsheetState();
}

class _DropdownBottomsheetState extends State<DropdownBottomsheet> {
  String _search = '';
  List<DropDownModel> _filteredList = [];

  @override
  void initState() {
    super.initState();
    _filteredList = widget.dropDownItemList;
  }

  void _onSearchChanged(String? value) {
    setState(() {
      _search = value!;
      _filteredList = widget.dropDownItemList
          .where((item) =>
          item.title.toLowerCase().contains(_search.trim().toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            width: Get.width * 0.79,
            height: Get.height * 0.50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.label,
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                // Add search box
                CustomTextField(
                  hintText: 'Search ${widget.label}',
                  onChange: _onSearchChanged,
                  prefixIcon: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Icon(CupertinoIcons.search),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: _filteredList.isEmpty?
                  const Center(
                    child: Text(
                      "No data found",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  )

                      :ListView.separated(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    separatorBuilder: (context, index) {
                      return Container(
                        height: 0.1,
                        color: Colors.black.withAlpha(80),
                      );
                    },
                    itemCount: _filteredList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Bounce(
                          onTap: () {
                            Get.back();
                            widget.onTap(
                              widget.dropDownItemList
                                  .indexOf(_filteredList[index]),
                            );
                          },
                          child: Row(
                            children: [
                              if (_filteredList[index].icon != null &&
                                  _filteredList[index].icon != "")
                                Container(
                                  height: 25,
                                  width: 25,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle),
                                  child:
                                  Image.network(_filteredList[index].icon!),
                                ),
                              if (_filteredList[index].icon != null &&
                                  _filteredList[index].icon != "")
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  _filteredList[index].title,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


