import 'package:effectivemobile/bloc/reservation_bloc.dart';
import 'package:effectivemobile/bloc/reservation_event.dart';
import 'package:effectivemobile/screens/order_screen.dart';
import 'package:effectivemobile/utils/validation_utils.dart';
import 'package:effectivemobile/widget/add_new_touris.dart';
import 'package:effectivemobile/widget/custom_drop_down_first_tourist.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:intl/intl.dart';
import 'package:intl/intl.dart' as intl;
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../bloc/reservation_state.dart';

class BookingScreen extends StatefulWidget {
  final ReservationData reservationData;
  const BookingScreen({super.key, required this.reservationData});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String emailTextEditingController = '';
  String phoneNumber = '';
  String name = '';
  String family = '';
  String birthday = '';
  String citizenship = '';
  String passportNumber = '';
  String passportValidity = '';

  bool isDropdownOpenFirst = true;
  bool isDropdownOpenSecound = false;
  late final ReservationData reservationData;
  double containerHeight = 120.0;
  var maskFormatter = MaskTextInputFormatter(
      mask: '+# (###) ###-##-##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  @override
  void initState() {
    super.initState();
    _calculateContainerHeight();
  }

  void _calculateContainerHeight() {
    final textPainter = TextPainter(
      text: TextSpan(
        text: widget.reservationData.name,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w500,
        ),
      ),
      maxLines: 2, // Limit to 2 lines
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: double.infinity);
    // Check if the text spans more than 1 line
    if (textPainter.didExceedMaxLines) {
      setState(() {
        containerHeight = 150.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F6F9),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Бронирование',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            height: 1.2000000212,
            color: Color(0xff000000),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 8),
              Container(
                margin: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Container(
                            height: 29,
                            width: 149,
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                                color: const Color(0xFFC70033).withOpacity(.20),
                                borderRadius: BorderRadius.circular(5)),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/Icons.svg',
                                  height: 15,
                                  width: 15,
                                ),
                                Text(
                                  ' ${widget.reservationData.rating} ${widget.reservationData.ratingName}',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    height: 1.2,
                                    fontSize: 16,
                                    color: Color(0xFFFFA800),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.reservationData.name,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontSize: 22 / 1.2,
                          height: 1.2,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.reservationData.address,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 13,
                          height: 1.2,
                          fontFamily: 'SF Pro Display',
                          color: Color(0xff0D72FF),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: 280,
                margin: const EdgeInsets.fromLTRB(5, 0, 5, 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Table(
                            columnWidths: const {
                              0: FlexColumnWidth(.7),
                              1: FlexColumnWidth(1),
                            },
                            children: const [
                              TableRow(
                                children: [
                                  TableCell(
                                    child: Text(
                                      'Вылет из',
                                      style: TextStyle(
                                        fontSize: 16,
                                        height: 1.2,
                                        fontFamily: 'SF Pro Display',
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 0.0,
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: Text(
                                      'Санкт-Петербург',
                                      style: TextStyle(
                                        fontSize: 16,
                                        height: 1.2,
                                        fontFamily: 'SF Pro Display',
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 0.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              // here the hegiht of the column and row
                              TableRow(
                                children: [
                                  TableCell(
                                    child: SizedBox(
                                        height:
                                            16.0), // Empty cell acting as space
                                  ),
                                  TableCell(
                                    child: SizedBox(
                                        height:
                                            16.0), // Empty cell acting as space
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  TableCell(
                                    child: Text(
                                      'Страна, город',
                                      style: TextStyle(
                                        fontSize: 16,
                                        height: 1.2,
                                        fontFamily: 'SF Pro Display',
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 0.0,
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: Text(
                                      'Египет, Хургада',
                                      style: TextStyle(
                                        fontSize: 16,
                                        height: 1.2,
                                        fontFamily: 'SF Pro Display',
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 0.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              // here the hegiht of the column and row
                              TableRow(
                                children: [
                                  TableCell(
                                    child: SizedBox(
                                        height:
                                            16.0), // Empty cell acting as space
                                  ),
                                  TableCell(
                                    child: SizedBox(
                                        height:
                                            16.0), // Empty cell acting as space
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  TableCell(
                                    child: Text(
                                      'Даты',
                                      style: TextStyle(
                                        fontSize: 16,
                                        height: 1.2,
                                        fontFamily: 'SF Pro Display',
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 0.0,
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: Text(
                                      '19.09.2023 – 27.09.2023',
                                      style: TextStyle(
                                        fontSize: 16,
                                        height: 19.2 / 16,
                                        fontFamily: 'SF Pro Display',
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 0.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              // here the hegiht of the column and row
                              TableRow(
                                children: [
                                  TableCell(
                                    child: SizedBox(
                                        height:
                                            16.0), // Empty cell acting as space
                                  ),
                                  TableCell(
                                    child: SizedBox(
                                        height:
                                            16.0), // Empty cell acting as space
                                  ),
                                ],
                              ),

                              TableRow(
                                children: [
                                  TableCell(
                                    child: Text(
                                      'Кол-во ночей',
                                      style: TextStyle(
                                        fontSize: 16,
                                        height: 1.2,
                                        fontFamily: 'SF Pro Display',
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 0.0,
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: Text(
                                      '7 ночей',
                                      style: TextStyle(
                                        fontSize: 16,
                                        height: 19.2 / 16,
                                        fontFamily: 'SF Pro Display',
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 0.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              // here the hegiht of the column and row
                              TableRow(
                                children: [
                                  TableCell(
                                    child: SizedBox(
                                        height:
                                            16.0), // Empty cell acting as space
                                  ),
                                  TableCell(
                                    child: SizedBox(
                                        height:
                                            16.0), // Empty cell acting as space
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  TableCell(
                                    child: Text(
                                      'Отель',
                                      style: TextStyle(
                                        fontSize: 16,
                                        height: 1.2,
                                        fontFamily: 'SF Pro Display',
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 0.0,
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: Text(
                                      'Steigenberger Makadi',
                                      style: TextStyle(
                                        fontSize: 16,
                                        height: 19.2 / 16,
                                        fontFamily: 'SF Pro Display',
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 0.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              // here the hegiht of the column and row
                              TableRow(
                                children: [
                                  TableCell(
                                    child: SizedBox(
                                        height:
                                            16.0), // Empty cell acting as space
                                  ),
                                  TableCell(
                                    child: SizedBox(
                                        height:
                                            16.0), // Empty cell acting as space
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  TableCell(
                                    child: Text(
                                      'Номер',
                                      style: TextStyle(
                                        fontSize: 16,
                                        height: 1.2,
                                        fontFamily: 'SF Pro Display',
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 0.0,
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: Text(
                                      'Стандартный с видом на бассейн или сад',
                                      style: TextStyle(
                                        fontSize: 16,
                                        height: 19.2 / 16,
                                        fontFamily: 'SF Pro Display',
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 0.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              // here the hegiht of the column and row
                              TableRow(
                                children: [
                                  TableCell(
                                    child: SizedBox(
                                        height:
                                            16.0), // Empty cell acting as space
                                  ),
                                  TableCell(
                                    child: SizedBox(
                                        height:
                                            16.0), // Empty cell acting as space
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  TableCell(
                                    child: Text(
                                      'Питание',
                                      style: TextStyle(
                                        fontSize: 16,
                                        height: 1.2,
                                        fontFamily: 'SF Pro Display',
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 0.0,
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: Text(
                                      'Все включено',
                                      style: TextStyle(
                                        fontSize: 16,
                                        height: 19.2 / 16,
                                        fontFamily: 'SF Pro Display',
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 0.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: 232,
                margin: const EdgeInsets.fromLTRB(5, 0, 5, 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Информация о покупателе',
                        style: TextStyle(
                          height: 26.4 / 22,
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      // Input phone number
                      const SizedBox(height: 20),
                      Container(
                        height: 52,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: const Color(0xffF6F6F9)),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
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
                            labelText: 'Номер телефона',
                            contentPadding:
                                EdgeInsets.only(left: 16, top: 10, bottom: 13),
                          ),
                          inputFormatters: [maskFormatter],
                          // onChanged: (value) => phoneNumber = value,
                          onChanged: (value) {
                            final validationError =
                                ValidationUtils.validatePhoneNumber(value);
                            if (validationError == null) {
                              context
                                  .read<ReservationBloc>()
                                  .add(UpdatePhoneNumberEvent(value));
                            }
                          },
                          validator: (value) =>
                              ValidationUtils.validatePhoneNumber(value!),
                        ),
                      ),
                      const SizedBox(height: 8),
                      // InputEmail(),
                      Container(
                        height: 52,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: const Color(0xffF6F6F9)),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelStyle: TextStyle(
                              fontSize: 12,
                              color: Color(0xffA9ABB7),
                              fontWeight: FontWeight.w400,
                              height: 14.4 / 12,
                              letterSpacing: 0.75,
                            ),
                            hintStyle: TextStyle(
                              fontSize: 16,
                              height: 17.6 / 16,
                              color: Color(0xff14142B),
                              letterSpacing: 0.75,
                            ),
                            border: InputBorder.none,
                            labelText: 'Почта',
                            contentPadding:
                                EdgeInsets.only(left: 16, top: 10, bottom: 13),
                          ),
                          // onChanged: (value) =>
                          //     emailTextEditingController = value,
                          onChanged: (value) {
                            final validationError =
                                ValidationUtils.validateEmail(value);
                            if (validationError == null) {
                              context
                                  .read<ReservationBloc>()
                                  .add(UpdateEmailEvent(value));
                            }
                          },
                          validator: (value) =>
                              ValidationUtils.validateEmail(value!),
                        ),
                      ),

                      const SizedBox(height: 8),
                      const SizedBox(
                        width: 343,
                        height: 34,
                        child: Text(
                          'Эти данные никому не передаются. После оплаты мы вышли чек на указанный вами номер и почту',
                          style: TextStyle(
                            fontSize: 14,
                            height: 16.8 / 14,
                            fontFamily: 'SF Pro Display',
                            color: Color(0xff828796),
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),

              Container(
                height: isDropdownOpenFirst ? 430 : 90,
                width: 375,
                margin: const EdgeInsets.fromLTRB(5, 0, 5, 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    CustomDropdownFirstTourist(
                      toggleDropdown: (isOpen) {
                        setState(() {
                          isDropdownOpenFirst = isOpen;
                        });
                      },
                      labelText: 'Первый турист',
                      isDropdownOpen: isDropdownOpenFirst,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              TouristsForm(),
              // Container(
              //   height: isDropdownOpenSecound ? 430 : 90,
              //   width: 375,
              //   margin: const EdgeInsets.fromLTRB(5, 0, 5, 10),
              //   decoration: BoxDecoration(
              //     color: Colors.white,
              //     borderRadius: BorderRadius.circular(12),
              //   ),
              //   child: CustomDropdownSecoundTourist(
              //     toggleDropdown: (isOpen) {
              //       setState(() {
              //         isDropdownOpenSecound = isOpen;
              //       });
              //     },
              //     labelText: 'Второй турист ',
              //     isDropdownOpen: isDropdownOpenSecound,
              //   ),
              // ),
              // Container(
              //   height: isDropdownOpenSecound ? 430 : 90,
              //   width: 375,
              //   margin: const EdgeInsets.fromLTRB(5, 0, 5, 10),
              //   decoration: BoxDecoration(
              //     color: Colors.white,
              //     borderRadius: BorderRadius.circular(12),
              //   ),
              //   child: const AddNewTourist(),
              // ),
              // const SizedBox(height: 8),
              Container(
                height: 156,
                width: 375,
                margin: const EdgeInsets.fromLTRB(5, 0, 5, 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Тур',
                            style: TextStyle(
                              fontSize: 16,
                              height: 1.2,
                              fontFamily: 'SF Pro Display',
                              color: Colors.grey,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.0,
                            ),
                          ),
                          Text(
                            // '${widget.reservationData.minimalPrice}₽',
                            "${intl.NumberFormat("#,###", "ru").format(widget.reservationData.minimalPrice)} ₽",
                            style: const TextStyle(
                              fontSize: 16,
                              height: 1.2,
                              fontFamily: 'SF Pro Display',
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.0,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Топливный сбор',
                            style: TextStyle(
                              fontSize: 16,
                              height: 1.2,
                              fontFamily: 'SF Pro Display',
                              color: Colors.grey,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.0,
                            ),
                          ),
                          Text(
                            '9 300 ₽',
                            style: TextStyle(
                              fontSize: 16,
                              height: 1.2,
                              fontFamily: 'SF Pro Display',
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.0,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Сервисный сбор',
                            style: TextStyle(
                              fontSize: 16,
                              height: 1.2,
                              fontFamily: 'SF Pro Display',
                              color: Colors.grey,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.0,
                            ),
                          ),
                          Text(
                            '2 136 ₽',
                            style: TextStyle(
                              fontSize: 16,
                              height: 1.2,
                              fontFamily: 'SF Pro Display',
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.0,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'К оплате',
                            style: TextStyle(
                              fontSize: 16,
                              height: 1.2,
                              fontFamily: 'SF Pro Display',
                              color: Colors.grey,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.0,
                            ),
                          ),
                          Text(
                            '145 704 ₽',
                            style: TextStyle(
                              fontSize: 16,
                              height: 1.2,
                              fontFamily: 'SF Pro Display',
                              color: Color(0xff0D72FF),
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 88),
            ],
          ),
        ),
      ),
      bottomSheet: GestureDetector(
        onTap: () {
          if (_formKey.currentState!.validate()) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const OrderScreen(),
              ),
            );
          }
        },
        child: Container(
          height: 88,
          color: Colors.white,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                left: 16,
                right: 16,
                top: 15,
                bottom: 15,
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Center(
                    child: Text(
                      'Оплатить 145 704 ₽',
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.2,
                        fontFamily: 'SF Pro Display',
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
