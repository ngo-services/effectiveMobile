import 'package:effectivemobile/bloc/reservation_bloc.dart';
import 'package:effectivemobile/bloc/reservation_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../utils/validation_utils.dart';

class CustomDropdownFirstTourist extends StatefulWidget {
  final Function(bool) toggleDropdown;
  final String labelText;
  final bool isDropdownOpen;

  const CustomDropdownFirstTourist({
    super.key,
    required this.toggleDropdown,
    required this.labelText,
    required this.isDropdownOpen,
  });
  @override
  _CustomDropdownFirstTouristState createState() =>
      _CustomDropdownFirstTouristState();
}

class _CustomDropdownFirstTouristState
    extends State<CustomDropdownFirstTourist> {
  final TextEditingController _NameController = TextEditingController();
  final TextEditingController _familyController = TextEditingController();
  final TextEditingController _birthdayTextController = TextEditingController();
  final TextEditingController _citizenshipTextController =
      TextEditingController();

  final TextEditingController _passportNumberTextController =
      TextEditingController();

  final TextEditingController _passportValidityTextController =
      TextEditingController();
  final FocusNode __birthdayFocusNode = FocusNode();
  bool isDropdownOpen = true;

  bool isTapped = false;
  var birthdayMaskFormatter = MaskTextInputFormatter(
    mask: '##/##/####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  @override
  void initState() {
    super.initState();
    _birthdayTextController.addListener(() {
      setState(() {
        isTapped = _birthdayTextController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _birthdayTextController.dispose();
    __birthdayFocusNode.dispose();
    super.dispose();
  }

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
            Column(
              children: [
                // Имя
                Container(
                  height: 52,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: const Color(0xffF6F6F9)),
                  child: TextFormField(
                    controller: _NameController,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(
                        fontSize: 12,
                        color: Color(0xffA9ABB7),
                        fontWeight: FontWeight.w400,
                        height: 14.4 / 12,
                        letterSpacing: 0.12,
                      ),
                      hintStyle: TextStyle(
                        fontSize: 16,
                      ),
                      border: InputBorder.none,
                      labelText: 'Имя',
                      hintText: '',
                      contentPadding: EdgeInsets.all(10),
                    ),
                    onChanged: (value) {
                      final validationError =
                          ValidationUtils.validateName(value);
                      if (validationError == null) {
                        context
                            .read<ReservationBloc>()
                            .add(UpdateNameEvent(value));
                      }
                    },
                    validator: (value) => ValidationUtils.validateName(value!),
                  ),
                ),
                const SizedBox(height: 8),
                // Фамилия
                Container(
                  height: 52,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: const Color(0xffF6F6F9)),
                  child: TextFormField(
                    controller: _familyController,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(
                        fontSize: 12,
                        color: Color(0xffA9ABB7),
                        fontWeight: FontWeight.w400,
                        height: 14.4 / 12,
                        letterSpacing: 0.12,
                      ),
                      hintStyle: TextStyle(
                        fontSize: 16,
                      ),
                      border: InputBorder.none,
                      labelText: 'Фамилия',
                      hintText: '',
                      contentPadding: EdgeInsets.all(10),
                    ),
                    onChanged: (value) {
                      final validationError =
                          ValidationUtils.validateFamily(value);
                      if (validationError == null) {
                        context
                            .read<ReservationBloc>()
                            .add(UpdateFamilyEvent(value));
                      }
                    },
                    validator: (value) =>
                        ValidationUtils.validateFamily(value!),
                  ),
                ),
                const SizedBox(height: 8),
                // Дата рождения
                Container(
                  height: 52,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: const Color(0xffF6F6F9)),
                  child: TextFormField(
                    controller: _birthdayTextController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [birthdayMaskFormatter],
                    decoration: InputDecoration(
                      labelStyle: const TextStyle(
                        fontSize: 12,
                        color: Color(0xffA9ABB7),
                        fontWeight: FontWeight.w400,
                        height: 14.4 / 12,
                        letterSpacing: 0.12,
                      ),
                      hintStyle: const TextStyle(
                        fontSize: 16,
                      ),
                      border: InputBorder.none,
                      labelText: 'Дата рождения',
                      // hintText: '',
                      hintText: isTapped ? 'DD/MM/YYYY' : '',

                      contentPadding: const EdgeInsets.all(10),
                    ),
                    validator: (value) =>
                        ValidationUtils.validateBirthday(value!),
                    onChanged: (value) {
                      final validationError =
                          ValidationUtils.validateBirthday(value);
                      if (validationError == null) {
                        context
                            .read<ReservationBloc>()
                            .add(UpdateBirthdayEvent(value));
                      }
                    },
                    onTap: () {
                      if (!isTapped) {
                        _birthdayTextController.text = '';
                        isTapped = true;
                      }
                    },
                  ),
                ),
                const SizedBox(height: 8),
                // Гражданство
                Container(
                  height: 52,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: const Color(0xffF6F6F9)),
                  child: TextFormField(
                    controller: _citizenshipTextController,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(
                        fontSize: 12,
                        color: Color(0xffA9ABB7),
                        fontWeight: FontWeight.w400,
                        height: 14.4 / 12,
                        letterSpacing: 0.12,
                      ),
                      hintStyle: TextStyle(
                        fontSize: 16,
                      ),
                      border: InputBorder.none,
                      labelText: 'Гражданство',
                      hintText: '',
                      contentPadding: EdgeInsets.all(10),
                    ),
                    onChanged: (value) {
                      final validationError =
                          ValidationUtils.validateCitizenship(value);
                      if (validationError == null) {
                        context
                            .read<ReservationBloc>()
                            .add(UpdateCitizenshipEvent(value));
                      }
                    },
                    validator: (value) =>
                        ValidationUtils.validateCitizenship(value!),
                  ),
                ),
                const SizedBox(height: 8),
                // Номер загранпаспорта
                Container(
                  height: 52,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: const Color(0xffF6F6F9)),
                  child: TextFormField(
                    controller: _passportNumberTextController,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(
                        fontSize: 12,
                        color: Color(0xffA9ABB7),
                        fontWeight: FontWeight.w400,
                        height: 14.4 / 12,
                        letterSpacing: 0.12,
                      ),
                      hintStyle: TextStyle(
                        fontSize: 16,
                      ),
                      border: InputBorder.none,
                      labelText: 'Номер загранпаспорта',
                      hintText: '',
                      contentPadding: EdgeInsets.all(10),
                    ),
                    onChanged: (value) {
                      final validationError =
                          ValidationUtils.validatePassportNumber(value);
                      if (validationError == null) {
                        context
                            .read<ReservationBloc>()
                            .add(UpdatePassportNumberEvent(value));
                      }
                    },
                    validator: (value) =>
                        ValidationUtils.validatePassportNumber(value!),
                  ),
                ),
                const SizedBox(height: 8),
                // Срок действия загранпаспорта
                Container(
                  height: 52,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: const Color(0xffF6F6F9)),
                  child: TextFormField(
                    controller: _passportValidityTextController,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(
                        fontSize: 12,
                        color: Color(0xffA9ABB7),
                        fontWeight: FontWeight.w400,
                        height: 14.4 / 12,
                        letterSpacing: 0.12,
                      ),
                      hintStyle: TextStyle(
                        fontSize: 16,
                      ),
                      border: InputBorder.none,
                      labelText: 'Срок действия загранпаспорта',
                      hintText: '',
                      contentPadding: EdgeInsets.all(10),
                    ),
                    onChanged: (value) {
                      final validationError =
                          ValidationUtils.validatePassportValidity(value);
                      if (validationError == null) {
                        context
                            .read<ReservationBloc>()
                            .add(UpdatePassportValidityEvent(value));
                      }
                    },
                    validator: (value) =>
                        ValidationUtils.validatePassportValidity(value!),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
        ],
      ),
    );
  }
}
