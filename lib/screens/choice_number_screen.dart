import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:effectivemobile/bloc/reservation_bloc.dart';
import 'package:effectivemobile/bloc/reservation_state.dart';
import 'package:effectivemobile/screens/booking_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class ChoiceNumber extends StatefulWidget {
  final ReservationData reservationData;

  const ChoiceNumber({Key? key, required this.reservationData})
      : super(key: key);

  @override
  State<ChoiceNumber> createState() => _ChoiceNumberState();
}

class _ChoiceNumberState extends State<ChoiceNumber> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    double height = 257.0;
    double width = 343.0;

    double aspectRatio = width / height;
    return Scaffold(
      backgroundColor: const Color(0xffF6F6F9),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.reservationData.name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            height: 1.2000000212,
            color: Color(0xff000000),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 8),
            Container(
              width: 375,
              height: 539,
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
                                aspectRatio: aspectRatio,
                                viewportFraction: 1,
                                pageSnapping: true,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    _currentIndex = index;
                                  });
                                },
                              ),
                              items:
                                  widget.reservationData.imageUrls.map((url) {
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
                                children: widget.reservationData.imageUrls
                                    .asMap()
                                    .entries
                                    .map((entry) {
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
                    const SizedBox(height: 8),
                    Text(
                      // 'Стандартный с видом на бассейн или сад',
                      widget.reservationData.address,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 22,
                        height: 1.2,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Row(
                      children: [
                        Text(
                          'Все включено',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'SF Pro Display',
                              height: 1.2),
                        ),
                        SizedBox(width: 28),
                        Text(
                          'Кондиционер',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'SF Pro Display',
                              height: 1.2),
                        ),
                      ],
                    ),
                    const SizedBox(height: 13),
                    Container(
                      height: 29,
                      width: 192,
                      padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: const Color(0xff0D72FF).withOpacity(.10)),
                      child: Row(
                        children: [
                          const Text(
                            'Подробнее о номере',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 16,
                                color: Color(0xff0D72FF),
                                fontWeight: FontWeight.w500,
                                fontFamily: 'SF Pro Display',
                                height: 19.2 / 16),
                          ),
                          const SizedBox(width: 2),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(2, 5, 2, 5),
                            child: SvgPicture.asset(
                              'assets/icons/blue_arrow_forward_ios.svg',
                              width: 6,
                              height: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    RichText(
                      text: TextSpan(
                        text: NumberFormat("от #,###", "ru")
                            .format(widget.reservationData.minimalPrice),
                        style: const TextStyle(
                          fontSize: 30,
                          height: 1.2,
                          fontFamily: 'SF Pro Display',
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.0,
                        ),
                        children: const [
                          WidgetSpan(
                            child: SizedBox(width: 8),
                          ),
                          TextSpan(
                            text: 'за тур с перелётомот',
                            style: TextStyle(
                              fontSize: 16,
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
                    GestureDetector(
                      onTap: () {
                        // Navigator.pushNamed(context, '/booking-screen');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider.value(
                              value: BlocProvider.of<ReservationBloc>(context),
                              child: BookingScreen(
                                  reservationData: widget.reservationData),
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
                            'Выбрать номер',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontFamily: 'SF Pro Display',
                              fontSize:
                                  16.0, // Font size in logical pixels (sp)
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w500,
                              height:
                                  1.1, // Line height equivalent to 110% (16px * 1.1 = 17.6px)
                              letterSpacing:
                                  0.1, // Letter spacing in logical pixels (sp)
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
