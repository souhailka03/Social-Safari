class Reservation {
  final String destinationName;
  final int numberOfPeople;
  final String activityType;
  final DateTime dateTime;
  final String location;
  final String status;
  final bool isConfirmed;

  Reservation({
    required this.destinationName,
    required this.numberOfPeople,
    required this.activityType,
    required this.dateTime,
    required this.location,
    required this.status,
    required this.isConfirmed,
  });

  String get formattedDate {
    // Check if the date is tomorrow
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    if (dateTime.year == tomorrow.year &&
        dateTime.month == tomorrow.month &&
        dateTime.day == tomorrow.day) {
      return 'Demain, ${_formatTime(dateTime)}';
    }

    return '${_formatDay(dateTime)}, ${_formatTime(dateTime)}';
  }

  String _formatDay(DateTime date) {
    const days = ['Lun.', 'Mar.', 'Mer.', 'Jeu.', 'Ven.', 'Sam.', 'Dim.'];
    const months = [
      'Jan.',
      'Fév.',
      'Mars',
      'Avr.',
      'Mai',
      'Juin',
      'Juil.',
      'Août',
      'Sept.',
      'Oct.',
      'Nov.',
      'Déc.'
    ];

    return '${days[date.weekday - 1]} ${date.day} ${months[date.month - 1]}';
  }

  String _formatTime(DateTime date) {
    return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  String get shareText {
    return '''
Voyage à $destinationName
$numberOfPeople personnes • $activityType
${formattedDate}
$location
Statut: $status
''';
  }

  String get printText {
    return '''
================================
     DÉTAILS DU VOYAGE     
================================

Destination: $destinationName
Nombre de personnes: $numberOfPeople
Type d'activité: $activityType
Date et heure: ${formattedDate}
Lieu: $location
Statut: $status

================================
''';
  }
}
