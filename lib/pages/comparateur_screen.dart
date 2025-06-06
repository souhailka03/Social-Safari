import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../widgets/comparateur_widgets/custom_app_bar.dart';
import '../widgets/comparateur_widgets/hotel_card.dart';

class ComparateurScreen extends StatefulWidget {
  const ComparateurScreen({Key? key}) : super(key: key);

  @override
  State<ComparateurScreen> createState() => _ComparateurScreenState();
}

class _ComparateurScreenState extends State<ComparateurScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            labelColor: AppColors.primary,
            unselectedLabelColor: Colors.grey,
            indicatorColor: AppColors.primary,
            tabs: const [
              Tab(text: 'Hébergement'),
              Tab(text: 'Transport'),
              Tab(text: 'Activités'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildHebergementTab(),
                const Center(child: Text('Transport')),
                const Center(child: Text('Activités')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHebergementTab() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      children: [
        HotelCard(
          imageUrl:
              'https://cdn.builder.io/api/v1/image/assets/TEMP/84e8793d7d27df9ab8bb385fc5d8dc3311dec32d',
          name: 'Hôtel Luxe',
          location: 'Maroc, Marrakech',
          progress: 0.75,
          price: '999MAD/nuit',
          status: 'Excellent rapport qualité/prix',
          statusColor: AppColors.primary,
        ),
        HotelCard(
          imageUrl:
              'https://cdn.builder.io/api/v1/image/assets/TEMP/ecb78a7c04b197e7336e40471bea7c10df2ac9cd',
          name: 'Boutique Hôtel Marais',
          location: 'Le Marais, Paris',
          progress: 0.5,
          price: '850MAD/nuit',
          status: 'Bon rapport qualité/prix',
          statusColor: AppColors.primary,
          isFavorite: true,
        ),
        HotelCard(
          imageUrl:
              'https://cdn.builder.io/api/v1/image/assets/TEMP/895f5bbe37a3764fc26db8f70caec34dfd063751',
          name: 'Appartement Moderne',
          location: 'Bastille, Paris',
          progress: 0.8,
          price: '900MAD/nuit',
          status: 'Excellent rapport qualité/prix',
          statusColor: AppColors.primary,
        ),
      ],
    );
  }
}
