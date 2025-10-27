import 'package:flutter/material.dart';

class CuacaFragment extends StatefulWidget {
  const CuacaFragment({super.key});

  @override
  State<CuacaFragment> createState() => _CuacaFragmentState();
}

class _CuacaFragmentState extends State<CuacaFragment> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  // Data cuaca statis
  final List<Map<String, dynamic>> _weatherData = [
    {
      'city': 'Bandung',
      'temperature': 28,
      'condition': 'Cerah',
      'humidity': 65,
      'wind': 12,
      'pressure': 1013,
      'feelsLike': 30,
      'uvIndex': 8,
      'visibility': 10,
      'icon': '☀️',
      'color': Colors.orange,
      'gradient': [Color(0xFFFFB74D), Color(0xFFFF9800)],
    },
    {
      'city': 'Jakarta',
      'temperature': 32,
      'condition': 'Hujan Ringan',
      'humidity': 85,
      'wind': 8,
      'pressure': 1009,
      'feelsLike': 36,
      'uvIndex': 3,
      'visibility': 6,
      'icon': '🌦️',
      'color': Colors.blue,
      'gradient': [Color(0xFF64B5F6), Color(0xFF1976D2)],
    },
    {
      'city': 'Yogyakarta',
      'temperature': 24,
      'condition': 'Berawan',
      'humidity': 75,
      'wind': 15,
      'pressure': 1011,
      'feelsLike': 26,
      'uvIndex': 5,
      'visibility': 8,
      'icon': '☁️',
      'color': Colors.grey,
      'gradient': [Color(0xFFBDBDBD), Color(0xFF757575)],
    },
    {
      'city': 'Surabaya',
      'temperature': 34,
      'condition': 'Cerah Berawan',
      'humidity': 70,
      'wind': 10,
      'pressure': 1010,
      'feelsLike': 38,
      'uvIndex': 9,
      'visibility': 12,
      'icon': '⛅',
      'color': Colors.amber,
      'gradient': [Color(0xFFFFD54F), Color(0xFFFFA000)],
    },
  ];

  int _selectedCityIndex = 2; // Default Bandung

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    
    _animation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Map<String, dynamic> get _currentWeather => _weatherData[_selectedCityIndex];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        slivers: [
          // Header dengan Search
          SliverToBoxAdapter(
            child: _buildHeader(),
          ),
          // Current Weather Card
          SliverToBoxAdapter(
            child: _buildCurrentWeather(),
          ),
          // Weather Details
          SliverToBoxAdapter(
            child: _buildWeatherDetails(),
          ),
          // Forecast Title
          SliverToBoxAdapter(
            child: _buildForecastTitle(),
          ),
          // Forecast List
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return _buildForecastItem(index);
              },
              childCount: 5, // 5 hari forecast
            ),
          ),
          // City Selector
          SliverToBoxAdapter(
            child: _buildCitySelector(),
          ),
          // Extra space at bottom
          const SliverToBoxAdapter(
            child: SizedBox(height: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 50, 24, 24), // Reduced top padding
      decoration: BoxDecoration(
        color: const Color(0xFF37353E), // Solid color seperti halaman lain
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Location and Menu
          Row(
            children: [
              const Icon(Icons.location_on, color: Colors.white, size: 20),
              const SizedBox(width: 8),
              Text(
                _currentWeather['city'],
                style: const TextStyle(
                  fontSize: 20, // Smaller font size
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.more_vert, color: Colors.white, size: 20),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Weather Icon and Temperature
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _currentWeather['icon'],
                style: const TextStyle(fontSize: 48), // Smaller icon
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${_currentWeather['temperature']}°',
                    style: const TextStyle(
                      fontSize: 36, // Smaller temperature
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    _currentWeather['condition'],
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Search Bar
          Container(
            height: 45, // Slightly smaller
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Cari kota...',
                hintStyle: const TextStyle(color: Colors.white70),
                prefixIcon: const Icon(Icons.search, color: Colors.white, size: 20),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentWeather() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.scale(
            scale: _animation.value,
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: _currentWeather['gradient'],
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  children: [
                    Text(
                      'Detail Cuaca',
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _currentWeather['icon'],
                          style: const TextStyle(fontSize: 64),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${_currentWeather['temperature']}°',
                              style: const TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Terasa seperti ${_currentWeather['feelsLike']}°',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _getWeatherQuote(_currentWeather['condition']),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildWeatherDetails() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        children: [
          _buildDetailCard(
            Icons.air,
            'Angin',
            '${_currentWeather['wind']} km/jam',
            Colors.blue,
          ),
          _buildDetailCard(
            Icons.water_drop,
            'Kelembapan',
            '${_currentWeather['humidity']}%',
            Colors.lightBlue,
          ),
          _buildDetailCard(
            Icons.compress,
            'Tekanan',
            '${_currentWeather['pressure']} hPa',
            Colors.deepPurple,
          ),
          _buildDetailCard(
            Icons.visibility,
            'Visibilitas',
            '${_currentWeather['visibility']} km',
            Colors.teal,
          ),
        ],
      ),
    );
  }

  Widget _buildForecastTitle() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 12),
      child: Text(
        'Prakiraan 5 Hari',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xFF37353E),
        ),
      ),
    );
  }

  Widget _buildForecastItem(int index) {
    final List<Map<String, String>> forecastData = [
      {
        'day': 'Hari Ini',
        'icon': '☀️',
        'condition': 'Cerah',
        'highTemp': '32',
        'lowTemp': '24',
      },
      {
        'day': 'Besok',
        'icon': '⛅',
        'condition': 'Cerah Berawan',
        'highTemp': '31',
        'lowTemp': '25',
      },
      {
        'day': 'Rabu',
        'icon': '🌦️',
        'condition': 'Hujan Ringan',
        'highTemp': '29',
        'lowTemp': '24',
      },
      {
        'day': 'Kamis',
        'icon': '🌧️',
        'condition': 'Hujan Sedang',
        'highTemp': '28',
        'lowTemp': '23',
      },
      {
        'day': 'Jumat',
        'icon': '☁️',
        'condition': 'Berawan',
        'highTemp': '30',
        'lowTemp': '24',
      },
    ];

    final forecast = forecastData[index];
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: Card(
        margin: const EdgeInsets.only(bottom: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          leading: Text(
            forecast['icon']!,
            style: const TextStyle(fontSize: 32),
          ),
          title: Text(
            forecast['day']!,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(
            forecast['condition']!,
            style: const TextStyle(fontSize: 12),
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${forecast['highTemp']}°',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${forecast['lowTemp']}°',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCitySelector() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Pilih Kota',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF37353E),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _weatherData.length,
              itemBuilder: (context, index) {
                final city = _weatherData[index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedCityIndex = index;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    decoration: BoxDecoration(
                      color: _selectedCityIndex == index 
                          ? city['color'] 
                          : Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: _selectedCityIndex == index 
                            ? city['color'] 
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          city['icon'],
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          city['city'],
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: _selectedCityIndex == index 
                                ? Colors.white 
                                : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailCard(IconData icon, String title, String value, Color color) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF37353E),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getWeatherQuote(String condition) {
    switch (condition) {
      case 'Cerah':
        return 'Hari yang sempurna untuk aktivitas outdoor!';
      case 'Hujan Ringan':
        return 'Jangan lupa bawa payung!';
      case 'Berawan':
        return 'Cuaca yang nyaman untuk beraktivitas';
      case 'Cerah Berawan':
        return 'Hari yang cerah dengan sedikit awan';
      default:
        return 'Nikmati harimu!';
    }
  }
}