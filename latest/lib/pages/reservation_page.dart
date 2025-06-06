import 'package:flutter/material.dart';
import '../data/user_state.dart';
import 'paiment.dart';

class ReservationPage extends StatefulWidget {
  final Map<String, String> offerDetails;

  const ReservationPage({
    Key? key,
    required this.offerDetails,
  }) : super(key: key);

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  String selectedMonth = "Avril 2025";
  List<int> selectedDays = [];
  int adultCount = 2;
  int childCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 80),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(maxWidth: 500),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const ReservationHeader(),
                        const SizedBox(height: 15),
                        DateSelector(
                          selectedMonth: selectedMonth,
                          onMonthChanged: (month) {
                            setState(() {
                              selectedMonth = month;
                              // Réinitialiser les jours sélectionnés lors du changement de mois
                              selectedDays = [];
                            });
                          },
                          selectedDays: selectedDays,
                          onDaySelected: (day) {
                            setState(() {
                              if (selectedDays.contains(day)) {
                                selectedDays.remove(day);
                              } else {
                                selectedDays.add(day);
                                selectedDays.sort();
                              }
                            });
                          },
                        ),
                        const SizedBox(height: 15),
                        TravelersSelector(
                          adultCount: adultCount,
                          childCount: childCount,
                          onAdultCountChanged: (count) {
                            setState(() {
                              adultCount = count;
                            });
                          },
                          onChildCountChanged: (count) {
                            setState(() {
                              childCount = count;
                            });
                          },
                        ),
                        const SizedBox(height: 15),
                        OptionsSection(offerDetails: widget.offerDetails),
                        const SizedBox(height: 15),
                        Summary(
                          pricePerNight: int.tryParse(widget.offerDetails['price'] ?? '890') ?? 890,
                          nightCount: selectedDays.isNotEmpty ? selectedDays.length : 1,
                          adultCount: adultCount,
                          childCount: childCount,
                          childDiscount: 0.25, // 25% de réduction pour les enfants
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Bouton fixe en bas
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
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
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // Calcul du prix total
                      final int pricePerNight = int.tryParse(widget.offerDetails['price'] ?? '890') ?? 890;
                      final int adultTotal = pricePerNight * selectedDays.length * adultCount;
                      final double childDiscountedPrice = pricePerNight * (1 - 0.25);
                      final double childTotal = childDiscountedPrice * selectedDays.length * childCount;
                      final double subTotal = adultTotal + childTotal;
                      final double tax = subTotal * 0.1;
                      final double serviceFee = (adultCount + childCount) * 20.0;
                      final double finalTotal = subTotal + tax + serviceFee;

                      // Navigation vers la page de paiement
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentPage(
                            offerDetails: widget.offerDetails,
                            nightCount: selectedDays.length,
                            adultCount: adultCount,
                            childCount: childCount,
                            totalPrice: finalTotal,
                          ),
                        ),
                      );
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
                      'Procéder au paiement',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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

class DateSelector extends StatelessWidget {
  final String selectedMonth;
  final Function(String) onMonthChanged;
  final List<int> selectedDays;
  final Function(int) onDaySelected;

  const DateSelector({
    Key? key,
    required this.selectedMonth,
    required this.onMonthChanged,
    required this.selectedDays,
    required this.onDaySelected,
  }) : super(key: key);

  // Obtenir le nombre de jours dans le mois sélectionné
  int _getDaysInMonth() {
    // Extraire l'année et le mois du format "Mois Année"
    final parts = selectedMonth.split(' ');
    final int year = int.parse(parts[1]);
    int month;

    switch (parts[0].toLowerCase()) {
      case 'janvier': month = 1; break;
      case 'février': month = 2; break;
      case 'mars': month = 3; break;
      case 'avril': month = 4; break;
      case 'mai': month = 5; break;
      case 'juin': month = 6; break;
      case 'juillet': month = 7; break;
      case 'août': month = 8; break;
      case 'septembre': month = 9; break;
      case 'octobre': month = 10; break;
      case 'novembre': month = 11; break;
      case 'décembre': month = 12; break;
      default: month = 4; // Par défaut Avril
    }

    // Déterminer le nombre de jours dans le mois
    return DateTime(year, month + 1, 0).day;
  }

  @override
  Widget build(BuildContext context) {
    final List<String> days = const ["L", "M", "M", "J", "V", "S", "D"];
    final List<String> months = [
      'Mars 2025',
      'Avril 2025',
      'Mai 2025',
      'Juin 2025',
      'Juillet 2025',
      'Août 2025',
      'Septembre 2025',
    ];

    // Nombre de jours dans le mois sélectionné
    final int daysInMonth = _getDaysInMonth();

    final List<Map<String, dynamic>> dates = List.generate(
      daysInMonth,
          (index) => {
        "day": index + 1,
        "price": "${(index % 7 == 0) ? 450 : 80 + (index % 15)}MAD",
      },
    );

    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Sélectionnez vos dates",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedMonth,
                    icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF6D56FF), size: 16),
                    isDense: true,
                    items: months.map((String month) {
                      return DropdownMenuItem<String>(
                        value: month,
                        child: Text(
                          month,
                          style: const TextStyle(fontSize: 13),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        onMonthChanged(newValue);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
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
                // Jours de la semaine
                Row(
                  children: days
                      .map((day) => Expanded(
                    child: Center(
                      child: Text(
                        day,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[500],
                        ),
                      ),
                    ),
                  ))
                      .toList(),
                ),
                const SizedBox(height: 8),

                // Grille des jours du mois
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    childAspectRatio: 1,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                  ),
                  itemCount: dates.length,
                  itemBuilder: (context, index) {
                    final day = dates[index]["day"] as int;
                    final price = dates[index]["price"] as String;
                    final isSelected = selectedDays.contains(day);

                    return GestureDetector(
                      onTap: () => onDaySelected(day),
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFF6D56FF) : Colors.white,
                          border: Border.all(
                            color: isSelected ? const Color(0xFF6D56FF) : Colors.grey[300]!,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "$day",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                color: isSelected ? Colors.white : Colors.black,
                              ),
                            ),
                            Text(
                              price,
                              style: TextStyle(
                                fontSize: 8,
                                color: isSelected ? Colors.white : const Color(0xFF6D56FF),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 16),

                // Résumé de la sélection
                if (selectedDays.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8F7FF),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFF6D56FF).withOpacity(0.2)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.date_range, color: Color(0xFF6D56FF), size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            selectedDays.length > 1
                                ? "Du ${selectedDays.first} au ${selectedDays.last} ${selectedMonth.split(' ')[0]} (${selectedDays.length} nuits)"
                                : "${selectedDays.first} ${selectedMonth.split(' ')[0]} (1 nuit)",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF6D56FF),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TravelersSelector extends StatelessWidget {
  final int adultCount;
  final int childCount;
  final Function(int) onAdultCountChanged;
  final Function(int) onChildCountChanged;

  const TravelersSelector({
    Key? key,
    required this.adultCount,
    required this.childCount,
    required this.onAdultCountChanged,
    required this.onChildCountChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Voyageurs",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
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
                // Sélecteur d'adultes
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Adultes",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "16 ans et plus",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        _buildCounterButton(
                          icon: Icons.remove,
                          onPressed: adultCount > 1
                              ? () => onAdultCountChanged(adultCount - 1)
                              : null,
                        ),
                        Container(
                          width: 40,
                          alignment: Alignment.center,
                          child: Text(
                            "$adultCount",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        _buildCounterButton(
                          icon: Icons.add,
                          onPressed: adultCount < 10
                              ? () => onAdultCountChanged(adultCount + 1)
                              : null,
                        ),
                      ],
                    ),
                  ],
                ),
                const Divider(height: 24),
                // Sélecteur d'enfants
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Enfants",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "Moins de 16 ans",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        _buildCounterButton(
                          icon: Icons.remove,
                          onPressed: childCount > 0
                              ? () => onChildCountChanged(childCount - 1)
                              : null,
                        ),
                        Container(
                          width: 40,
                          alignment: Alignment.center,
                          child: Text(
                            "$childCount",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        _buildCounterButton(
                          icon: Icons.add,
                          onPressed: childCount < 8
                              ? () => onChildCountChanged(childCount + 1)
                              : null,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCounterButton({
    required IconData icon,
    required VoidCallback? onPressed,
  }) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: onPressed != null ? const Color(0xFF6D56FF) : Colors.grey[300],
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(icon, size: 16, color: Colors.white),
        onPressed: onPressed,
      ),
    );
  }
}

class ReservationHeader extends StatelessWidget {
  const ReservationHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ligne supérieure avec bouton retour, titre et étape
          Row(
            children: [
              // Bouton retour
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.of(context).pop(); // Retour à l'écran précédent
                },
              ),
              const SizedBox(width: 8), // Espacement

              // Titre "Réservation"
              const Expanded(
                child: Text(
                  "Réservation",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // Étape actuelle
              const Text(
                "Étape 1/2",
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF6D56FF),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8), // Espacement

          // Barre de progression
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFF6D56FF),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                flex: 1,
                child: Container(
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFFC9C9C9),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class OptionsSection extends StatelessWidget {
  final Map<String, String> offerDetails;

  const OptionsSection({
    Key? key,
    required this.offerDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Votre séjour",
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
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                  child: Image.network(
                    offerDetails['image'] ?? '',
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: double.infinity,
                        height: 200,
                        color: Colors.grey[300],
                        child: const Center(
                          child: Icon(Icons.image_not_supported, size: 40, color: Colors.grey),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        offerDetails['title'] ?? 'Séjour',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.location_on, size: 16, color: Colors.grey),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              offerDetails['location'] ?? 'Emplacement non spécifié',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (offerDetails['price'] != null) ...[
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.payments_outlined, size: 16, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text(
                              '${offerDetails['price']} MAD / nuit',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Summary extends StatelessWidget {
  final int pricePerNight;
  final int nightCount;
  final int adultCount;
  final int childCount;
  final double childDiscount;

  const Summary({
    Key? key,
    required this.pricePerNight,
    required this.nightCount,
    required this.adultCount,
    required this.childCount,
    required this.childDiscount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int adultTotal = pricePerNight * nightCount * adultCount;
    final double childDiscountedPrice = pricePerNight * (1 - childDiscount);
    final double childTotal = childDiscountedPrice * nightCount * childCount;
    final double subTotal = adultTotal + childTotal;
    final double tax = subTotal * 0.1;
    final double serviceFee = (adultCount + childCount) * 20.0;
    final double finalTotal = subTotal + tax + serviceFee;

    return Container(
      width: double.infinity,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.receipt_long, size: 16, color: Color(0xFF6D56FF)),
              const SizedBox(width: 5),
              const Text(
                "Récapitulatif",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("$pricePerNight MAD × $nightCount nuits × $adultCount adultes",
                  style: const TextStyle(fontSize: 13)),
              Text(
                "${adultTotal.toStringAsFixed(0)} MAD",
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          if (childCount > 0) ...[
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${childDiscountedPrice.toStringAsFixed(0)} MAD × $nightCount nuits × $childCount enfants",
                    style: const TextStyle(fontSize: 13)),
                Text(
                  "${childTotal.toStringAsFixed(0)} MAD",
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            const Text(
              "Réduction de 25% appliquée pour les enfants",
              style: TextStyle(
                fontSize: 12,
                fontStyle: FontStyle.italic,
                color: Color(0xFF6D56FF),
              ),
            ),
          ],
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Taxes de séjour", style: TextStyle(fontSize: 13)),
              Text(
                "${tax.toStringAsFixed(0)} MAD",
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Frais de service", style: TextStyle(fontSize: 13)),
              Text(
                "${serviceFee.toStringAsFixed(0)} MAD",
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "${finalTotal.toStringAsFixed(0)} MAD",
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF6D56FF),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
