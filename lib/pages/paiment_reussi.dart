import 'package:flutter/material.dart';
import 'reservations_list_page.dart';
import 'home_page.dart';

class PaymentSuccessDialog extends StatelessWidget {
  final Map<String, String> offerDetails;
  final int nightCount;
  final int adultCount;
  final int childCount;
  final double totalPrice;

  const PaymentSuccessDialog({
    Key? key,
    required this.offerDetails,
    required this.nightCount,
    required this.adultCount,
    required this.childCount,
    required this.totalPrice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xFF6D56FF).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle,
                size: 48,
                color: Color(0xFF6D56FF),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Paiement réussi !',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Votre réservation pour ${offerDetails['title']} a été confirmée.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 24),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildDetailRow(
                    label: 'Montant payé',
                    value: '${totalPrice.toStringAsFixed(0)} MAD',
                  ),
                  const SizedBox(height: 12),
                  _buildDetailRow(
                    label: 'Durée',
                    value: '$nightCount nuits',
                  ),
                  const SizedBox(height: 12),
                  _buildDetailRow(
                    label: 'Voyageurs',
                    value: '$adultCount adultes${childCount > 0 ? ', $childCount enfants' : ''}',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Fermer le popup
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReservationsListPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6D56FF),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                minimumSize: const Size(double.infinity, 48),
              ),
              child: const Text(
                'Voir ma réservation',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Fermer le popup
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                      (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                minimumSize: const Size(double.infinity, 48),
              ),
              child: const Text(
                'Retour à la page d\'accueil',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow({
    required String label,
    required String value,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
