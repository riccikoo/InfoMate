import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BiodataFragment extends StatefulWidget {
  const BiodataFragment({super.key});

  @override
  State<BiodataFragment> createState() => _BiodataFragmentState();
}

class _BiodataFragmentState extends State<BiodataFragment> {
  final _formKey = GlobalKey<FormState>();
  
  // Controller untuk text field
  TextEditingController namaController = TextEditingController();
  TextEditingController nimController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController noHpController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController tanggalLahirController = TextEditingController();
  TextEditingController asalSekolahController = TextEditingController();
  
  // Variabel untuk dropdown dan radio
  String? _selectedProdi;
  String? _selectedSemester;
  String? _selectedJenjang;
  String? _jenisKelamin;
  DateTime? _selectedDate;
  
  // List untuk dropdown
  final List<String> _listProdi = [
    'Informatika',
    'Sistem Informasi',
    'Teknik Elektro',
    'Teknik Mesin',
    'Manajemen',
    'Akuntansi'
  ];
  
  final List<String> _listSemester = [
    'Semester 1',
    'Semester 2',
    'Semester 3',
    'Semester 4',
    'Semester 5',
    'Semester 6',
    'Semester 7',
    'Semester 8'
  ];
  
  final List<String> _listJenjang = [
    'S1',
    'S2',
    'S3'
  ];

  @override
  void initState() {
    super.initState();
    _loadBiodata();
  }

  // Method untuk load data dari SharedPreferences
  Future<void> _loadBiodata() async {
    final prefs = await SharedPreferences.getInstance();
    
    setState(() {
      namaController.text = prefs.getString('nama') ?? 'Rico Fadli Alfiansyah';
      nimController.text = prefs.getString('nim') ?? '152023090';
      emailController.text = prefs.getString('email') ?? 'rico.fadli@example.com';
      noHpController.text = prefs.getString('noHp') ?? '+62 857-0385-5451';
      alamatController.text = prefs.getString('alamat') ?? 'Cimahi, Indonesia';
      asalSekolahController.text = prefs.getString('asalSekolah') ?? 'SMKN 1 Cimahi';
      _selectedProdi = prefs.getString('prodi') ?? 'Informatika';
      _selectedSemester = prefs.getString('semester') ?? 'Semester 5';
      _selectedJenjang = prefs.getString('jenjang') ?? 'S1';
      _jenisKelamin = prefs.getString('jenisKelamin') ?? 'Laki-laki';
      
      // Load tanggal lahir
      final savedDate = prefs.getString('tanggalLahir');
      if (savedDate != null) {
        tanggalLahirController.text = savedDate;
      } else {
        _selectedDate = DateTime(2000, 9, 3);
        tanggalLahirController.text = '3 September 2003';
      }
    });
  }

  // Method untuk save data ke SharedPreferences
  Future<void> _saveBiodataToStorage() async {
    final prefs = await SharedPreferences.getInstance();
    
    await prefs.setString('nama', namaController.text);
    await prefs.setString('nim', nimController.text);
    await prefs.setString('email', emailController.text);
    await prefs.setString('noHp', noHpController.text);
    await prefs.setString('alamat', alamatController.text);
    await prefs.setString('asalSekolah', asalSekolahController.text);
    await prefs.setString('prodi', _selectedProdi ?? '');
    await prefs.setString('semester', _selectedSemester ?? '');
    await prefs.setString('jenjang', _selectedJenjang ?? '');
    await prefs.setString('jenisKelamin', _jenisKelamin ?? '');
    await prefs.setString('tanggalLahir', tanggalLahirController.text);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        tanggalLahirController.text = 
          "${picked.day} ${_getMonthName(picked.month)} ${picked.year}";
      });
    }
  }

  String _getMonthName(int month) {
    switch (month) {
      case 1: return 'Januari';
      case 2: return 'Februari';
      case 3: return 'Maret';
      case 4: return 'April';
      case 5: return 'Mei';
      case 6: return 'Juni';
      case 7: return 'Juli';
      case 8: return 'Agustus';
      case 9: return 'September';
      case 10: return 'Oktober';
      case 11: return 'November';
      case 12: return 'Desember';
      default: return '';
    }
  }

  void _saveBiodata() {
    if (_formKey.currentState!.validate()) {
      _saveBiodataToStorage(); // Simpan ke storage
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Biodata berhasil disimpan!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _resetForm() {
    _formKey.currentState!.reset();
    setState(() {
      _selectedProdi = null;
      _selectedSemester = null;
      _selectedJenjang = null;
      _jenisKelamin = null;
      _selectedDate = null;
      tanggalLahirController.clear();
    });
  }

  // Method untuk clear semua data (optional)
  Future<void> _clearAllData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    _resetForm();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD3DAD9),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Header dengan Foto Profil
              _buildProfileHeader(),
              const SizedBox(height: 24),
              
              // Card Form Biodata
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Data Pribadi',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF37353E),
                        ),
                      ),
                      const SizedBox(height: 20),
                      
                      // Nama
                      _buildTextField(
                        controller: namaController,
                        label: 'Nama Lengkap',
                        icon: Icons.person,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Nama lengkap harus diisi';
                          }
                          return null;
                        },
                      ),
                      
                      // NIM
                      _buildTextField(
                        controller: nimController,
                        label: 'NIM',
                        icon: Icons.badge,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'NIM harus diisi';
                          }
                          return null;
                        },
                      ),
                      
                      // Email
                      _buildTextField(
                        controller: emailController,
                        label: 'Email',
                        icon: Icons.email,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email harus diisi';
                          }
                          if (!value.contains('@')) {
                            return 'Format email tidak valid';
                          }
                          return null;
                        },
                      ),
                      
                      // No HP
                      _buildTextField(
                        controller: noHpController,
                        label: 'No. Handphone',
                        icon: Icons.phone,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'No. Handphone harus diisi';
                          }
                          return null;
                        },
                      ),
                      
                      // Tanggal Lahir dengan Date Picker
                      _buildDatePickerField(),
                      
                      // Jenis Kelamin Radio Button
                      _buildGenderRadio(),
                      
                      const SizedBox(height: 10),
                      
                      // Dropdown Jenjang
                      _buildDropdown(
                        value: _selectedJenjang,
                        items: _listJenjang,
                        label: 'Jenjang Pendidikan',
                        icon: Icons.school,
                        onChanged: (value) {
                          setState(() {
                            _selectedJenjang = value;
                          });
                        },
                      ),
                      
                      // Dropdown Program Studi
                      _buildDropdown(
                        value: _selectedProdi,
                        items: _listProdi,
                        label: 'Program Studi',
                        icon: Icons.menu_book,
                        onChanged: (value) {
                          setState(() {
                            _selectedProdi = value;
                          });
                        },
                      ),
                      
                      // Dropdown Semester
                      _buildDropdown(
                        value: _selectedSemester,
                        items: _listSemester,
                        label: 'Semester',
                        icon: Icons.date_range,
                        onChanged: (value) {
                          setState(() {
                            _selectedSemester = value;
                          });
                        },
                      ),
                      
                      // Asal Sekolah
                      _buildTextField(
                        controller: asalSekolahController,
                        label: 'Asal Sekolah',
                        icon: Icons.school_outlined,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Asal sekolah harus diisi';
                          }
                          return null;
                        },
                      ),
                      
                      // Alamat (Text Area)
                      _buildAddressField(),
                      
                      const SizedBox(height: 24),
                      
                      // Tombol Aksi
                      _buildActionButtons(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF37353E),
        borderRadius: BorderRadius.circular(20),
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
          // Foto Profil
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/logo.png', // UBAH INI: tambahkan 'assets/'
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.blueAccent, // Ganti warna background
                        child: const Icon(
                          Icons.person,
                          size: 60,
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
                ),
              ),
              Container(
                width: 36,
                height: 36,
                decoration: const BoxDecoration(
                  color: Color(0xFF715A5A),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.camera_alt, size: 18, color: Colors.white),
                  onPressed: () {
                    // Aksi untuk ganti foto
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            namaController.text.isEmpty ? 'Nama Lengkap' : namaController.text,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            _selectedProdi ?? 'Program Studi',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.star, size: 16, color: Colors.amber[300]),
              const SizedBox(width: 4),
              const Text(
                'Cihuyyy',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  // ... (method _buildTextField, _buildDatePickerField, _buildGenderRadio, 
  // _buildDropdown, _buildAddressField, _buildActionButtons tetap sama)
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.grey[600]),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Colors.grey[50],
        ),
      ),
    );
  }

  Widget _buildDatePickerField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: tanggalLahirController,
        readOnly: true,
        onTap: () => _selectDate(context),
        decoration: InputDecoration(
          labelText: 'Tanggal Lahir',
          prefixIcon: Icon(Icons.calendar_today, color: Colors.grey[600]),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Colors.grey[50],
          suffixIcon: IconButton(
            icon: const Icon(Icons.date_range),
            onPressed: () => _selectDate(context),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Tanggal lahir harus diisi';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildGenderRadio() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Jenis Kelamin',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: RadioListTile<String>(
                  title: const Text('Laki-laki'),
                  value: 'Laki-laki',
                  groupValue: _jenisKelamin,
                  onChanged: (value) {
                    setState(() {
                      _jenisKelamin = value;
                    });
                  },
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              Expanded(
                child: RadioListTile<String>(
                  title: const Text('Perempuan'),
                  value: 'Perempuan',
                  groupValue: _jenisKelamin,
                  onChanged: (value) {
                    setState(() {
                      _jenisKelamin = value;
                    });
                  },
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown({
    required String? value,
    required List<String> items,
    required String label,
    required IconData icon,
    required Function(String?) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[400]!),
              color: Colors.grey[50],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: DropdownButtonFormField<String>(
                value: value,
                icon: Icon(Icons.arrow_drop_down, color: Colors.grey[600]),
                iconSize: 24,
                elevation: 16,
                isExpanded: true,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(icon, color: Colors.grey[600]),
                ),
                items: items.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: onChanged,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '$label harus dipilih';
                  }
                  return null;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Alamat Lengkap',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: alamatController,
            maxLines: 3,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Alamat lengkap harus diisi';
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: 'Tulis alamat lengkap Anda...',
              prefixIcon: Icon(Icons.home, color: Colors.grey[600]),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.grey[50],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            icon: const Icon(Icons.refresh),
            label: const Text('Reset'),
            onPressed: _resetForm,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[300],
              foregroundColor: Colors.black87,
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
            icon: const Icon(Icons.save),
            label: const Text('Simpan'),
            onPressed: _saveBiodata,
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
    );
  }
}