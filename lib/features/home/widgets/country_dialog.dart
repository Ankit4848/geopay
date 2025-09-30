import 'package:geopay/core/core.dart';
import 'package:geopay/features/authentication/pages/register/controller/register_controller.dart';
import 'package:geopay/features/common/controller/common_controller.dart';
import 'package:geopay/features/home/model/OpratorModel.dart';
import 'package:geopay/features/home/model/productsModel.dart';
import 'package:geopay/features/home/view/pages/pay_to_wallet/controller/pay_to_wallet_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/model/country_model.dart';
import '../view/pages/airtime/controller/airtime_controller.dart';

class CountryDialog extends StatelessWidget {
  final TextEditingController searchController;
  final VoidCallback onClose;
  final Function(String?) onChange;
  final Function(CountryModel countryModel) onCountrySelect;
  // final List<CountryModel> countryList;
  const CountryDialog(
      {super.key,
      required this.searchController,
      required this.onClose,
      required this.onChange,
      // required this.countryList,
      required this.onCountrySelect});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PayToWalletController>(builder: (registerController) {
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
                  child: GetBuilder<PayToWalletController>(
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

class CountryDialogAirTime extends StatelessWidget {
  final TextEditingController searchController;
  final VoidCallback onClose;
  final Function(String?) onChange;
  final Function(CountryModel countryModel) onCountrySelect;
  // final List<CountryModel> countryList;
  const CountryDialogAirTime(
      {super.key,
      required this.searchController,
      required this.onClose,
      required this.onChange,
      // required this.countryList,
      required this.onCountrySelect});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AirtimeController>(builder: (registerController) {
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
                  child: GetBuilder<AirtimeController>(
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


class OpratorDialogAirTime extends StatelessWidget {
  final TextEditingController searchController;
  final VoidCallback onClose;
  final Function(String?) onChange;
  final Function(OpratorModel countryModel) onCountrySelect;
  // final List<CountryModel> countryList;
  const OpratorDialogAirTime(
      {super.key,
        required this.searchController,
        required this.onClose,
        required this.onChange,
        // required this.countryList,
        required this.onCountrySelect});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AirtimeController>(builder: (registerController) {
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
                  hintText: 'Search Operator',
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
                  child: GetBuilder<AirtimeController>(
                      builder: (registerController) {
                        return GetBuilder<CommonController>(
                            builder: (commonController) {
                              return ListView.separated(
                                shrinkWrap: true,
                                itemCount: registerController
                                    .searchController.value.text
                                    .trim()
                                    .isEmpty
                                    ? registerController.opratorList.length
                                    : registerController.searchOpratorList.length,
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
                                          ? registerController.opratorList[index]
                                          : registerController
                                          .searchOpratorList[index]);
                                    },
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.symmetric(vertical: 6.0),
                                      child: Row(
                                        children: [

                                          const SizedBox(
                                            width: 16,
                                          ),
                                          Flexible(
                                              child: Text(registerController
                                                  .searchController.value.text
                                                  .trim()
                                                  .isEmpty
                                                  ? registerController
                                                  .opratorList[index].name ??
                                                  ''
                                                  : registerController
                                                  .searchOpratorList[index]
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


class ProductDialogAirTime extends StatelessWidget {
  final TextEditingController searchController;
  final VoidCallback onClose;
  final Function(String?) onChange;
  final Function(ProductsModel countryModel) onCountrySelect;
  // final List<CountryModel> countryList;
  const ProductDialogAirTime(
      {super.key,
        required this.searchController,
        required this.onClose,
        required this.onChange,
        // required this.countryList,
        required this.onCountrySelect});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AirtimeController>(builder: (registerController) {
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
                  hintText: 'Search Operator',
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
                  child: GetBuilder<AirtimeController>(
                      builder: (registerController) {
                        return GetBuilder<CommonController>(
                            builder: (commonController) {
                              return ListView.separated(
                                shrinkWrap: true,
                                itemCount: registerController
                                    .searchController.value.text
                                    .trim()
                                    .isEmpty
                                    ? registerController.productList.length
                                    : registerController.searchProductList.length,
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
                                          ? registerController.productList[index]
                                          : registerController
                                          .searchProductList[index]);
                                    },
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.symmetric(vertical: 6.0),
                                      child: Row(
                                        children: [

                                          const SizedBox(
                                            width: 16,
                                          ),
                                          Flexible(
                                              child: Text(registerController
                                                  .searchController.value.text
                                                  .trim()
                                                  .isEmpty
                                                  ? registerController
                                                  .productList[index].name ??
                                                  ''
                                                  : registerController
                                                  .searchProductList[index]
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
