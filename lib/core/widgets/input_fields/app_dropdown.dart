// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../core.dart';

class AppDropDown<T> extends StatelessWidget {
  final T? value;
  final String? selectedValue;
  final Function(T? value)? onChange;
  final List<DropdownMenuItem<T>> items;
  final double? width;
  final double? dropDownWidth;
  final double? height;
  final bool? filled;
  final Color? fillColor;
  final bool showBorder;
  final bool isRequired;
  final bool showErrorPadding;

  final String? hintText;
  final EdgeInsets? contentPadding;
  final Color? borderColor;
  final Color? labelColor;
  final Color? textColor;
  final bool showLabel;
  final String? labelText;
  final bool paddingBottom;
  final double? iconSize;
  final double? borderRadius;
  final Color? iconColor;
  final bool showSearch;
  final String? Function(T? value)? onValidate;
  final bool Function(DropdownMenuItem<T> item, String searchValue)?
      searchMatchFn;
  final TextEditingController? searchCtrl;
  final Color? dropDownColor;
  final FocusNode? focusNode;
  final bool showIndiactionTop;
  final bool hideError;
  final TextStyle? hintStyle;

  AppDropDown({
    super.key,
    this.value,
    this.showLabel = false,
    this.onChange,
    required this.items,
    this.borderColor,
    this.showBorder = false,
    this.filled = false,
    this.height = 40,
    this.contentPadding,
    this.hintText,
    this.hideError = false,
    this.labelText,
    this.paddingBottom = false,
    this.dropDownColor,
    this.width,
    this.borderRadius,
    this.dropDownWidth,
    this.iconColor,
    this.iconSize,
    this.labelColor,
    this.textColor,
    this.showSearch = false,
    this.showErrorPadding = true,
    this.onValidate,
    this.focusNode,
    this.searchCtrl,
    this.searchMatchFn,
    this.showIndiactionTop = false,
    this.fillColor,
    this.selectedValue,
    this.hintStyle,
    this.isRequired = false,
  });

  RxnString showError = RxnString();
  final FocusNode searchFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (labelText != null || showLabel) ...[
          Text(
            labelText ?? '',
            style: FontUtilities.style(
              fontSize: 12,
              fontWeight: FWT.regular,
              fontColor: VariableUtilities.theme.blackColor,
            ),
          ),
          const SizedBox(
            height: 6,
          ),
        ],
        SizedBox(
          width: width,
          child: DropdownButtonFormField2<T>(
            style: FontUtilities.style(
                fontColor: textColor, fontSize: 12, fontWeight: FWT.bold),
            items: items,
            onChanged: onChange,
            focusNode: searchFocusNode,
            autofocus: true,
            value: value,
            validator: (value) {
              var result = onValidate?.call(value);
              showError.value = result;
              return result;
            },
            onSaved: onChange,
            hint: Text(
              hintText ?? '',
              overflow: TextOverflow.ellipsis,
              style: hintStyle ??
                  FontUtilities.style(
                    fontSize: 10,
                    fontWeight: FWT.regular,
                    fontColor: textColor ?? const Color(0xFFB0B4B9),
                  ),
            ),
            decoration: InputDecoration(
              hintStyle: hintStyle ??
                  FontUtilities.style(
                    fontSize: 12,
                    fontWeight: FWT.medium,
                    fontColor:
                        VariableUtilities.theme.blackColor.withOpacity(1),
                  ),
              contentPadding: EdgeInsets.zero,
              isDense: true,
              errorStyle: const TextStyle(height: 0.1, fontSize: 0),
              errorMaxLines: 2,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide.none,
              ),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide.none,
              ),
              disabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide.none,
              ),
              errorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide.none,
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide.none,
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide.none,
              ),
            ),
            buttonStyleData: ButtonStyleData(
              decoration: BoxDecoration(
                color: filled!
                    ? fillColor
                    : VariableUtilities.theme.textFieldFilledColor,
                border: showBorder
                    ? Border.all(
                        color:
                            borderColor ?? VariableUtilities.theme.blackColor,
                        width: .5,
                      )
                    : const Border(),
                borderRadius: BorderRadius.circular(borderRadius ?? 10),
              ),
              height: height,
              width: width,
              padding: contentPadding ??
                  const EdgeInsets.only(
                    right: 5,
                    left: 5,
                  ),
            ),
            iconStyleData: IconStyleData(
              icon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SvgPicture.asset(AssetUtilities.dropDown),
              ),
              openMenuIcon: Icon(
                Icons.keyboard_arrow_up_rounded,
                color: iconColor ?? VariableUtilities.theme.whiteColor,
              ),
            ),
            dropdownSearchData: showSearch
                ? DropdownSearchData(
                    searchInnerWidget: Container(
                      height: 60,
                      padding: const EdgeInsets.only(
                        left: 8,
                        right: 8,
                        top: 10,
                      ),
                      child: Center(
                        child: CustomTextField(
                          controller: searchCtrl,
                          hintText: 'Search...',
                          filledColor: VariableUtilities.theme.whiteColor
                              .withOpacity(0.1),
                        ),
                      ),
                    ),
                    searchController: searchCtrl,
                    searchInnerWidgetHeight: 0,
                    searchMatchFn: searchMatchFn,
                  )
                : null,
            dropdownStyleData: DropdownStyleData(
              maxHeight: 200,
              width: dropDownWidth ?? width,
              elevation: 1,
              useSafeArea: true,
              openInterval: const Interval(0, 1),
              decoration: BoxDecoration(
                color: filled!
                    ? dropDownColor
                    : VariableUtilities.theme.whiteColor.withOpacity(1),
              ),
            ),
            isExpanded: true,
          ),
        ),
        if (hideError)
          StreamBuilder<String?>(
            stream: showError.stream,
            builder: (context, snapshot) {
              return snapshot.data != null
                  ? Padding(
                      padding: const EdgeInsets.only(top: 6.0),
                      child: Text(
                        snapshot.data ?? '',
                        style: TextStyle(
                          fontSize: 12,
                          color: VariableUtilities.theme.redColor,
                        ),
                      ),
                    )
                  : SizedBox(
                      height: showErrorPadding ? 14 : 0,
                    );
            },
          ),
        if (showLabel && paddingBottom) ...[
          const SizedBox(
            height: 5,
          ),
        ],
      ],
    );
  }

  InputBorder getBorder() {
    return showBorder
        ? OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: borderColor ?? VariableUtilities.theme.whiteColor,
            ),
          )
        : InputBorder.none;
  }
}
