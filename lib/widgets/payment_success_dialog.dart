import 'package:flutter/material.dart';
import '../data/user_state.dart';
import '../data/reservation_state.dart';
import '../pages/reservations_list_page.dart';

class PaymentSuccessDialog extends StatelessWidget {
  final Map<String, String> offerDetails;

  const PaymentSuccessDialog({
    Key? key,
    required this.offerDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Ajouter la réservation à la liste
    ReservationState.addReservation(
      Reservation(
        offerDetails: offerDetails,
        date: DateTime.now().toString().split(' ')[0],
        status: 'Confirmée',
      ),
    );

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: const BoxDecoration(
                color: Color(0xFF6D56FF),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check,
                color: Colors.white,
                size: 40,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Paiement réussi !',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6D56FF),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Votre réservation a été confirmée. Vous recevrez un email avec les détails de votre réservation.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Fermer le dialogue
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ReservationsListPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6D56FF),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Voir mes réservations',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                child: Text(
                  'Retour à l\'accueil',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
