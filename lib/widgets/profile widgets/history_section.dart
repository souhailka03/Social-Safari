import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'models/reservation.dart';

class HistorySection extends StatefulWidget {
  const HistorySection({Key? key}) : super(key: key);

  @override
  State<HistorySection> createState() => _HistorySectionState();
}

class _HistorySectionState extends State<HistorySection> {
  String selectedFilter = 'Tout';
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  DateTime? _selectedDate;
  int? _selectedPeople;

  final List<Reservation> _allReservations = [
    Reservation(
      destinationName: 'Station de Ski Les Trois Vallées',
      numberOfPeople: 4,
      activityType: 'Forfait 6 jours',
      dateTime: DateTime.now().add(const Duration(days: 15)),
      location: 'Les Menuires, Savoie',
      status: 'Confirmée',
      isConfirmed: true,
    ),
    Reservation(
      destinationName: 'Plage des Pins',
      numberOfPeople: 2,
      activityType: 'Location parasol',
      dateTime: DateTime(2024, 7, 15, 10, 00),
      location: 'Biarritz, France',
      status: 'En attente',
      isConfirmed: false,
    ),
    Reservation(
      destinationName: 'Circuit de Monaco',
      numberOfPeople: 2,
      activityType: 'Grand Prix de Monaco',
      dateTime: DateTime(2024, 5, 26, 14, 00),
      location: 'Monte Carlo, Monaco',
      status: 'Confirmée',
      isConfirmed: true,
    ),
    Reservation(
      destinationName: 'Parc d\'attractions Disneyland Paris',
      numberOfPeople: 4,
      activityType: 'Billet 2 jours',
      dateTime: DateTime(2024, 8, 10, 9, 00),
      location: 'Marne-la-Vallée, France',
      status: 'En attente',
      isConfirmed: false,
    ),
    Reservation(
      destinationName: 'Château de Versailles',
      numberOfPeople: 2,
      activityType: 'Visite guidée',
      dateTime: DateTime(2024, 6, 20, 11, 00),
      location: 'Versailles, France',
      status: 'Confirmée',
      isConfirmed: true,
    ),
    Reservation(
      destinationName: 'Parc National des Calanques',
      numberOfPeople: 3,
      activityType: 'Excursion en bateau',
      dateTime: DateTime(2024, 7, 5, 9, 30),
      location: 'Marseille, France',
      status: 'En attente',
      isConfirmed: false,
    ),
  ];

  List<Reservation> get _filteredReservations {
    List<Reservation> filtered = _allReservations.where((reservation) {
      // Apply search filter
      if (_searchQuery.isNotEmpty) {
        final searchLower = _searchQuery.toLowerCase();
        return reservation.destinationName.toLowerCase().contains(searchLower) ||
            reservation.location.toLowerCase().contains(searchLower) ||
            reservation.activityType.toLowerCase().contains(searchLower);
      }

      // Apply category filter
      switch (selectedFilter) {
        case 'Tous':
          return true;
        case 'Confirmés':
          return reservation.isConfirmed;
        case 'En attente':
          return !reservation.isConfirmed;
        default:
          return true;
      }
    }).toList();

    // Sort reservations: En attente first, then Confirmées
    filtered.sort((a, b) {
      if (a.isConfirmed == b.isConfirmed) {
        // If same status, sort by date
        return a.dateTime.compareTo(b.dateTime);
      }
      // Put unconfirmed (En attente) first
      return a.isConfirmed ? 1 : -1;
    });

    return filtered;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _shareReservation(Reservation reservation) async {
    await Share.share(reservation.shareText);
  }

  Future<void> _showPrintPreview(Reservation reservation) async {
    await showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          width: 600,
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Détails du Voyage',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              Divider(),
              SizedBox(height: 16),
              Text(
                'Destination: ${reservation.destinationName}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 8),
              Text(
                'Date: ${reservation.formattedDate}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                'Nombre de personnes: ${reservation.numberOfPeople}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                'Type d\'activité: ${reservation.activityType}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                'Lieu: ${reservation.location}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                'Statut: ${reservation.status}',
                style: TextStyle(
                  fontSize: 16,
                  color: reservation.isConfirmed ? Colors.green : Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton.icon(
                    icon: Icon(Icons.print),
                    label: Text('Imprimer'),
                    onPressed: () {
                      // Here you would implement actual printing functionality
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF6D56FF),
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showModificationDialog(Reservation reservation) async {
    if (reservation.isConfirmed) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
          Text('Les voyages confirmés ne peuvent pas être modifiés'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    DateTime selectedDate = reservation.dateTime;
    int selectedPeople = reservation.numberOfPeople;

    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Dialog(
          child: Container(
            width: 400,
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Modifier le Voyage',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 24),
                Text('Date et heure'),
                SizedBox(height: 8),
                InkWell(
                  onTap: () async {
                    final DateTime now = DateTime.now();
                    final DateTime initialDate =
                    selectedDate.isBefore(now) ? now : selectedDate;
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: initialDate,
                      firstDate: now,
                      lastDate: now.add(Duration(days: 365)),
                    );
                    if (picked != null) {
                      final TimeOfDay? time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(selectedDate),
                      );
                      if (time != null) {
                        setState(() {
                          selectedDate = DateTime(
                            picked.year,
                            picked.month,
                            picked.day,
                            time.hour,
                            time.minute,
                          );
                        });
                      }
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.calendar_today),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            '${selectedDate.day}/${selectedDate.month}/${selectedDate.year} à ${selectedDate.hour}:${selectedDate.minute.toString().padLeft(2, '0')}',
                            style: TextStyle(fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text('Nombre de personnes'),
                SizedBox(height: 8),
                DropdownButtonFormField<int>(
                  value: selectedPeople,
                  items: List.generate(10, (index) => index + 1)
                      .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text('$e personne${e > 1 ? 's' : ''}'),
                  ))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        selectedPeople = value;
                      });
                    }
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Annuler'),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        // Update the reservation
                        this.setState(() {
                          final index = _allReservations.indexOf(reservation);
                          if (index != -1) {
                            _allReservations[index] = Reservation(
                              destinationName: reservation.destinationName,
                              numberOfPeople: selectedPeople,
                              activityType: reservation.activityType,
                              dateTime: selectedDate,
                              location: reservation.location,
                              status: 'En attente',
                              isConfirmed: false,
                            );
                          }
                        });
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Voyage modifié avec succès'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      },
                      child: Text('Confirmer'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF6D56FF),
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  // Search Bar
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Rechercher dans mes voyages',
                      prefixIcon:
                      const Icon(Icons.search, color: Color(0xFF9CA3AF)),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      filled: true,
                      fillColor: const Color(0xFFF9FAFB),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      hintStyle: const TextStyle(
                        color: Color(0xFF9CA3AF),
                        fontSize: 14,
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                  ),
                  const SizedBox(height: 16),

                  // Filter Buttons
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildFilterButton('Tous'),
                        const SizedBox(width: 8),
                        _buildFilterButton('Confirmés'),
                        const SizedBox(width: 8),
                        _buildFilterButton('En attente'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Reservation Cards
            Expanded(
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _filteredReservations.length,
                  itemBuilder: (context, index) {
                    final reservation = _filteredReservations[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _buildReservationCard(reservation),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterButton(String label) {
    bool isSelected = selectedFilter == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilter = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF6D56FF) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color:
            isSelected ? const Color(0xFF6D56FF) : const Color(0xFFE5E7EB),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF6B7280),
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildReservationCard(Reservation reservation) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Text(
                  reservation.destinationName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: reservation.isConfirmed
                      ? const Color(0xFFDCFCE7)
                      : const Color(0xFFFEF9C3),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  reservation.status,
                  style: TextStyle(
                    fontSize: 12,
                    color: reservation.isConfirmed
                        ? const Color(0xFF166534)
                        : const Color(0xFF854D0E),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '${reservation.numberOfPeople} personnes • ${reservation.activityType}',
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF6B7280),
            ),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.calendar_today,
                size: 16,
                color: Color(0xFF6B7280),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  reservation.formattedDate,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF6B7280),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.location_on,
                size: 16,
                color: Color(0xFF6B7280),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  reservation.location,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF6B7280),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _showModificationDialog(reservation),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF6D56FF)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Modifier',
                    style: TextStyle(
                      color: Color(0xFF6D56FF),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 40,
                height: 40,
                child: IconButton(
                  onPressed: () => _shareReservation(reservation),
                  icon: const Icon(Icons.share, color: Color(0xFF6B7280)),
                  style: IconButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFE5E7EB)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 40,
                height: 40,
                child: IconButton(
                  onPressed: () => _showPrintPreview(reservation),
                  icon: const Icon(Icons.print, color: Color(0xFF6B7280)),
                  style: IconButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFE5E7EB)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
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
