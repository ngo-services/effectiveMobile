import 'package:effectivemobile/bloc/reservation_state.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'reservation_api.g.dart';

@RestApi(baseUrl: 'https://run.mocky.io/v3')
abstract class ReservationApi {
  factory ReservationApi(Dio dio, {String baseUrl}) =
      _ReservationApi; // No underscore prefix

  @GET('/35e0d18e-2521-4f1b-a575-f0fe366f66e3')
  Future<ReservationData> getReservationData();
}
