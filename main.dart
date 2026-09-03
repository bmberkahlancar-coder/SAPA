import 'package:flutter/material.dart';

void main() => runApp(const SapaApp());

class SapaApp extends StatelessWidget {
  const SapaApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SAPA',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0FA37F)),
        useMaterial3: true,
      ),
      home: const SplashPage(),
    );
  }
}

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  @override
  State<SplashPage> createState() => _SplashPageState();
}
class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginPage()));
    });
  }
  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const CircleAvatar(radius: 52, backgroundColor: Color(0xFF0FA37F), child: Icon(Icons.chat_bubble_rounded, color: Colors.white, size: 52)),
      const SizedBox(height: 18),
      Text('SAPA', style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold, color: const Color(0xFF087A60))),
      const SizedBox(height: 8),
      const Text('Dekatkan Setiap Percakapan'),
      const SizedBox(height: 28),
      const CircularProgressIndicator(),
    ])),
  );
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    final phone = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: const Text('Masuk ke SAPA')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          const SizedBox(height: 40),
          const Icon(Icons.chat_rounded, size: 72, color: Color(0xFF0FA37F)),
          const SizedBox(height: 20),
          const Text('Selamat datang di SAPA', textAlign: TextAlign.center, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Masukkan nomor HP untuk melanjutkan.', textAlign: TextAlign.center),
          const SizedBox(height: 32),
          TextField(controller: phone, keyboardType: TextInputType.phone, decoration: const InputDecoration(labelText: 'Nomor HP', prefixIcon: Icon(Icons.phone), border: OutlineInputBorder())),
          const SizedBox(height: 16),
          FilledButton(onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomePage())), child: const Padding(padding: EdgeInsets.all(14), child: Text('LANJUT'))),
          TextButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterPage())), child: const Text('Belum punya akun? Daftar')),
        ]),
      ),
    );
  }
}

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Daftar SAPA')),
    body: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        const SizedBox(height: 24),
        const TextField(decoration: InputDecoration(labelText: 'Nama', prefixIcon: Icon(Icons.person), border: OutlineInputBorder())),
        const SizedBox(height: 16),
        const TextField(keyboardType: TextInputType.phone, decoration: InputDecoration(labelText: 'Nomor HP', prefixIcon: Icon(Icons.phone), border: OutlineInputBorder())),
        const SizedBox(height: 16),
        FilledButton(onPressed: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const HomePage()), (_) => false), child: const Padding(padding: EdgeInsets.all(14), child: Text('BUAT AKUN'))),
      ]),
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  int index = 0;
  final pages = const [ChatsPage(), ContactsPage(), ProfilePage()];
  final titles = ['SAPA', 'Kontak', 'Profil'];
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(titles[index]), backgroundColor: const Color(0xFF0FA37F), foregroundColor: Colors.white),
    body: pages[index],
    bottomNavigationBar: NavigationBar(
      selectedIndex: index,
      onDestinationSelected: (v) => setState(() => index = v),
      destinations: const [
        NavigationDestination(icon: Icon(Icons.chat_bubble_outline), selectedIcon: Icon(Icons.chat_bubble), label: 'Chat'),
        NavigationDestination(icon: Icon(Icons.people_outline), selectedIcon: Icon(Icons.people), label: 'Kontak'),
        NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profil'),
      ],
    ),
  );
}

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});
  @override
  Widget build(BuildContext context) {
    final names = ['Yanto', 'Yanti', 'Sahabat SAPA'];
    return ListView.separated(
      itemCount: names.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (_, i) => ListTile(
        leading: CircleAvatar(child: Text(names[i][0])),
        title: Text(names[i]),
        subtitle: Text(i == 0 ? 'Halo, apa kabar?' : i == 1 ? 'Sudah makan?' : 'Selamat datang di SAPA'),
        trailing: const Text('10:30'),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChatPage(name: names[i]))),
      ),
    );
  }
}

class ChatPage extends StatefulWidget {
  final String name;
  const ChatPage({super.key, required this.name});
  @override
  State<ChatPage> createState() => _ChatPageState();
}
class _ChatPageState extends State<ChatPage> {
  final controller = TextEditingController();
  final messages = <String>['Halo! Selamat datang di SAPA 👋'];
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(widget.name), backgroundColor: const Color(0xFF0FA37F), foregroundColor: Colors.white),
    body: Column(children: [
      Expanded(child: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: messages.length,
        itemBuilder: (_, i) => Align(
          alignment: i == 0 ? Alignment.centerLeft : Alignment.centerRight,
          child: Card(child: Padding(padding: const EdgeInsets.all(12), child: Text(messages[i]))),
        ),
      )),
      SafeArea(child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(children: [
          Expanded(child: TextField(controller: controller, decoration: const InputDecoration(hintText: 'Tulis pesan...', border: OutlineInputBorder()))),
          IconButton(icon: const Icon(Icons.send, color: Color(0xFF0FA37F)), onPressed: () {
            final text = controller.text.trim();
            if (text.isNotEmpty) setState(() { messages.add(text); controller.clear(); });
          }),
        ]),
      )),
    ]),
  );
}

class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});
  @override
  Widget build(BuildContext context) => ListView(
    children: const [
      ListTile(leading: CircleAvatar(child: Icon(Icons.person)), title: Text('Yanto'), subtitle: Text('Online')),
      ListTile(leading: CircleAvatar(child: Icon(Icons.person)), title: Text('Yanti'), subtitle: Text('Terakhir dilihat baru saja')),
      ListTile(leading: CircleAvatar(child: Icon(Icons.person)), title: Text('Budi'), subtitle: Text('Online')),
    ],
  );
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(20),
    children: [
      const Center(child: CircleAvatar(radius: 48, child: Icon(Icons.person, size: 48))),
      const SizedBox(height: 12),
      const Center(child: Text('Pengguna SAPA', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))),
      const SizedBox(height: 24),
      const ListTile(leading: Icon(Icons.person), title: Text('Edit Profil')),
      const ListTile(leading: Icon(Icons.lock_outline), title: Text('Privasi')),
      const ListTile(leading: Icon(Icons.notifications_outlined), title: Text('Notifikasi')),
      ListTile(leading: const Icon(Icons.logout), title: const Text('Keluar'), onTap: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const LoginPage()), (_) => false)),
    ],
  );
}