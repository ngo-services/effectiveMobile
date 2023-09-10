// ignore_for_file: unnecessary_null_comparison

import 'package:effectivemobile/api/reservation_api.dart';
import 'package:effectivemobile/bloc/reservation_event.dart';
import 'package:effectivemobile/bloc/reservation_state.dart';
// import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';

class ReservationBloc extends Bloc<ReservationEvent, ReservationState> {
  final ReservationApi _api;
  ReservationBloc(this._api) : super(ReservationInitial()) {
    on<FetchReservationData>(_fetchReservationData);
    on<UpdateFamilyEvent>(_updateFamily);
    on<UpdateEmailEvent>(_updateEmail);
    on<UpdateNameEvent>(_updateName);
    on<UpdatePhoneNumberEvent>(_updatePhoneNumber);
    on<UpdateBirthdayEvent>(_updateBirthday);
    on<UpdateCitizenshipEvent>(_updateCitizenship);
    on<UpdatePassportNumberEvent>(_updatePassportNumber);
    on<UpdatePassportValidityEvent>(_updatePassportValidity);
  }
// here without using Retrofit package
  // void _fetchReservationData(
  //     FetchReservationData event, Emitter<ReservationState> emit) async {
  //   emit(ReservationLoading());

  //   try {
  //     final reservationData = await fetchDataFromApi();

  //     if (reservationData != null) {
  //       emit(ReservationLoaded(data: reservationData));
  //     } else {
  //       emit(ReservationError(message: 'Failed to fetch data'));
  //     }
  //   } catch (e) {
  //     emit(ReservationError(message: 'An error occurred'));
  //   }
  // }
  // here with using Retrofit package
  void _fetchReservationData(
      FetchReservationData event, Emitter<ReservationState> emit) async {
    emit(ReservationLoading()); // Emit loading state

    try {
      final reservationData =
          await _api.getReservationData(); // Fetch data from API

      if (reservationData != null) {
        emit(ReservationLoaded(
            data: reservationData)); // Emit loaded state with data
      } else {
        emit(ReservationError(
            message: 'Failed to fetch data')); // Emit error state
      }
    } catch (e) {
      emit(ReservationError(message: 'An error occurred')); // Emit error state
    }
  }

  // Future<ReservationData?> fetchDataFromApi() async {
  //   final apiUrl = Uri.parse(
  //       'https://run.mocky.io/v3/35e0d18e-2521-4f1b-a575-f0fe366f66e3');

  //   try {
  //     final response = await http.get(apiUrl);

  //     if (response.statusCode == 200) {
  //       final jsonData = json.decode(response.body);
  //       final reservationData = ReservationData.fromJson(jsonData);
  //       return reservationData;
  //     } else {
  //       throw Exception('Failed to load data');
  //     }
  //   } catch (e) {
  //     throw Exception('An error occurred');
  //   }
  // }

  void _updateFamily(UpdateFamilyEvent event, Emitter<ReservationState> emit) {
    emit(state.copyWith(family: event.family));
    print(event.family);
  }

  void _updateEmail(UpdateEmailEvent event, Emitter<ReservationState> emit) {
    emit(state.copyWith(email: event.email));
    print(event.email);
  }

  void _updateName(UpdateNameEvent event, Emitter<ReservationState> emit) {
    emit(state.copyWith(name: event.name));
    print(event.name);
  }

  void _updatePhoneNumber(
      UpdatePhoneNumberEvent event, Emitter<ReservationState> emit) {
    emit(state.copyWith(phoneNumber: event.phoneNumber));
    print(event.phoneNumber);
  }

  void _updateBirthday(
      UpdateBirthdayEvent event, Emitter<ReservationState> emit) {
    emit(state.copyWith(birthday: event.birthday));
    print(event.birthday);
  }

  void _updateCitizenship(
      UpdateCitizenshipEvent event, Emitter<ReservationState> emit) {
    emit(state.copyWith(citizenship: event.citizenship));
    print(event.citizenship);
  }

  void _updatePassportNumber(
      UpdatePassportNumberEvent event, Emitter<ReservationState> emit) {
    emit(state.copyWith(passportNumber: event.passportNumber));
    print(event.passportNumber);
  }

  void _updatePassportValidity(
      UpdatePassportValidityEvent event, Emitter<ReservationState> emit) {
    emit(state.copyWith(passportValidityPeriod: event.passportValidityPeriod));
    print(event.passportValidityPeriod);
  }
}

// State
enum EmailValidationState { valid, invalid, empty }

class EmailValidationCubit extends Cubit<EmailValidationState> {
  EmailValidationCubit() : super(EmailValidationState.empty);

  void validateEmail(String email) {
    if (email.isEmpty) {
      emit(EmailValidationState.empty);
    } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
        .hasMatch(email)) {
      emit(EmailValidationState.invalid);
    } else {
      emit(EmailValidationState.valid);
    }
  }
}
