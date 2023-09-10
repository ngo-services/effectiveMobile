import 'dart:ui';
import 'package:effectivemobile/bloc/reservation_event.dart';
import 'package:effectivemobile/bloc/reservation_state.dart';
import 'package:effectivemobile/screens/choice_number_screen.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'bloc/reservation_bloc.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    final reservationBloc = BlocProvider.of<ReservationBloc>(context);
    reservationBloc.add(FetchReservationData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Отель',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            height: 1.2000000212,
            color: Color(0xff000000),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocBuilder<ReservationBloc, ReservationState>(
          builder: (context, state) {
            if (state is ReservationLoaded) {
              final reservationData = state.data;
              final imageUrls = reservationData.imageUrls;
              final peculiarities =
                  reservationData.aboutTheHotel['peculiarities'];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: CarouselSlider(
                            options: CarouselOptions(
                              autoPlay: false,
                              enlargeCenterPage: true,
                              aspectRatio: 16 / 9,
                              viewportFraction: 1,
                              pageSnapping: true,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _currentIndex = index;
                                });
                              },
                            ),
                            items: reservationData.imageUrls.map((url) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return CachedNetworkImage(
                                    imageUrl: url,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        const CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  );
                                },
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Positioned(
                              left: 135,
                              right: 135,
                              child: Container(
                                width: 75.0,
                                height: 17.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: imageUrls.asMap().entries.map((entry) {
                                return Container(
                                  width: 7.0,
                                  height: 7.0,
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 10.0,
                                    horizontal: 2.0,
                                  ),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: _currentIndex == entry.key
                                        ? Colors.black
                                        : Colors.grey,
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
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
                          '${reservationData.rating} ${reservationData.ratingName}',
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
                  const SizedBox(height: 20),
                  Text(
                    reservationData.name,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontSize: 22,
                      height: 1.2,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    reservationData.address,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontSize: 13,
                      height: 1.2,
                      fontFamily: 'SF Pro Display',
                      color: Color(0xff0D72FF),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 16),
                  RichText(
                    text: TextSpan(
                      // text: 'от ${reservationData.minimalPrice.toString()} ₽',
                      text: NumberFormat("от #,###", "ru")
                          .format(reservationData.minimalPrice),

                      style: TextStyle(
                        fontSize: 28.sp,
                        height: 1.2,
                        fontFamily: 'SF Pro Display',
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.0,
                      ),
                      children: [
                        const WidgetSpan(child: SizedBox(width: 8)),
                        TextSpan(
                          text: 'за тур с перелётомот',
                          style: TextStyle(
                            fontSize: 16.sp,
                            height: 1.1875,
                            fontFamily: 'SF Pro Display',
                            color: Colors.grey,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Об отеле',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'SF Pro Display',
                        height: 1.2),
                  ),
                  const SizedBox(height: 16),
                  // test
                  // Render the peculiarities as a list
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      (peculiarities.length / 2).ceil(),
                      (index) {
                        final firstPeculiarity =
                            peculiarities.elementAt(index * 2);
                        final secondPeculiarity =
                            (index * 2 + 1 < peculiarities.length)
                                ? peculiarities.elementAt(index * 2 + 1)
                                : null;

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                flex: 8,
                                child: Text(
                                  firstPeculiarity,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'SF Pro Display',
                                    height: 1.2,
                                  ),
                                ),
                              ),
                              // const SizedBox(width: 8),
                              if (secondPeculiarity != null)
                                Flexible(
                                  flex: 0,
                                  child: Text(
                                    secondPeculiarity,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'SF Pro Display',
                                      height: 1.2,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  // const Column(
                  //   children: [
                  //     Row(
                  //       children: [
                  //         Text(
                  //           '3-я линия',
                  //           style: TextStyle(
                  //               fontSize: 16,
                  //               color: Colors.grey,
                  //               fontWeight: FontWeight.w500,
                  //               fontFamily: 'SF Pro Display',
                  //               height: 1.2),
                  //         ),
                  //         SizedBox(width: 28),
                  //         Text(
                  //           'Платный Wi-Fi в фойе',
                  //           style: TextStyle(
                  //               fontSize: 16,
                  //               color: Colors.grey,
                  //               fontWeight: FontWeight.w500,
                  //               fontFamily: 'SF Pro Display',
                  //               height: 1.2),
                  //         ),
                  //       ],
                  //     ),
                  //     SizedBox(height: 16),
                  //     Row(
                  //       children: [
                  //         Text(
                  //           '30 км до аэропорта',
                  //           style: TextStyle(
                  //               fontSize: 16,
                  //               color: Colors.grey,
                  //               fontWeight: FontWeight.w500,
                  //               fontFamily: 'SF Pro Display',
                  //               height: 1.2),
                  //         ),
                  //         SizedBox(width: 28),
                  //         Text(
                  //           '1 км до пляжа',
                  //           style: TextStyle(
                  //               fontSize: 16,
                  //               color: Colors.grey,
                  //               fontWeight: FontWeight.w500,
                  //               fontFamily: 'SF Pro Display',
                  //               height: 1.2),
                  //         ),
                  //       ],
                  //     ),
                  //   ],
                  // ),
                  const SizedBox(height: 12),
                  Text(
                    // 'Отель VIP-класса с собственными гольф полями. Высокий уровнь сервиса. Рекомендуем для респектабельного отдыха. Отель принимает гостей от 18 лет!',
                    reservationData.aboutTheHotel['description'],
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'SF Pro Display',
                        height: 19.2 / 16),
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    leading: SvgPicture.asset(
                      'assets/icons/emoji-happy.svg',
                      width: 24,
                      height: 24,
                    ),
                    title: const Text(
                      'Удобства',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'SF Pro Display',
                          height: 19.2 / 16),
                    ),
                    subtitle: const Text(
                      'Самое необходимое',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'SF Pro Display',
                          height: 19.2 / 16),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Color(0xff828796),
                    ),
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                      'assets/icons/tick-square.svg',
                      width: 24,
                      height: 24,
                    ),
                    title: const Text(
                      'Что включено',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'SF Pro Display',
                          height: 19.2 / 16),
                    ),
                    subtitle: const Text(
                      'Самое необходимое',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'SF Pro Display',
                          height: 19.2 / 16),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Color(0xff828796),
                    ),
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                      'assets/icons/close-square.svg',
                      width: 24,
                      height: 24,
                    ),
                    title: const Text(
                      'Что не включено',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'SF Pro Display',
                          height: 19.2 / 16),
                    ),
                    subtitle: const Text(
                      'Самое необходимое',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'SF Pro Display',
                          height: 19.2 / 16),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Color(0xff828796),
                    ),
                  ),
                  const SizedBox(height: 40),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider.value(
                            value: BlocProvider.of<ReservationBloc>(context),
                            child:
                                ChoiceNumber(reservationData: reservationData),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 48.0,
                      padding: const EdgeInsets.only(top: 15.0, bottom: 14.0),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: const Center(
                        child: Text(
                          'К выбору номера',
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontFeatures: [
                              FontFeature.disable('clig'),
                              FontFeature.disable('liga'),
                            ],
                            fontFamily: 'SF Pro Display',
                            fontSize: 16.0,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w500,
                            height: 1.1,
                            letterSpacing: 0.1,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              );
            } else if (state is ReservationLoading) {
              return const CircularProgressIndicator();
            } else if (state is ReservationError) {
              return Text("Error: ${state.message}");
            } else {
              return const Text("No data available.");
            }
          },
        ),
      ),
    );
  }
}
