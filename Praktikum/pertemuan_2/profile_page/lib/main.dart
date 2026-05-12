import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ProfilePage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Saya'),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),

      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),

            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {},
            ),

            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Pengaturan'),
              onTap: () {},
            ),

            ListTile(
              leading: const Icon(Icons.widgets),
              title: const Text('Widget Gallery'),
              onTap: () {
                Navigator.pop(context);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const GalleryHome(),
                  ),
                );
              },
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // === HEADER PROFIL ===

            Center(
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.blue,
                    child: Icon(
                      Icons.person,
                      size: 60,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'Ilham Anugrah',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    'Mahasiswa Teknik Informatika',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // === BARIS STATISTIK ===

            Row(
              children: const [
                Expanded(
                  child: _StatBox(
                    label: 'Post',
                    value: '12',
                  ),
                ),

                Expanded(
                  child: _StatBox(
                    label: 'Teman',
                    value: '128',
                  ),
                ),

                Expanded(
                  child: _StatBox(
                    label: 'Like',
                    value: '1.2K',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // === SECTION CARD ===

            const _SectionCard(
              icon: Icons.info_outline,
              title: 'Tentang Saya',
              content:
              'Saya suka belajar hal baru, terutama yang berkaitan '
                  'dengan teknologi dan pengembangan aplikasi mobile.',
            ),

            const _SectionCard(
              icon: Icons.school,
              title: 'Pendidikan',
              content: 'Universitas XYZ - Semester 5\nIPK: 3.75',
            ),

            const _SectionCard(
              icon: Icons.favorite,
              title: 'Hobi & Minat',
              content: 'Coding • Membaca • Fotografi • Game',
            ),

            const _SectionCard(
              icon: Icons.email,
              title: 'Kontak',
              content: 'email@example.com\n+62 812-3456-7890',
            ),

            const SizedBox(height: 80),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.edit),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Pesan',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Setting',
          ),
        ],
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final String label;
  final String value;

  const _StatBox({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 4),

        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}

class _SectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;

  const _SectionCard({
    required this.icon,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),

      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: Colors.blue,
              size: 28,
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    content,
                    style: const TextStyle(height: 1.4),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GalleryHome extends StatelessWidget {
  const GalleryHome({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      ('Display', Icons.image, Colors.blue),
      ('Input', Icons.edit, Colors.green),
      ('Button', Icons.smart_button, Colors.orange),
      ('Feedback', Icons.notifications, Colors.purple),
      ('Layout', Icons.dashboard, Colors.teal),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Widget Gallery'),
      ),

      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: categories.length,

        separatorBuilder: (_, __) =>
        const SizedBox(height: 8),

        itemBuilder: (context, i) {
          final (name, icon, color) = categories[i];

          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: color,
                child: Icon(
                  icon,
                  color: Colors.white,
                ),
              ),

              title: Text(name),

              trailing: const Icon(Icons.chevron_right),

              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CategoryPage(name: name),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class CategoryPage extends StatelessWidget {
  final String name;

  const CategoryPage({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    final body = switch (name) {
      'Display' => const _DisplayDemo(),
      'Input' => const _InputDemo(),
      'Button' => const _ButtonDemo(),
      'Feedback' => const _FeedbackDemo(),
      'Layout' => const _LayoutDemo(),
      _ => const Center(child: Text('?')),
    };

    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: body,
      ),
    );
  }
}

class _DisplayDemo extends StatelessWidget {
  const _DisplayDemo();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Card',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        const Card(
          child: ListTile(
            leading: Icon(Icons.album),
            title: Text('Judul Item'),
            subtitle: Text('Sub-judul'),
          ),
        ),

        const SizedBox(height: 16),

        const Text(
          'Chip',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        Wrap(
          spacing: 8,
          children: const [
            Chip(label: Text('Flutter')),
            Chip(label: Text('Dart')),
            Chip(label: Text('Mobile')),
          ],
        ),

        const SizedBox(height: 16),

        const Text(
          'Divider',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        const Divider(thickness: 2),

        const SizedBox(height: 16),

        const Text(
          'CircleAvatar & Icon',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        Row(
          children: const [
            CircleAvatar(
              child: Text('A'),
            ),

            SizedBox(width: 12),

            CircleAvatar(
              backgroundColor: Colors.green,
              child: Icon(Icons.check),
            ),

            SizedBox(width: 12),

            Icon(
              Icons.star,
              color: Colors.amber,
              size: 40,
            ),
          ],
        ),
      ],
    );
  }
}

class _InputDemo extends StatefulWidget {
  const _InputDemo();

  @override
  State<_InputDemo> createState() =>
      _InputDemoState();
}

class _InputDemoState extends State<_InputDemo> {
  bool _checked = false;
  bool _switched = true;
  double _slider = 0.5;
  String? _dropdown = 'Apel';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('TextField'),

        const SizedBox(height: 4),

        const TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Nama',
            hintText: 'Ketik nama Anda',
          ),
        ),

        const SizedBox(height: 16),

        CheckboxListTile(
          title: const Text('Checkbox'),
          value: _checked,
          onChanged: (v) =>
              setState(() => _checked = v ?? false),
        ),

        SwitchListTile(
          title: const Text('Switch'),
          value: _switched,
          onChanged: (v) =>
              setState(() => _switched = v),
        ),

        const Text('Slider'),

        Slider(
          value: _slider,
          onChanged: (v) =>
              setState(() => _slider = v),
        ),

        const SizedBox(height: 8),

        const Text('Dropdown'),

        DropdownButton<String>(
          value: _dropdown,

          items: ['Apel', 'Jeruk', 'Mangga']
              .map(
                (e) => DropdownMenuItem(
              value: e,
              child: Text(e),
            ),
          )
              .toList(),

          onChanged: (v) =>
              setState(() => _dropdown = v),
        ),
      ],
    );
  }
}

class _ButtonDemo extends StatelessWidget {
  const _ButtonDemo();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Demo Button'),
    );
  }
}

class _FeedbackDemo extends StatelessWidget {
  const _FeedbackDemo();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Demo Feedback'),
    );
  }
}

class _LayoutDemo extends StatelessWidget {
  const _LayoutDemo();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Demo Layout'),
    );
  }
}