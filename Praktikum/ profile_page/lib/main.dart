import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // --- 1. Slot AppBar ---
      appBar: AppBar(
        title: const Text('Profil Saya'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          )
        ],
      ),

      // --- 2. Slot Drawer ---
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Menu Navigasi',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.widgets),
              title: Text('Widget Gallery'),
            ),
          ],
        ),
      ),

      // --- 3. Slot Body (Bisa di-scroll) ---
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Foto Profil menggunakan CircleAvatar
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blueAccent,
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 16),

            // Identitas
            const Text(
              'M. Riyyadu Solihin',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Mahasiswa TI - 233040027',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 24),

            // Bagian Section menggunakan Card
            _buildSectionCard('Tentang Saya', 'Seorang mahasiswa Teknik Informatika yang tertarik mempelajari pengembangan perangkat lunak dan teknologi masa depan.'),
            _buildSectionCard('Pendidikan', 'Universitas Pasundan'),
            _buildSectionCard('Hobi & Minat', 'Pemrograman, Elektronika (Arduino), Pengembangan Game (Unity), dan Teknologi AI.'),
            _buildSectionCard('Kontak', 'Email: riyyadu@example.com\nTelepon: 0812-XXXX-XXXX'),
          ],
        ),
      ),

      // --- 4. Slot FloatingActionButton ---
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.edit),
      ),

      // --- 5. Slot BottomNavigationBar ---
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Gallery',
          ),
        ],
      ),
    );
  }

  // Fungsi bantuan (helper) untuk membuat Card agar kode lebih rapi
  Widget _buildSectionCard(String title, String content) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              content,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}