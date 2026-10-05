import 'dart:io';

// Variabel Global
List<String> waitingList = [];
Map<String, String?> pos = {
  'POS 1': null,
  'POS 2': null,
  'POS 3': null,
};

void main() {
  bool jalan = true;

  while (jalan) {
    tampilMenu();
  }
}

void tampilMenu() {
  print("\n=== SISTEM ANTRIAN CUCIAN KENDARAAN ===");
  print("1. Tambah Antrian (Masuk Waiting List)");
  print("2. Lihat Waiting List");
  print("3. Lihat POS");
  print("4. Masukkan dari Waiting List ke POS / Selesaikan POS");
  print("5. Keluar");
  stdout.write("Pilihan menu (1-5): ");

  String? pilihan = stdin.readLineSync();

  switch (pilihan) {
    case '1':
      tambahAntrian();
      break;
    case '2':
      lihatWaitingList();
      break;
    case '3':
      lihatPos();
      break;
    case '4':
      kelolaPos();
      break;
    case '5':
      print("Terima kasih telah menggunakan sistem antrian.");
      exit(0);
    default:
      print("Pilihan tidak valid, silakan coba lagi.");
  }
}

// 1. Tambah Antrian (Langsung ke Waiting List)
void tambahAntrian() {
  stdout.write("Masukkan Plat Nomor Kendaraan: ");
  String? plat = stdin.readLineSync();

  if (plat == null || plat.trim().isEmpty) {
    print("Plat nomor tidak boleh kosong!");
    return;
  }

  // Kendaraan selalu masuk ke waitingList terlebih dahulu
  waitingList.add(plat.trim());
  print("Berhasil! Kendaraan ($plat) telah dimasukkan ke Waiting List.");
}

// 2. Lihat Waiting List
void lihatWaitingList() {
  print("\n--- DAFTAR WAITING LIST ---");
  if (waitingList.isEmpty) {
    print("Waiting List kosong.");
  } else {
    for (int i = 0; i < waitingList.length; i++) {
      print("${i + 1}. Plat: ${waitingList[i]}");
    }
  }
}

// 3. Lihat POS
void lihatPos() {
  print("\n--- STATUS POS CUCIAN ---");
  pos.forEach((key, value) {
    print("$key : ${value ?? 'kosong'}");
  });
}

// 4. Kelola POS (Pengisian & Penyelesaian)
void kelolaPos() {
  print("\n--- KELOLA POS CUCIAN ---");
  print("1. Pindahkan Antrian Terdepan ke POS Kosong");
  print("2. Selesaikan Pencucian di POS");
  stdout.write("Pilihan (1-2): ");
  
  String? opsi = stdin.readLineSync();

  if (opsi == '1') {
    // Memindahkan dari Waiting List ke POS Kosong
    if (waitingList.isEmpty) {
      print("Tidak dapat memproses: Waiting List sedang kosong!");
      return;
    }

    // Cari POS yang masih kosong
    String? posKosong;
    for (var key in pos.keys) {
      if (pos[key] == null) {
        posKosong = key;
        break;
      }
    }

    if (posKosong != null) {
      String kendaraan = waitingList.removeAt(0); // Ambil antrian pertama (index 0)
      pos[posKosong] = kendaraan;
      print("Kendaraan ($kendaraan) berhasil dipindahkan dari Waiting List ke $posKosong.");
    } else {
      print("Semua POS saat ini penuh! Selesaikan dulu POS yang sedang aktif.");
    }

  } else if (opsi == '2') {
    // Selesaikan POS
    print("\nPilih POS yang selesai dicuci:");
    List<String> keys = pos.keys.toList();
    for (int i = 0; i < keys.length; i++) {
      print("${i + 1}. ${keys[i]} (${pos[keys[i]] ?? 'kosong'})");
    }

    stdout.write("Pilihan POS (1-${keys.length}): ");
    String? pil = stdin.readLineSync();
    int? index = int.tryParse(pil ?? '');

    if (index != null && index >= 1 && index <= keys.length) {
      String selectedPos = keys[index - 1];

      if (pos[selectedPos] == null) {
        print("$selectedPos memang sedang kosong!");
        return;
      }

      print("Pencucian kendaraan (${pos[selectedPos]}) di $selectedPos telah SELESAI.");
      pos[selectedPos] = null; // Mengosongkan POS

      // Otomatis tarik dari Waiting List jika ada
      if (waitingList.isNotEmpty) {
        String selanjutnya = waitingList.removeAt(0);
        pos[selectedPos] = selanjutnya;
        print("Kendaraan ($selanjutnya) dari Waiting List langsung masuk mengisi $selectedPos.");
      }
    } else {
      print("Pilihan POS tidak valid.");
    }
  } else {
    print("Pilihan tidak valid.");
  }
}