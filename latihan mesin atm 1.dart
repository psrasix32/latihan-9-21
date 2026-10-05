import 'dart:io';

void main() {
  const String pinBenar = "12345";
  int saldo = 2000000;
  bool loginBerhasil = false;

  // --- LOGIKA INPUT PIN ---
  while (!loginBerhasil) {
    print("==========================================");
    print("BANK SERBA ADA");
    print("==========================================");
    stdout.write("Masukan Pin Anda : ");
    String? pinInput = stdin.readLineSync();

    if (pinInput == pinBenar) {
      print("Selamat Datang");
      loginBerhasil = true;
    } else {
      print("Pin Anda Salah");
    }
  }

  // --- LOGIKA MENU UTAMA ---
  while (true) {
    print("==========================================");
    print("BANK SERBA ADA");
    print("==========================================");
    print("1. Cek Saldo");
    print("2. Setor Tunai");
    print("3. Tarik Tunai");
    print("==========================================");
    stdout.write("Pilih Menu (1/2/3) :");
    String? pilihan = stdin.readLineSync();

    if (pilihan == '1') {
      print("==========================================");
      print(" SALDO SAAT INI :");
      print("==========================================");
      print("$saldo");
    } else if (pilihan == '2') {
      stdout.write("Jumlah yang disetor : ");
      String? inputSetor = stdin.readLineSync();
      int jumlahSetor = int.tryParse(inputSetor ?? '') ?? 0;

      if (jumlahSetor > 0) {
        saldo += jumlahSetor;
      } else {
        print("Jumlah setor tidak valid.");
      }
    } else if (pilihan == '3') {
      stdout.write("Jumlah yang ditarik : ");
      String? inputTarik = stdin.readLineSync();
      int jumlahTarik = int.tryParse(inputTarik ?? '') ?? 0;

      if (jumlahTarik <= 0) {
        print("Jumlah penarikan tidak valid.");
        continue;
      }

      if (jumlahTarik > saldo) {
        print("Saldo tidak mencukupi!");
        continue;
      }

      print("==========================================");
      print("Pilih pecahan :");
      print("1. pecahan 50.000");
      print("2. pecahan 100.000 :");
      print("==========================================");
      stdout.write("Pilih pecahan (1/2) : ");
      String? pilihanPecahan = stdin.readLineSync();

      int nilaiPecahan = 0;
      if (pilihanPecahan == '1') {
        nilaiPecahan = 50000;
      } else if (pilihanPecahan == '2') {
        nilaiPecahan = 100000;
      }

      if (nilaiPecahan > 0) {
        if (jumlahTarik % nilaiPecahan != 0) {
          print("Jumlah tarik tidak sesuai dengan kelipatan pecahan yang dipilih!");
        } else {
          int lembar = jumlahTarik ~/ nilaiPecahan;
          saldo -= jumlahTarik;

          String nominalStr = nilaiPecahan == 50000 ? "50.000" : "100.000";
          print("==========================================");
          print("Rp. $nominalStr x $lembar Lembar");
          print("==========================================");
        }
      } else {
        print("Pilihan pecahan tidak valid.");
      }
    } else {
      print("Pilihan menu tidak valid.");
    }
  }
}