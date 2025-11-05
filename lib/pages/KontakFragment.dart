import 'package:flutter/material.dart';

class KontakFragment extends StatelessWidget {
  const KontakFragment({super.key});

  // Data kontak statis
  final List<Map<String, dynamic>> _contacts = const [
    {
      'name': 'Rico Fadli Alfiansyah',
      'phone': '+62 123-4567-8901',
      'email': 'rico.fadli@example.com',
      'initial': 'RF',
      'color': 0xFF1E88E5,
    },
    {
      'name': 'Areu',
      'phone': '+62 123-4567-8901',
      'email': 'azahra.dwi@mhs.itenas.ac.id',
      'initial': 'D',
      'color': 0xFF010663,
    },
    {
      'name': 'orin',
      'phone': '+62 123-4567-8901',
      'email': 'rini.rianty@mhs.itenas.ac.id',
      'initial': 'rr',
      'color': 0xFFFB8C00,
    },
    {
      'name': 'Khoerunnisa Somawijaya',
      'phone': '+62 123-4567-8901',
      'email': 'knisa8970@gmail.com',
      'initial': 'KS',
      'color': 0xFFf39cff,
    },
    {
      'name': 'Mila Siti Nabila',
      'phone': '+62 123-4567-8901',
      'email': 'mila.siti@mhs.itenas.ac.id',
      'initial': 'MSN',
      'color': 0xFF5E35B1,
    },
    {
      'name': 'Muhammad Reza Faishal',
      'phone': '+62 123-4567-8901',
      'email': 'rezafaishal8@gmail.com',
      'initial': 'zaw',
      'color': 0xFF00897B,
    },
    {
      'name': 'Verenada Arsy Mardatilah',
      'phone': '+62 123-4567-8901',
      'email': 'verenada.arsy@.mhs.itenas.ac.id',
      'initial': 'VA',
      'color': 0xFFD81B60,
    },
    {
      'name': 'Aliyya Rahmawati Putri',
      'phone': '+62 123-4567-8901',
      'email': 'aliyya.rahma@mhs.itenas.ac.id',
      'initial': 'AR',
      'color': 0xFF3949AB,
    },
    {
      'name': 'Martin Aman',
      'phone': '+62 123-4567-8901',
      'email': 'martin.rizki@mhs.itenas.ac.id',
      'initial': 'MA',
      'color': 0xFF7CB342,
    },
    {
      'name': 'Opik Ngantuk',
      'phone': '+62 123-4567-8901',
      'email': 'taufik.rahman@mhs.itenas.ac.id',
      'initial': 'ON',
      'color': 0xFFF4511E,
    },
    {
      'name': 'Yudha Botol',
      'phone': '+62 123-4567-8901',
      'email': 'yudha.kristian@mhs.itenas.ac.id',
      'initial': 'YB',
      'color': 0xFF5E35B1,
    },
    {
      'name': 'Mobil Alya',
      'phone': '+62 123-4567-8901',
      'email': 'alya.marwa@mhs.itenas.ac.id',
      'initial': 'MA',
      'color': 0xFF039BE5,
    },
    {
      'name': 'Farisy Ilman',
      'phone': '+62 123-4567-8901',
      'email': 'farisy.ilman@mhs.itenas.ac.id',
      'initial': 'FI',
      'color': 0xFFE53935,
    },
    {
      'name': 'Sastra S',
      'phone': '+62 123-4567-8901',
      'email': 'sastra.sastra@mhs.itenas.ic.id',
      'initial': 'SS',
      'color': 0xFF43A047,
    },
    {
      'name': 'Rina Melati',
      'phone': '+62 123-4567-8901',
      'email': 'rina.melati@example.com',
      'initial': 'RM',
      'color': 0xFF8E24AA,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xD3DAD9),
      body: Column(
        children: [
          // Search Bar
          _buildSearchBar(),
          // Contact Count
          _buildContactCount(),
          // Contact List
          _buildContactList(context),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Color(0xFF37353E),
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Cari kontak...',
            hintStyle: TextStyle(
              color: Color(0xFFD3DAD9), // Warna abu-abu gelap
            ),
            prefixIcon: const Icon(Icons.search, color: Color(0xFFD3DAD9)),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 15),
          ),
        ),
      ),
    );
  }

  Widget _buildContactCount() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Text(
            '${_contacts.length} Kontak',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF37353E),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Row(
              children: [
                Icon(Icons.sort, color: Colors.white, size: 16),
                SizedBox(width: 4),
                Text(
                  'Urutkan',
                  style: TextStyle(
                    color: Color(0xFFD3DAD9),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactList(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _contacts.length,
        itemBuilder: (context, index) {
          final contact = _contacts[index];
          return _buildContactItem(context, contact, index);
        },
      ),
    );
  }

  Widget _buildContactItem(BuildContext context, Map<String, dynamic> contact, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: _buildAvatar(contact),
        title: Text(
          contact['name'],
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.phone, size: 14, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  contact['phone'],
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            Row(
              children: [
                Icon(Icons.email, size: 14, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  contact['email'],
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.phone_outlined,
            size: 20,
            color: Color(0xFF37353E),
          ),
        ),
        onTap: () {
          _showContactDetails(context, contact);
        },
      ),
    );
  }

  Widget _buildAvatar(Map<String, dynamic> contact) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: Color(contact['color']),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Color(contact['color']).withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Center(
            child: Text(
              contact['initial'],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 16,
              height: 16,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.circle,
                size: 14,
                color: Colors.green[400],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showContactDetails(BuildContext context, Map<String, dynamic> contact) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return _buildContactDetailSheet(contact);
      },
    );
  }

  Widget _buildContactDetailSheet(Map<String, dynamic> contact) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Avatar Besar
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Color(contact['color']),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Color(contact['color']).withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  contact['initial'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            
            // Nama
            Text(
              contact['name'],
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF37353E),
              ),
            ),
            const SizedBox(height: 8),
            
            // Status
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.circle, size: 8, color: Colors.green[400]),
                  const SizedBox(width: 6),
                  const Text(
                    'Online',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            
            // Info Kontak
            _buildDetailItem(Icons.phone, 'Telepon', contact['phone']),
            _buildDetailItem(Icons.email, 'Email', contact['email']),
            _buildDetailItem(Icons.location_on, 'Lokasi', 'Bandubg, Indonesia'),
            
            const SizedBox(height: 30),
            
            // Tombol Aksi
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.message),
                    label: const Text('Pesan'),
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.phone),
                    label: const Text('Panggil'),
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF37353E),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(IconData icon, String title, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF37353E), size: 20),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}