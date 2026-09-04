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
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
        ),
      ),
      home: const HomePage(),
    );
  }
}

class UserProfile {
  String name;
  String status;
  String avatar;

  UserProfile({
    this.name = 'Pengguna SAPA',
    this.status = 'Halo! Saya menggunakan SAPA 💚',
    this.avatar = '😊',
  });
}

class ChatItem {
  String name;
  String message;
  String time;
  String avatar;
  List<String> messages;

  ChatItem({
    required this.name,
    required this.message,
    required this.time,
    required this.avatar,
    required this.messages,
  });
}

class StatusItem {
  String name;
  String text;
  String time;
  String avatar;

  StatusItem({
    required this.name,
    required this.text,
    required this.time,
    required this.avatar,
  });
}

class ContactItem {
  String name;
  String phone;
  String avatar;

  ContactItem({
    required this.name,
    required this.phone,
    required this.avatar,
  });
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

  final UserProfile user =
      UserProfile();

  final List<ChatItem> chats = [];

  final List<StatusItem> statuses = [];

  final List<ContactItem> contacts = [];

  bool notificationEnabled = true;
  bool darkMode = false;

  @override
  Widget build(BuildContext context) {
    final pages = [
      buildChatPage(),
      buildContactPage(),
      buildSettingsPage(),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        title: const Text(
          'SAPA',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
            ),
            onPressed: openSearch,
          ),
          PopupMenuButton<String>(
            onSelected: handleMenu,
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'profile',
                child: Text('Profil'),
              ),
              const PopupMenuItem(
                value: 'status',
                child: Text('Status'),
              ),
              const PopupMenuItem(
                value: 'ai',
                child: Text('SAPA AI'),
              ),
            ],
          ),
        ],
      ),
      body: pages[index],
      floatingActionButton:
          buildFloatingButton(),
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
            icon: Icon(
              Icons.chat_outlined,
            ),
            selectedIcon: Icon(
              Icons.chat,
            ),
            label: 'Chat',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.people_outline,
            ),
            selectedIcon: Icon(
              Icons.people,
            ),
            label: 'Kontak',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.settings_outlined,
            ),
            selectedIcon: Icon(
              Icons.settings,
            ),
            label: 'Pengaturan',
          ),
        ],
      ),
    );
  }

  Widget? buildFloatingButton() {
    if (index == 0) {
      return FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: createNewChat,
        child: const Icon(
          Icons.chat,
          color: Colors.white,
        ),
      );
    }

    if (index == 1) {
      return FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: addContact,
        child: const Icon(
          Icons.person_add,
          color: Colors.white,
        ),
      );
    }

    return null;
  }

  Widget buildChatPage() {
    if (chats.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.chat_bubble_outline,
                size: 80,
                color: Colors.green,
              ),
              const SizedBox(height: 20),
              const Text(
                '👋 Selamat datang di SAPA!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Mulailah percakapan Anda dengan nyaman dan tetap dekat dengan orang-orang tersayang. 💚',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: createNewChat,
                icon: const Icon(
                  Icons.chat,
                ),
                label: const Text(
                  'Mulai Chat',
                ),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: openAiChat,
                icon: const Icon(
                  Icons.smart_toy,
                ),
                label: const Text(
                  'Chat dengan SAPA AI',
                ),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: chats.length,
      itemBuilder: (context, i) {
        final chat = chats[i];

        return ListTile(
          leading: CircleAvatar(
            backgroundColor:
                Colors.green.shade100,
            child: Text(
              chat.avatar,
              style: const TextStyle(
                fontSize: 24,
              ),
            ),
          ),
          title: Text(
            chat.name,
            style: const TextStyle(
              fontWeight:
                  FontWeight.bold,
            ),
          ),
          subtitle: Text(
            chat.message,
            maxLines: 1,
            overflow:
                TextOverflow.ellipsis,
          ),
          trailing: Text(
            chat.time,
          ),
          onTap: () {
            openChat(chat);
          },
        );
      },
    );
  }

  Widget buildContactPage() {
    if (contacts.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.people_outline,
              size: 80,
              color: Colors.green,
            ),
            const SizedBox(height: 20),
            const Text(
              'Belum ada kontak',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Tambahkan kontak untuk mulai berkomunikasi.',
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: addContact,
              child: const Text(
                'Tambah Kontak',
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: contacts.length,
      itemBuilder: (context, i) {
        final contact = contacts[i];

        return ListTile(
          leading: CircleAvatar(
            backgroundColor:
                Colors.green.shade100,
            child: Text(
              contact.avatar,
              style: const TextStyle(
                fontSize: 24,
              ),
            ),
          ),
          title: Text(
            contact.name,
          ),
          subtitle: Text(
            contact.phone,
          ),
          trailing: const Icon(
            Icons.chat,
            color: Colors.green,
          ),
          onTap: () {
            createChatFromContact(
              contact,
            );
          },
        );
      },
    );
  }

  Widget buildSettingsPage() {
    return ListView(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundColor:
                Colors.green.shade100,
            child: Text(
              user.avatar,
              style: const TextStyle(
                fontSize: 25,
              ),
            ),
          ),
          title: Text(
            user.name,
            style: const TextStyle(
              fontWeight:
                  FontWeight.bold,
            ),
          ),
          subtitle: Text(
            user.status,
          ),
          trailing: const Icon(
            Icons.edit,
          ),
          onTap: openProfile,
        ),
        const Divider(),

        SwitchListTile(
          secondary: const Icon(
            Icons.notifications,
          ),
          title: const Text(
            'Notifikasi',
          ),
          value: notificationEnabled,
          onChanged: (value) {
            setState(() {
              notificationEnabled =
                  value;
            });
          },
        ),

        SwitchListTile(
          secondary: const Icon(
            Icons.dark_mode,
          ),
          title: const Text(
            'Mode Gelap',
          ),
          value: darkMode,
          onChanged: (value) {
            setState(() {
              darkMode = value;
            });

            ScaffoldMessenger.of(
              context,
            ).showSnackBar(
              const SnackBar(
                content: Text(
                  'Pengaturan mode tampilan disimpan.',
                ),
              ),
            );
          },
        ),

        ListTile(
          leading: const Icon(
            Icons.person,
          ),
          title: const Text(
            'Profil',
          ),
          subtitle: const Text(
            'Ubah nama, foto dan info',
          ),
          onTap: openProfile,
        ),

        ListTile(
          leading: const Icon(
            Icons.circle_outlined,
          ),
          title: const Text(
            'Status',
          ),
          subtitle: const Text(
            'Bagikan status Anda',
          ),
          onTap: openStatusPage,
        ),

        ListTile(
          leading: const Icon(
            Icons.smart_toy,
          ),
          title: const Text(
            'SAPA AI',
          ),
          subtitle: const Text(
            'Asisten percakapan SAPA',
          ),
          onTap: openAiChat,
        ),

        ListTile(
          leading: const Icon(
            Icons.info_outline,
          ),
          title: const Text(
            'Tentang SAPA',
          ),
          onTap: () {
            showAboutDialog(
              context: context,
              applicationName: 'SAPA',
              applicationVersion:
                  'Versi 1.0',
              children: const [
                Text(
                  'SAPA adalah aplikasi percakapan sederhana untuk tetap dekat dengan orang-orang tersayang.',
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  void handleMenu(String value) {
    if (value == 'profile') {
      openProfile();
    }

    if (value == 'status') {
      openStatusPage();
    }

    if (value == 'ai') {
      openAiChat();
    }
  }

  void createNewChat() {
    final controller =
        TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Chat Baru',
          ),
          content: TextField(
            controller: controller,
            decoration:
                const InputDecoration(
              labelText:
                  'Nama teman',
              hintText:
                  'Masukkan nama',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'BATAL',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final name =
                    controller.text.trim();

                if (name.isEmpty) {
                  return;
                }

                final chat = ChatItem(
                  name: name,
                  message:
                      'Mulai percakapan...',
                  time: 'Sekarang',
                  avatar: '🙂',
                  messages: [],
                );

                setState(() {
                  chats.add(chat);
                });

                Navigator.pop(context);

                openChat(chat);
              },
              child: const Text(
                'BUAT CHAT',
              ),
            ),
          ],
        );
      },
    );
  }

  void addContact() {
    final nameController =
        TextEditingController();

    final phoneController =
        TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Tambah Kontak',
          ),
          content: Column(
            mainAxisSize:
                MainAxisSize.min,
            children: [
              TextField(
                controller:
                    nameController,
                decoration:
                    const InputDecoration(
                  labelText: 'Nama',
                ),
              ),
              TextField(
                controller:
                    phoneController,
                keyboardType:
                    TextInputType.phone,
                decoration:
                    const InputDecoration(
                  labelText:
                      'Nomor Telepon',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'BATAL',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final name =
                    nameController.text.trim();

                final phone =
                    phoneController.text.trim();

                if (name.isEmpty) {
                  return;
                }

                setState(() {
                  contacts.add(
                    ContactItem(
                      name: name,
                      phone: phone.isEmpty
                          ? '-'
                          : phone,
                      avatar: '🙂',
                    ),
                  );
                });

                Navigator.pop(context);
              },
              child: const Text(
                'SIMPAN',
              ),
            ),
          ],
        );
      },
    );
  }

  void createChatFromContact(
      ContactItem contact) {
    final existing = chats.where(
      (chat) =>
          chat.name == contact.name,
    );

    if (existing.isNotEmpty) {
      openChat(existing.first);
      return;
    }

    final chat = ChatItem(
      name: contact.name,
      message:
          'Mulai percakapan...',
      time: 'Sekarang',
      avatar: contact.avatar,
      messages: [],
    );

    setState(() {
      chats.add(chat);
    });

    openChat(chat);
  }

  void openChat(ChatItem chat) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ChatScreen(
          chat: chat,
          onUpdate: () {
            setState(() {});
          },
        ),
      ),
    );
  }

  void openProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ProfilePage(
          user: user,
          onSave: () {
            setState(() {});
          },
        ),
      ),
    );
  }

  void openStatusPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            StatusPage(
          user: user,
          statuses: statuses,
          onUpdate: () {
            setState(() {});
          },
        ),
      ),
    );
  }

  void openAiChat() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            const AiChatPage(),
      ),
    );
  }

  void openSearch() {
    showSearch(
      context: context,
      delegate: SapaSearch(
        chats: chats,
        contacts: contacts,
        onOpenChat: openChat,
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  final ChatItem chat;
  final VoidCallback onUpdate;

  const ChatScreen({
    super.key,
    required this.chat,
    required this.onUpdate,
  });

  @override
  State<ChatScreen> createState() =>
      _ChatScreenState();
}

class _ChatScreenState
    extends State<ChatScreen> {

  final TextEditingController
      messageController =
      TextEditingController();

  void sendMessage() {
    final text =
        messageController.text.trim();

    if (text.isEmpty) {
      return;
    }

    setState(() {
      widget.chat.messages.add(
        'Saya: $text',
      );

      widget.chat.message = text;
      widget.chat.time = 'Sekarang';
    });

    messageController.clear();

    widget.onUpdate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        title: Row(
          children: [
            CircleAvatar(
              child: Text(
                widget.chat.avatar,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              widget.chat.name,
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: widget
                    .chat.messages.isEmpty
                ? const Center(
                    child: Text(
                      'Mulai percakapan 💚',
                    ),
                  )
                : ListView.builder(
                    padding:
                        const EdgeInsets.all(
                            12),
                    itemCount: widget
                        .chat.messages
                        .length,
                    itemBuilder:
                        (context, i) {
                      final message =
                          widget.chat
                              .messages[i];

                      return Align(
                        alignment:
                            Alignment
                                .centerRight,
                        child: Container(
                          margin:
                              const EdgeInsets
                                  .only(
                            bottom: 8,
                          ),
                          padding:
                              const EdgeInsets
                                  .all(12),
                          decoration:
                              BoxDecoration(
                            color: Colors
                      class ProfilePage
