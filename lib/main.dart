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
        useMaterial3: true,
        colorSchemeSeed: Colors.green,
      ),
      home: const HomePage(),
    );
  }
}

class ChatItem {
  String name;
  String message;
  ChatItem(this.name, this.message);
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  final List<ChatItem> chats = [];
  int index = 0;

  void tambahChat() {
    final c = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Chat Baru'),
        content: TextField(
          controller: c,
          decoration: const InputDecoration(
            labelText: 'Nama teman',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('BATAL'),
          ),
          ElevatedButton(
            onPressed: () {
              if (c.text.trim().isEmpty) return;
              setState(() {
                chats.add(ChatItem(
                  c.text.trim(),
                  'Mulai percakapan...',
                ));
              });
              Navigator.pop(context);
            },
            child: const Text('BUAT'),
          ),
        ],
      ),
    );
  }
    Widget halamanChat() {
    if (chats.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Text(
            '👋 Selamat datang di SAPA!\n\n'
            'Mulailah percakapan Anda dengan nyaman '
            'dan tetap dekat dengan orang-orang tersayang. 💚',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: chats.length,
      itemBuilder: (context, i) {
        final chat = chats[i];

        return ListTile(
          leading: const CircleAvatar(
            child: Icon(Icons.person),
          ),
          title: Text(chat.name),
          subtitle: Text(chat.message),
          trailing: const Icon(Icons.arrow_forward),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ChatPage(chat: chat),
              ),
            );
          },
        );
      },
    );
    }
    Widget halamanKontak() {
    return const Center(
      child: Text(
        'Kontak SAPA',
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  Widget halamanPengaturan() {
    return ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text('Profil'),
          subtitle: const Text('Pengaturan profil SAPA'),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Profil akan segera tersedia'),
              ),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.smart_toy),
          title: const Text('SAPA AI'),
          subtitle: const Text('Asisten percakapan SAPA'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const AiPage(),
              ),
            );
          },
        ),
      ],
    );
  }
    @override
  Widget build(BuildContext context) {
    final pages = [
      halamanChat(),
      halamanKontak(),
      halamanPengaturan(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('SAPA'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Pencarian akan segera tersedia'),
                ),
              );
            },
          ),
        ],
      ),
      body: pages[index],
      floatingActionButton: index == 0
          ? FloatingActionButton(
              onPressed: tambahChat,
              child: const Icon(Icons.chat),
            )
          : null,
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (value) {
          setState(() => index = value);
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

class ChatPage extends StatefulWidget {
  final ChatItem chat;

  const ChatPage({
    super.key,
    required this.chat,
  });

  @override
  State<ChatPage> createState() =>
      _ChatPageState();
}
class _ChatPageState extends State<ChatPage> {
  final TextEditingController pesan =
      TextEditingController();

  final List<String> messages = [];

  void kirimPesan() {
    final text = pesan.text.trim();

    if (text.isEmpty) return;

    setState(() {
      messages.add(text);
    });

    pesan.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chat.name),
      ),
      body: Column(
        children: [
          Expanded(
            child: messages.isEmpty
                ? const Center(
                    child: Text(
                      'Mulai percakapan 💚',
                    ),
                  )
                : ListView.builder(
                    padding:
                        const EdgeInsets.all(12),
                    itemCount: messages.length,
                    itemBuilder: (_, i) {
                      return Align(
                        alignment:
                            Alignment.centerRight,
                        child: Card(
                          child: Padding(
                            padding:
                                const EdgeInsets.all(12),
                            child: Text(messages[i]),
                          ),
                        ),
                      );
                    },
                  ),
          ),
                    SafeArea(
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.all(8),
                    child: TextField(
                      controller: pesan,
                      onSubmitted: (_) {
                        kirimPesan();
                      },
                      decoration:
                          const InputDecoration(
                        hintText:
                            'Tulis pesan...',
                        border:
                            OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.send,
                  ),
                  onPressed: kirimPesan,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class AiPage extends StatefulWidget {
  const AiPage({super.key});

  @override
  State<AiPage> createState() => _AiPageState();
}

class _AiPageState extends State<AiPage> {
  final TextEditingController pesan =
      TextEditingController();

  final List<String> messages = [
    'Halo! Saya SAPA AI 💚 Ada yang bisa saya bantu?',
  ];

  void kirimPesan() {
    final text = pesan.text.trim();

    if (text.isEmpty) return;

    setState(() {
      messages.add('Saya: $text');
      messages.add(
        'SAPA AI: Terima kasih. Saya menerima pesan Anda 💚',
      );
    });

    pesan.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SAPA AI'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: messages.length,
              itemBuilder: (_, i) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(messages[i]),
                );
              },
            ),
          ),
                    SafeArea(
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextField(
                      controller: pesan,
                      onSubmitted: (_) {
                        kirimPesan();
                      },
                      decoration: const InputDecoration(
                        hintText: 'Tulis pesan ke SAPA AI...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: kirimPesan,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
