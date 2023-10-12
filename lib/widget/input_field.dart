import 'package:booking_football_schedule/utils/utils.dart';
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField({
    Key? key,
    required this.title,
    this.hint,
    this.controller,
    this.initialValue,
    this.widget, required this.enabled,
  }) : super(key: key);

  final String title;
  final String? hint;
  final bool enabled;
  final TextEditingController? controller;
  final String? initialValue;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: subHeadingStyle,
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.only(left: 14),
            // width: SizeConfig.screenWidth,
            height: 52,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.blueGrey,
                )),
            child: Row(
              children: [
                Expanded(
                    child: TextFormField(
                      enabled: enabled,
                      controller: controller,
                      initialValue: initialValue,
                      autofocus: false,
                      readOnly: widget != null ? true : false,
                      style: subHeadingStyle,
                      cursorColor:
                      Colors.grey[100],
                      decoration: InputDecoration(
                        hintText: hint,
                        hintStyle: enabled ? const TextStyle(color: Color.fromARGB(
                            152, 9, 185, 229)) : const TextStyle(color: Colors.grey),
                        // hintStyle: subTitleStyle,
                        enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              // ignore: deprecated_member_use
                              color: Colors.grey,
                            )),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              // ignore: deprecated_member_use
                              color: Colors.black12,
                              width: 0,
                            )),
                      ),
                    )),
                widget ?? Container(),
                const SizedBox(width: 12,)
              ],
            ),
          ),
        ],
      ),
    );
  }
}