import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_input_formatter/mask_input_formatter.dart';
import 'package:task_wan_app/colors/app_colors.dart';
import 'package:task_wan_app/service/mask_service.dart';

class PhoneNumberField extends StatefulWidget {
  PhoneNumberField({
    super.key,
    required this.countrCodeController,
    required this.phoneNumberController,
  });

  TextEditingController countrCodeController;
  TextEditingController phoneNumberController;

  @override
  State<PhoneNumberField> createState() => _PhoneNumberFieldState();
}

class _PhoneNumberFieldState extends State<PhoneNumberField> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width / 20),
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          border: Border.all(width: 0.1, color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
          color: AppColors.kSecondary,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 10),
            SizedBox(
              width: 50,
              child: TextField(
                controller: widget.countrCodeController..text = '+998',
                inputFormatters: [LengthLimitingTextInputFormatter(4)],
                onChanged: (value) {
                  print(widget.countrCodeController.text);
                  widget.phoneNumberController.clear();
                },
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(border: InputBorder.none),
              ),
            ),
            const Text("|", style: TextStyle(fontSize: 32, color: Colors.grey)),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: widget.phoneNumberController,
                inputFormatters: [MaskInputFormatter(mask: MaskService.uzb)],
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Enter Phone Number",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
