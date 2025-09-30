import 'package:geopay/core/core.dart';
import 'package:geopay/features/authentication/pages/register/controller/register_controller.dart';
import 'package:geopay/features/common/controller/common_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/model/country_model.dart';

class SelectCountryDialog extends StatelessWidget {
  final TextEditingController searchController;
  final VoidCallback onClose;
  final Function(String?) onChange;
  final Function(CountryModel countryModel) onCountrySelect;
  // final List<CountryModel> countryList;
  const SelectCountryDialog(
      {super.key,
      required this.searchController,
      required this.onClose,
      required this.onChange,
      // required this.countryList,
      required this.onCountrySelect});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(builder: (registerController) {
      return Dialog(
        backgroundColor: VariableUtilities.theme.whiteColor,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: StatefulBuilder(builder: (context, StateSetter setState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(Icons.close),
                    )
                  ],
                ),
                CustomTextField(
                  controller: searchController,
                  prefixIcon: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Icon(CupertinoIcons.search),
                  ),
                  hintText: 'Search Country',
                  suffix: GestureDetector(
                    onTap: () {
                      onClose();
                      setState.call(() {});
                    },
                    child: const Icon(
                      Icons.close,
                      size: 18,
                    ),
                  ),
                  onChange: (value) {
                    onChange(value);
                    setState.call(() {});
                  },
                ),
                Expanded(
                  child: GetBuilder<RegisterController>(
                      builder: (registerController) {
                    return GetBuilder<CommonController>(
                        builder: (commonController) {
                      return ListView.separated(
                        shrinkWrap: true,
                        itemCount: registerController
                                .searchController.value.text
                                .trim()
                                .isEmpty
                            ? commonController.countryList.length
                            : registerController.searchCountryList.length,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 12),
                        separatorBuilder: (context, index) {
                          return Container(
                            height: 1,
                            width: Get.width,
                            margin: const EdgeInsets.symmetric(vertical: 3),
                            color: VariableUtilities.theme.blackColor
                                .withOpacity(0.12),
                          );
                        },
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Get.back();
                              onCountrySelect(registerController
                                      .searchController.value.text
                                      .trim()
                                      .isEmpty
                                  ? commonController.countryList[index]
                                  : registerController
                                      .searchCountryList[index]);
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 6.0),
                              child: Row(
                                children: [
                                  CachedNetworkImageView(
                                    imageUrl: registerController
                                            .searchController.value.text
                                            .trim()
                                            .isEmpty
                                        ? commonController.countryList[index]
                                                .countryFlag ??
                                            ''
                                        : registerController
                                                .searchCountryList[index]
                                                .countryFlag ??
                                            '',
                                    height: 24,
                                    width: 24,
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Flexible(
                                      child: Text(registerController
                                              .searchController.value.text
                                              .trim()
                                              .isEmpty
                                          ? commonController
                                                  .countryList[index].name ??
                                              ''
                                          : registerController
                                                  .searchCountryList[index]
                                                  .name ??
                                              ''))
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    });
                  }),
                )
              ],
            );
          }),
        ),
      );
    });
  }
}
