import 'package:flutter/material.dart';
import 'paiment_reussi.dart';

class PaymentPage extends StatefulWidget {
  final Map<String, String> offerDetails;
  final int nightCount;
  final int adultCount;
  final int childCount;
  final double totalPrice;

  const PaymentPage({
    Key? key,
    required this.offerDetails,
    required this.nightCount,
    required this.adultCount,
    required this.childCount,
    required this.totalPrice,
  }) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String selectedPaymentMethod = 'card';
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  final TextEditingController cardNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header avec le titre et l'étape
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Text(
                    "Paiement",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    "Étape 2/2",
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF6D56FF),
                    ),
                  ),
                ],
              ),
            ),

            // Barre de progression
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: 4,
                            decoration: BoxDecoration(
                              color: const Color(0xFFC9C9C9),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: 4,
                            decoration: BoxDecoration(
                              color: const Color(0xFF6D56FF),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Résumé de la réservation
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Résumé de votre réservation",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            offset: const Offset(0, 1),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF8F7FF),
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                            ),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                              child: Image.network(
                                widget.offerDetails['image'] ?? '',
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Center(
                                    child: Icon(
                                      Icons.hotel,
                                      size: 80,
                                      color: Colors.grey[400],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.offerDetails['title'] ?? 'Séjour',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
                                    const SizedBox(width: 4),
                                    Expanded(
                                      child: Text(
                                        widget.offerDetails['location'] ?? 'Emplacement non spécifié',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${widget.nightCount} nuits',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Icon(Icons.people, size: 16, color: Colors.grey[600]),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${widget.adultCount} adultes${widget.childCount > 0 ? ', ${widget.childCount} enfants' : ''}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Icon(Icons.payments_outlined, size: 16, color: Colors.grey[600]),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${widget.totalPrice.toStringAsFixed(0)} MAD',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF6D56FF),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Méthodes de paiement
                    const Text(
                      "Méthode de paiement",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            offset: const Offset(0, 1),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildPaymentMethodButton(
                            icon: Icons.credit_card,
                            title: "Carte",
                            isSelected: selectedPaymentMethod == 'card',
                            onTap: () {
                              setState(() {
                                selectedPaymentMethod = 'card';
                              });
                            },
                          ),
                          _buildPaymentMethodButton(
                            icon: Icons.paypal,
                            title: "PayPal",
                            isSelected: selectedPaymentMethod == 'paypal',
                            onTap: () {
                              _showPayPalLoginDialog(context);
                            },
                          ),
                          _buildPaymentMethodButton(
                            icon: Icons.apple,
                            title: "Apple Pay",
                            isSelected: selectedPaymentMethod == 'apple',
                            onTap: () {
                              _showApplePayLoginDialog(context);
                            },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Formulaire de paiement
                    const Text(
                      "Informations de paiement",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            offset: const Offset(0, 1),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          _buildTextField(
                            label: "Numéro de carte",
                            hint: "1234 5678 9012 3456",
                            icon: Icons.credit_card,
                            controller: cardNumberController,
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: _buildTextField(
                                  label: "Date d'expiration",
                                  hint: "MM/AA",
                                  icon: Icons.calendar_today,
                                  controller: expiryDateController,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _buildTextField(
                                  label: "CVV",
                                  hint: "123",
                                  icon: Icons.lock,
                                  controller: cvvController,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          _buildTextField(
                            label: "Nom sur la carte",
                            hint: "JEAN DUPONT",
                            icon: Icons.person,
                            controller: cardNameController,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Barre de navigation en bas
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    offset: const Offset(0, -2),
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_validateForm()) {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) => PaymentSuccessDialog(
                              offerDetails: widget.offerDetails,
                              nightCount: widget.nightCount,
                              adultCount: widget.adultCount,
                              childCount: widget.childCount,
                              totalPrice: widget.totalPrice,
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Veuillez remplir tous les champs correctement'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6D56FF),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Payer maintenant',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _validateForm() {
    return cardNumberController.text.isNotEmpty &&
        expiryDateController.text.isNotEmpty &&
        cvvController.text.isNotEmpty &&
        cardNameController.text.isNotEmpty;
  }

  Widget _buildPaymentMethodButton({
    required IconData icon,
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF6D56FF).withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? const Color(0xFF6D56FF) : Colors.grey[300]!,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 24,
              color: isSelected ? const Color(0xFF6D56FF) : Colors.grey[600],
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? const Color(0xFF6D56FF) : Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPayPalLoginDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Connexion PayPal'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Email PayPal',
                hintText: 'votre@email.com',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Mot de passe',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                selectedPaymentMethod = 'paypal';
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6D56FF),
              foregroundColor: Colors.white,
            ),
            child: const Text('Se connecter'),
          ),
        ],
      ),
    );
  }

  void _showApplePayLoginDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Connexion Apple Pay'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Apple ID',
                hintText: 'votre@email.com',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Mot de passe',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                selectedPaymentMethod = 'apple';
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6D56FF),
              foregroundColor: Colors.white,
            ),
            child: const Text('Se connecter'),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required IconData icon,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, size: 20, color: Colors.grey[600]),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF6D56FF)),
            ),
          ),
        ),
      ],
    );
  }
}