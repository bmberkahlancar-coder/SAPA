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
      home: const WelcomePage(),
    );
  }
}

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  void lanjut(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const PhonePage(),
      ),
    );
  }
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              const Spacer(),
              const Icon(
                Icons.chat,
                size: 100,
                color: Colors.green,
              ),
              const SizedBox(height: 30),
              const Text(
                'Selamat datang di SAPA',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Tetap terhubung dengan orang-orang tersayang.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17),
              ),
              const Spacer(),
                            const Text(
                'Dengan melanjutkan, Anda menyetujui '
                'Ketentuan dan Kebijakan Privasi SAPA.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => lanjut(context),
                  child: const Text(
                    'SETUJU DAN LANJUTKAN',
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
class PhonePage extends StatefulWidget {
  const PhonePage({super.key});

  @override
  State<PhonePage> createState() =>
      _PhonePageState();
}

class _PhonePageState
    extends State<PhonePage> {
  final nomor =
      TextEditingController();

  void lanjut() {
    final hp = nomor.text.trim();

    if (hp.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'Masukkan nomor HP',
          ),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            OtpPage(nomor: hp),
      ),
    );
  }
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar dengan nomor HP'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Text(
              'Masukkan nomor telepon Anda untuk melanjutkan.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 17),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: nomor,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                prefixText: '+62 ',
                labelText: 'Nomor HP',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: lanjut,
                child: const Text('LANJUT'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class OtpPage extends StatefulWidget {
  final String nomor;

  const OtpPage({
    super.key,
    required this.nomor,
  });

  @override
  State<OtpPage> createState() =>
      _OtpPageState();
}

class _OtpPageState
    extends State<OtpPage> {
  final kode =
      TextEditingController();

  void verifikasi() {
    if (kode.text.trim().length < 4) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'Masukkan kode verifikasi',
          ),
        ),
      );
      return;
    }

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => const HomePage(),
      ),
      (route) => false,
    );
  }
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verifikasi Nomor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Text(
              'Masukkan kode verifikasi yang dikirim ke nomor Anda.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 17),
            ),
            const SizedBox(height: 10),
            Text(
              '+62 ${widget.nomor}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: kode,
              keyboardType: TextInputType.number,
              maxLength: 6,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                labelText: 'Kode Verifikasi',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
                        SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: verifikasi,
                child: const Text(
                  'VERIFIKASI',
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Kode verifikasi akan dikirim melalui layanan SAPA.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;

  final List<String> chats = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SAPA'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: buildPage(),
      floatingActionButton: FloatingActionButton(
        onPressed: tambahChat,
        child: const Icon(Icons.chat),
      ),
      bottomNavigationBar: NavigationBar(
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

  Widget buildPage() {
    if (index == 0) {
      return buildChatPage();
    }

    if (index == 1) {
      return const Center(
        child: Text('Kontak'),
      );
    }

    return const Center(
      child: Text('Pengaturan'),
    );
  }
    Widget buildChatPage() {
    if (chats.isEmpty) {
      return const Center(
        child: Text(
          'Belum ada percakapan.\nTekan tombol chat untuk memulai.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: chats.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const CircleAvatar(
            child: Icon(Icons.person),
          ),
          title: Text(chats[index]),
          subtitle: const Text(
            'Mulai percakapan...',
          ),
          trailing: const Icon(
            Icons.chevron_right,
          ),
        );
      },
    );
  }

  void tambahChat() {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Chat Baru'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: 'Nama teman',
              hintText: 'Masukkan nama',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('BATAL'),
            ),
            ElevatedButton(
              onPressed: () {
                final nama = controller.text.trim();

                if (nama.isEmpty) {
                  return;
                }

                setState(() {
                  chats.add(nama);
                });

                Navigator.pop(context);
              },
              child: const Text('BUAT CHAT'),
            ),
          ],
        );
      },
    );
  }
}
