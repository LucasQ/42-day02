import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherappv2_proj/navbar/tabs/currently_tab.dart';
import 'package:weatherappv2_proj/navbar/tabs/today_tab.dart';
import 'package:weatherappv2_proj/navbar/tabs/weekly_tab.dart';
import 'package:weatherappv2_proj/services/location_service.dart';

class BottonNavBar extends StatefulWidget {
  const BottonNavBar({super.key});

  @override
  _BottonNavBarState createState() => _BottonNavBarState();
}

class _BottonNavBarState extends State<BottonNavBar>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  String _displayText = '';
  late TabController _tabController;

  final LocationService _locationService = LocationService();
  Position? _currentPosition;
  String? _address;

  Future<void> _getCurrentLocation() async {
    try {
      _currentPosition = await _locationService.getCurrentLocation();
      _address = await _locationService.getAddressFromCoordinates(
          _currentPosition!.latitude, _currentPosition!.longitude);
      setState(() {});
    } catch (e) {
      print("Error: $e");
    }
  }

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
      appBar: AppBar(
        leading: const Icon(
          Icons.search,
          color: Colors.white60,
        ),
        title: TextField(
          controller: _searchController,
          style: const TextStyle(
            color: Colors.white,
          ),
          decoration: const InputDecoration(
            hintText: 'Search location...',
            hintStyle: TextStyle(
              color: Colors.white70,
            ),
            border: InputBorder.none,
          ),
          onSubmitted: (text) {
            setState(() {
              _displayText = text;
            });
          },
        ),
        backgroundColor: Colors.grey[700],
        actions: [
          IconButton(
            icon: const Icon(Icons.location_pin),
            color: Colors.white,
            onPressed: () {
              setState(() {
                _getCurrentLocation();
                _displayText = 'Geolocation';
              });
            },
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          CurrentlyTab(title: 'Currently \n $_displayText'),
          TodayTab(title: 'Today \n $_displayText'),
          WeeklyTab(title: 'Weekly \n $_displayText'),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey[700],
        child: TabBar(
          dividerColor: Colors.black54,
          indicatorColor: Colors.black54,
          labelColor: Colors.black54,
          unselectedLabelColor: Colors.white60,
          unselectedLabelStyle: const TextStyle(
            color: Colors.white60,
          ),
          controller: _tabController,
          tabs: const [
            Tab(
              icon: Icon(Icons.access_time),
              text: 'Currently',
            ),
            Tab(icon: Icon(Icons.today), text: 'Today'),
            Tab(icon: Icon(Icons.calendar_today), text: 'Weekly'),
          ],
        ),
      ),
    );
  }
}
