import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:leen_alkhier_store/providers/phoneCode_provider.dart';
import 'package:leen_alkhier_store/utils/colors.dart';
import 'package:leen_alkhier_store/utils/image_manager.dart';
import 'package:leen_alkhier_store/utils/local_const.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';

class CustomTextField extends StatefulWidget {
  String? lablel;
  Widget? icon;
  Widget? sufficIcon;
  Color? filledColor;
  bool isMobile;
  TextAlign? alignment;
  TextEditingController? controller;
  String? errorMessage;

  bool hasPassword;
  bool isEmail;
  bool? passwordIdentical;
  bool isPhoneCode;
  bool isFinal;
  bool isEditable;
  bool isNotes;
  bool hasBorder;
  bool? chat;
  bool? isQuantity;
  TextDirection? direction;
  GlobalKey<FormState>? formKey;
  Function? onFieldSubmitted;
 void Function()? onTap;
  bool? isProfile;
  bool? isValidator;

  FocusNode? focusNode;

  CustomTextField(
      {this.icon,
      this.lablel,
      this.filledColor,
      this.formKey,
      this.focusNode,
      this.isValidator = true,
      this.hasBorder = true,
      this.isEditable = true,
      this.isNotes = false,
      this.alignment,
      this.isFinal = false,
      this.isPhoneCode = false,
      this.isMobile = false,
      this.isEmail = false,
      this.passwordIdentical,
      this.hasPassword = false,
      this.controller,
      this.sufficIcon,
      this.errorMessage = '',
      this.isQuantity,
      this.direction,
        this.onTap,
      this.chat,
      this.onFieldSubmitted,
      this.isProfile});

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool showPassword = true;

  List<String> codes = ['+20', '+966'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.isValidator!
          ? (value) {
        if (value == null || value.isEmpty) {
          return widget.errorMessage!.isEmpty
              ? null
              : widget.errorMessage!.tr();
        }
        else {
          if (widget.isMobile) {
            Pattern pattern = r'^(009665|009715|00965|9665|9715|\+9665||\+9715|\+9655|05|5)(5|0|3|6|4|9|1|8|7|2)([0-9]{7})?$';
            RegExp regex = new RegExp(pattern.toString());
            if (!regex.hasMatch(value) || value.length <9)
              return kEnter_the_phone_correctly.tr();

            else {
              if (!value.startsWith(RegExp(
                  r'(009665|009715|00965|9665|9715|\+9665||\+9715|\+965|05|5)'))) {
                value = "00966" + value;
                print("value : ${value}");
                return value;
              }
            }
          }
          else {
            return null;
          }

          // return null;
        }
      }

          : (value) {},
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: widget.controller,
      enabled: widget.isEditable,
      onEditingComplete: () {
        widget.formKey!.currentState!.validate();
      },
      onTap: widget.onTap == null? (){

        if( widget.controller!.selection == TextSelection.fromPosition(TextPosition(offset:  widget.controller!.text.length -1))){
          setState(() {
            widget.controller!.selection = TextSelection.fromPosition(TextPosition(offset:  widget.controller!.text.length));
          });
        }
      } : widget.onTap,
      textInputAction:
          (widget.chat == null) ? TextInputAction.next : TextInputAction.done,
      onFieldSubmitted: (value) {
        widget.onFieldSubmitted!();
      },
      focusNode: widget.focusNode,
      autofocus: false,
      obscureText: (widget.hasPassword) ? showPassword : widget.hasPassword,
      maxLines: (widget.isNotes) ? 3 : 1,
      textAlign: widget.alignment != null
          ? TextAlign.center
          : (translator.activeLanguageCode == "ar")
              ? TextAlign.right
              : TextAlign.left,
      keyboardType: (widget.isQuantity == true && widget.isQuantity != null)
          ? TextInputType.phone
          : (widget.isEmail)
              ? TextInputType.emailAddress
              : (widget.isMobile)
                  ? TextInputType.number
                  : TextInputType.text,
      inputFormatters: (widget.isMobile)
          ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
          : null,
      decoration: InputDecoration(
        floatingLabelBehavior: (widget.isNotes)
            ? FloatingLabelBehavior.never
            : FloatingLabelBehavior.auto,
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        border: (!widget.hasBorder)
            ? InputBorder.none
            : OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                    color: CustomColors.GREY_LIGHT_A_COLOR.withOpacity(.5))),
        focusedBorder: (!widget.hasBorder)
            ? InputBorder.none
            : OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: CustomColors.PRIMARY_GREEN)),
        labelText:
            "${widget.lablel!.tr()}${(widget.isNotes) ? '\n\n\n' : ""} ",
        labelStyle: TextStyle(color: CustomColors.GREY_LIGHT_A_COLOR),
        prefixIcon: widget.icon,
        fillColor:
            (widget.filledColor == null) ? Colors.white : widget.filledColor,
        filled: true,
        suffixIcon: (widget.hasPassword)
            ? InkWell(
                onTap: () {
                  showPassword = !showPassword;
                  setState(() {});
                },
                child: (!showPassword)
                    ? Icon(Icons.visibility)
                    : Container(
                        padding: EdgeInsets.all(10),
                        child: Image.asset(
                          ImageAssets.visable,
                          width: 20,
                          height: 20,
                        ),
                      ),
              )
            : (!widget.isPhoneCode)
                ? widget.sufficIcon
                : Directionality(
                    textDirection: widget.direction != null
                        ? widget.direction!
                        : TextDirection.ltr,
                    child: Container(
                        height: 40,
                        width: 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("+966"),
                            Container(
                              height: 25,
                              width: 1,
                              color: Colors.grey,
                            ),
                          ],
                        )),
                  ),
      ),
    );
  }
}
