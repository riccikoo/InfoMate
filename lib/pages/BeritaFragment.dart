import 'package:flutter/material.dart';

class BeritaFragment extends StatelessWidget {
  BeritaFragment({super.key});

  // Data berita statis
  final List<Map<String, dynamic>> _newsData = [
    {
      'id': 1,
      'title': 'OpenAI luncurkan platform untuk membuat ChatGPT kustom',
      'summary': 'OpenAI telah mengumumkan platform baru untuk membuat AI kustom yang dapat disesuaikan dengan kebutuhan spesifik berbagai industri dan penggunaan.',
      'category': 'Teknologi',
      'date': '2023/11/07 14:23:45 UTC',
      'readTime': '3 min baca',
      'imageUrl': 'https://picsum.photos/400/300?random=1',
      'isBookmarked': true,
    },
    {
      'id': 2,
      'title': 'Program panda National Zoo berakhir setelah 50 tahun',
      'summary': 'Tiga panda raksasa terakhir akan dikembalikan ke China menandai berakhirnya program konservasi panda di National Zoo setelah lebih dari lima dekade.',
      'category': 'Lingkungan',
      'date': '2023/11/07 12:17:12 UTC',
      'readTime': '4 min baca',
      'imageUrl': 'https://picsum.photos/400/300?random=2',
      'isBookmarked': false,
    },
    {
      'id': 3,
      'title': 'Flutter 3.0 dirilis dengan dukungan web dan desktop',
      'summary': 'Google merilis Flutter 3.0 dengan dukungan stabil untuk platform web dan desktop, memperluas kemampuan cross-platform development.',
      'category': 'Programming',
      'date': '2023/11/06 09:45:30 UTC',
      'readTime': '5 min baca',
      'imageUrl': 'https://picsum.photos/400/300?random=3',
      'isBookmarked': true,
    },
    {
      'id': 4,
      'title': 'Indonesia raih medali emas di SEA Games 2023',
      'summary': 'Tim Indonesia berhasil meraih 5 medali emas di hari pertama SEA Games 2023, menunjukkan performa yang mengesankan di berbagai cabang olahraga.',
      'category': 'Olahraga',
      'date': '2023/11/05 18:30:15 UTC',
      'readTime': '2 min baca',
      'imageUrl': 'https://picsum.photos/400/300?random=4',
      'isBookmarked': false,
    },
    {
      'id': 5,
      'title': 'Krisis iklim: Suhu global capai rekor tertinggi',
      'summary': 'Laporan terbaru menunjukkan suhu global mencapai rekor tertinggi, menekankan urgensi aksi iklim yang lebih ambisius dari seluruh negara.',
      'category': 'Lingkungan',
      'date': '2023/11/05 15:20:10 UTC',
      'readTime': '6 min baca',
      'imageUrl': 'https://picsum.photos/400/300?random=5',
      'isBookmarked': true,
    },
    {
      'id': 6,
      'title': 'Startup lokal raih pendanaan 50 juta',
      'summary': 'Startup teknologi asal Indonesia berhasil mengumpulkan pendanaan seri B senilai 50 juta dari investor internasional untuk ekspansi pasar.',
      'category': 'Bisnis',
      'date': '2023/11/04 11:10:05 UTC',
      'readTime': '3 min baca',
      'imageUrl': 'https://picsum.photos/400/300?random=6',
      'isBookmarked': false,
    },
    {
      'id': 7,
      'title': 'Inovasi baterai lithium terbaru tahan 10 tahun',
      'summary': 'Peneliti berhasil mengembangkan baterai lithium dengan masa pakai hingga 10 tahun, revolusioner untuk industri kendaraan listrik.',
      'category': 'Sains',
      'date': '2023/11/03 08:45:20 UTC',
      'readTime': '4 min baca',
      'imageUrl': 'https://picsum.photos/400/300?random=7',
      'isBookmarked': true,
    },
    {
      'id': 8,
      'title': 'Festival budaya Yogyakarta tarik 1 juta pengunjung',
      'summary': 'Festival budaya tahunan di Yogyakarta berhasil menarik lebih dari 1 juta pengunjung, mendongkrak pariwisata lokal secara signifikan.',
      'category': 'Budaya',
      'date': '2023/11/02 16:30:40 UTC',
      'readTime': '2 min baca',
      'imageUrl': 'https://picsum.photos/400/300?random=8',
      'isBookmarked': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final bookmarkedCount = _newsData.where((news) => news['isBookmarked'] == true).length;
    
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        slivers: [
          // Header dengan Search
          SliverToBoxAdapter(
            child: _buildHeader(bookmarkedCount),
          ),
          
          // News List
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return _buildNewsCard(_newsData[index]);
              },
              childCount: _newsData.length,
            ),
          ),
          
          // Bottom Space
          const SliverToBoxAdapter(
            child: SizedBox(height: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(int bookmarkedCount) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 50, 24, 24),
      decoration: BoxDecoration(
        color: const Color(0xFF37353E), // Solid color seperti cuaca
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
          // Title and Menu
          Row(
            children: [
              const Icon(Icons.article, color: Colors.white, size: 20),
              const SizedBox(width: 8),
              const Text(
                'Berita Terkini',
                style: TextStyle(
                  fontSize: 20,
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
          
          // Stats and Icon
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.newspaper, color: Colors.white, size: 48),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${_newsData.length}',
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Total Berita',
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
            height: 45,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Cari berita...',
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

  Widget _buildNewsCard(Map<String, dynamic> news) {
    return Card(
      margin: const EdgeInsets.fromLTRB(20, 8, 20, 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // News Image
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: Image.network(
                news['imageUrl'],
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    height: 180,
                    color: Colors.grey[200],
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 180,
                    color: Colors.grey[200],
                    child: const Icon(
                      Icons.image_not_supported,
                      color: Colors.grey,
                      size: 48,
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
                  // Category and Bookmark
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: _getCategoryColor(news['category']),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          news['category'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: Icon(
                          news['isBookmarked'] ? Icons.bookmark : Icons.bookmark_border,
                          color: news['isBookmarked'] ? Colors.amber : Colors.grey,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // Title
                  Text(
                    news['title'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF37353E),
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // Summary
                  Text(
                    news['summary'],
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // Date and Read Time
                  Row(
                    children: [
                      Icon(Icons.access_time, size: 14, color: Colors.grey[500]),
                      const SizedBox(width: 4),
                      Text(
                        news['readTime'],
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[500],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Icon(Icons.calendar_today, size: 14, color: Colors.grey[500]),
                      const SizedBox(width: 4),
                      Text(
                        _formatDate(news['date']),
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[500],
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Baca Selengkapnya',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
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
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Teknologi':
        return Colors.blue;
      case 'Lingkungan':
        return Colors.green;
      case 'Programming':
        return Colors.purple;
      case 'Olahraga':
        return Colors.orange;
      case 'Bisnis':
        return Colors.indigo;
      case 'Sains':
        return Colors.teal;
      case 'Budaya':
        return Colors.pink;
      default:
        return Colors.grey;
    }
  }

  String _formatDate(String dateString) {
    // Format dari "2023/11/07 14:23:45 UTC" menjadi "2023/11/07"
    return dateString.split(' ')[0];
  }
}