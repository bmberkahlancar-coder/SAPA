import 'package:flutter/material.dart';

void main() {
  runApp(const SapaApp());
}

class SapaApp extends StatelessWidget {
  const SapaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SAPA',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() =>
      _HomePageState();
}

class _HomePageState
    extends State<HomePage> {

  int index = 0;

  final pages = const [
    ChatPage(),
    ContactPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        title: const Text('SAPA'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: SapaSearch(),
              );
            },
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(
                SnackBar(
                  content: Text(value),
                ),
              );
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'Profil',
                child: Text('Profil'),
              ),
              const PopupMenuItem(
                value: 'Status',
                child: Text('Status'),
              ),
            ],
          ),
        ],
      ),
      body: pages[index],
      floatingActionButton:
          index == 0
              ? FloatingActionButton(
                  backgroundColor:
                      Colors.green,
                  onPressed: () {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Chat baru akan segera dibuat',
                        ),
                      ),
                    );
                  },
                  child: const Icon(
                    Icons.chat,
                    color: Colors.white,
                  ),
                )
              : null,
      bottomNavigationBar:
          NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (value) {
          setState(() {
            index = value;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.chat_outlined),
            selectedIcon: Icon(Icons.chat),
            label: 'Chat',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_outline),
            selectedIcon: Icon(Icons.people),
            label: 'Kontak',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Pengaturan',
          ),
        ],
      ),
    );
  }
}

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(30),
        child: Text(
          '👋 Selamat datang di SAPA!\n\n'
          'Mulailah percakapan Anda dengan nyaman '
          'dan tetap dekat dengan orang-orang '
          'tersayang. 💚',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Kontak SAPA',
        style: TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Pengaturan SAPA',
        style: TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }
}

class SapaSearch
    extends SearchDelegate<String> {

  @override
  List<Widget>? buildActions(
      BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(
      BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(
      BuildContext context) {
    return Center(
      child: Text(
        'Mencari: $query',
      ),
    );
  }

  @override
  Widget buildSuggestions(
      BuildContext context) {
    return const Center(
      child: Text(
        'Cari percakapan atau kontak',
      ),
    );
  }
}
