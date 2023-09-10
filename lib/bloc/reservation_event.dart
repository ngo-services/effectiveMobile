// Event
abstract class ReservationEvent {}

class UpdateFamilyEvent extends ReservationEvent {
  final String family;

  UpdateFamilyEvent(this.family);
}

class UpdateEmailEvent extends ReservationEvent {
  final String email;

  UpdateEmailEvent(this.email);
}

class UpdateNameEvent extends ReservationEvent {
  final String name;

  UpdateNameEvent(this.name);
}

class UpdatePhoneNumberEvent extends ReservationEvent {
  final String phoneNumber;

  UpdatePhoneNumberEvent(this.phoneNumber);
}

class UpdateBirthdayEvent extends ReservationEvent {
  final String birthday;

  UpdateBirthdayEvent(this.birthday);
}

class UpdateCitizenshipEvent extends ReservationEvent {
  final String citizenship;

  UpdateCitizenshipEvent(this.citizenship);
}

class UpdatePassportNumberEvent extends ReservationEvent {
  final String passportNumber;

  UpdatePassportNumberEvent(this.passportNumber);
}

class UpdatePassportValidityEvent extends ReservationEvent {
  final String passportValidityPeriod;

  UpdatePassportValidityEvent(this.passportValidityPeriod);
}

class FetchReservationData extends ReservationEvent {}
