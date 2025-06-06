class Reservation {
  final Map<String, String> offerDetails;
  final String date;
  final String status;

  Reservation({
    required this.offerDetails,
    required this.date,
    required this.status,
  });
}

class ReservationState {
  static final List<Reservation> _reservations = [];

  static void addReservation(Reservation reservation) {
    _reservations.add(reservation);
  }

  static List<Reservation> getReservations() {
    return List.from(_reservations);
  }

  static void clearReservations() {
    _reservations.clear();
  }
} 