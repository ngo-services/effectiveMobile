import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomDropdownSecoundTourist extends StatefulWidget {
  final Function(bool) toggleDropdown;
  final String labelText;
  final bool isDropdownOpen;

  const CustomDropdownSecoundTourist({
    super.key,
    required this.toggleDropdown,
    required this.labelText,
    required this.isDropdownOpen,
  });
  @override
  // ignore: library_private_types_in_public_api
  _CustomDropdownSecoundTouristState createState() =>
      _CustomDropdownSecoundTouristState();
}

class _CustomDropdownSecoundTouristState
    extends State<CustomDropdownSecoundTourist> {
  bool isDropdownOpen = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () {
              widget.toggleDropdown(!widget.isDropdownOpen);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.labelText,
                  style: const TextStyle(
                    fontSize: 22,
                    height: 26.4 / 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  height: 32,
                  width: 32,
                  decoration: BoxDecoration(
                    color: const Color(0xff0D72FF).withOpacity(.10),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(
                    child: Transform.rotate(
                      angle: !widget.isDropdownOpen ? 3.14159265359 : 0,
                      child: Container(
                        height: 32,
                        width: 32,
                        decoration: BoxDecoration(
                          color: const Color(0xff0D72FF).withOpacity(.10),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Center(
                          child:
                              SvgPicture.asset('assets/icons/arrow_drop.svg'),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          if (widget.isDropdownOpen)
            const Expanded(
              child: Column(
                children: [
                  // Secound Tourist
                ],
              ),
            ),
        ],
      ),
    );
  }
}
