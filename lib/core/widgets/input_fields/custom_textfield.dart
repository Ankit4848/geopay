import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? helpText;
  final Widget? suffixIcon;
  final TextInputType? textInputType;
  final bool? isObscureText;
  final bool isRequired;
  final String? labelText;
  final EdgeInsets? padding;
  final EdgeInsets? contentPadding;
  final String? initialValue;
  final FocusNode? focusNode;
  final VoidCallback? onTap;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefixIcon;
  final Widget? prefix;
  final Widget? suffix;
  final double? width;
  final TextStyle? hintStyle;
  final double? radius;
  final double? fontSize;
  final int? maxLine;
  final int? minLine;
  final Color? filledColor;
  final bool? isGradientBorder;
  final bool showBorder;
  final bool showUnderLine;
  final bool isVerified;
  final String? Function(String? value)? validator;
  final Function(String? value)? onChange;
  final BoxConstraints? prefixIconConstraints;
  final Widget? errorWidget;

  const CustomTextField(
      {super.key,
      this.controller,
      this.hintText,
      this.suffixIcon,
      this.textInputType,
      this.isObscureText,
      this.labelText,
      this.padding,
      this.onTap,
      this.inputFormatters,
      this.helpText,
      this.prefixIcon,
      this.fontSize,
      this.focusNode,
      this.width,
      this.maxLine,
      this.validator,
      this.filledColor,
      this.onChange,
      this.initialValue,
      this.radius,
      this.minLine,
      this.isRequired = false,
      this.showUnderLine = false,
      this.hintStyle,
      this.isGradientBorder = false,
      this.prefixIconConstraints,
      this.showBorder = false,
      this.suffix,
      this.contentPadding,
      this.prefix,
      this.isVerified = false,
      this.errorWidget});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (labelText != null) ...{
            Padding(
              padding: const EdgeInsets.only(
                left: 5,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    labelText!,
                    style: FontUtilities.style(
                      fontSize: fontSize ?? 14,
                      fontWeight: FWT.semiBold,
                      fontFamily: FontFamily.poppins,
                      fontColor: VariableUtilities.theme.primaryColor,
                    ),
                  ),
                  Visibility(
                    visible: isVerified,
                    child: Text(
                      'Verified',
                      style: FontUtilities.style(
                        fontSize: 12,
                        fontWeight: FWT.bold,
                        fontFamily: FontFamily.poppins,
                        fontColor: const Color(0xFF51C927),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 9,
            ),
          },
          SizedBox(
            width: width ?? double.infinity,
            child: TextFormField(
              cursorColor: VariableUtilities.theme.blackColor,
              inputFormatters: inputFormatters,
              focusNode: focusNode,
              enableInteractiveSelection: onTap == null,
              toolbarOptions: onTap != null
                  ? const ToolbarOptions(
                      copy: false,
                      cut: false,
                      paste: false,
                      selectAll: false,
                    )
                  : null,
              style: FontUtilities.style(
                fontSize: fontSize ?? 13,
                fontWeight: FWT.regular,
                fontColor: VariableUtilities.theme.thirdColor,
              ),
              initialValue: initialValue,
              readOnly: onTap != null ? true : false,
              controller: controller,
              onTap: onTap,
              onChanged: onChange,
              maxLines: maxLine ?? 1,
              minLines: minLine ?? 1,
              validator: validator,

              keyboardType: textInputType,
              obscureText: isObscureText ?? false,
              decoration: InputDecoration(
                contentPadding:
                    contentPadding ?? const EdgeInsets.fromLTRB(12, 14, 12, 12),
                suffix: suffix,
                suffixIconConstraints: const BoxConstraints(
                  maxHeight: 16,
                  minWidth: 16,
                ),
                filled: (isGradientBorder ?? false) ? false : true,
                fillColor:
                    filledColor ?? VariableUtilities.theme.textFieldFilledColor,
                prefixIconConstraints: prefixIconConstraints ??
                    const BoxConstraints(
                      maxHeight: 16,
                      minWidth: 16,
                    ),
                prefixIcon: prefixIcon,
                prefix: prefix,

                border: OutlineInputBorder(
                  borderSide: showBorder
                      ? BorderSide(
                          color: VariableUtilities.theme.whiteColor, width: 0.8)
                      : BorderSide.none,
                  borderRadius: BorderRadius.circular(radius ?? 10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: showBorder
                      ? BorderSide(
                          color: VariableUtilities.theme.whiteColor, width: 0.8)
                      : BorderSide.none,
                  borderRadius: BorderRadius.circular(radius ?? 10),
                ),
                focusedBorder: showUnderLine
                    ? UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: VariableUtilities.theme.primaryColor,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(radius ?? 10),
                      )
                    : OutlineInputBorder(
                        borderSide: showBorder
                            ? BorderSide(
                                color: VariableUtilities.theme.whiteColor,
                                width: 0.8)
                            : BorderSide.none,
                        borderRadius: BorderRadius.circular(radius ?? 10),
                      ),
                disabledBorder: OutlineInputBorder(
                  borderSide: showBorder
                      ? BorderSide(
                          color: VariableUtilities.theme.whiteColor, width: 0.8)
                      : BorderSide.none,
                  borderRadius: BorderRadius.circular(radius ?? 10),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: showBorder
                      ? BorderSide(
                          color: VariableUtilities.theme.whiteColor, width: 0.8)
                      : BorderSide.none,
                  borderRadius: BorderRadius.circular(radius ?? 10),
                ),
                isDense: true,
                hintText: hintText ?? '',
                // ✅ Only one is set at a time
                errorText: errorWidget == null ? '' : null,
                error: errorWidget,
                errorStyle: TextStyle(
                  fontSize: 10,
                  color: VariableUtilities.theme.redColor,
                ),

                hintStyle: hintStyle ??
                    FontUtilities.style(
                      fontSize: 12,
                      fontWeight: FWT.regular,
                      fontColor: VariableUtilities.theme.thirdColor,
                    ),
                suffixIcon: suffixIcon,
              ),
            ),
          ),
          if (helpText != null) ...{
            const SizedBox(height: 5),
            Text(
              helpText!,
              style: FontUtilities.style(
                fontSize: 12,
                fontWeight: FWT.regular,
                fontColor: VariableUtilities.theme.redColor,
              ),
            ),
          },

        ],
      ),
    );
  }
}

class CustomDateField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool isRequired;
  final EdgeInsets? padding;
  final TextStyle? hintStyle;
  final String? hintText;
  final Color? fillColor;

  const CustomDateField({
    super.key,
    required this.controller,
    required this.labelText,
    this.isRequired = false,
    this.padding,
    this.hintStyle,
    this.hintText,
    this.fillColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (labelText.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 5, bottom: 8),
              child: Text(
                isRequired ? "$labelText *" : labelText,
                style: FontUtilities.style(
                  fontSize: 14,
                  fontWeight: FWT.semiBold,
                  fontFamily: FontFamily.poppins,
                  fontColor: VariableUtilities.theme.primaryColor,
                ),
              ),
            ),
          GestureDetector(
            onTap: () async {
              FocusScope.of(context).unfocus(); // Dismiss keyboard
              final pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2100),
              );
              if (pickedDate != null) {
                controller.text = pickedDate.toString().split(' ')[0];
              }
            },
            child: AbsorbPointer( // Prevents typing, allows tap
              child: TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  hintText: hintText ?? 'Select Date',
                  suffixIcon: const Icon(Icons.calendar_today, size: 18),
                  filled: true,
                  fillColor: fillColor ?? VariableUtilities.theme.textFieldFilledColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  hintStyle: hintStyle ??
                      FontUtilities.style(
                        fontSize: 12,
                        fontWeight: FWT.regular,
                        fontColor: VariableUtilities.theme.thirdColor,
                      ),
                ),
                readOnly: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

