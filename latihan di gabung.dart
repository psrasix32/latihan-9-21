import 'dart:io';

class AntreanCucian {
  String namaPelanggan;
  String jenisKendaraan;
  String jenisLayanan;
  int harga;

  AntreanCucian(this.namaPelanggan, this.jenisKendaraan, this.jenisLayanan, this.harga);
}

void main() {
  List<AntreanCucian> daftarAntrean = [];
  bool jalan = true;

  while (jalan) {
    print('\n========================================');
    print('   SISTEM ANTREAN & KASIR SALON KENDARAAN');
    print('========================================');
    print('1. Ambil Antrean & Pilih Layanan');
    print('2. Lihat Daftar Antrean');
    print('3. Proses Pembayaran / Selesaikan Layanan');
    print('4. Keluar');
    stdout.write('Pilih menu (1-4): ');
    
    String? pilihan = stdin.readLineSync();

    switch (pilihan) {
      case '1':
        print('\n--- FORM PENDAFTARAN ANTREAN ---');
        stdout.write('Masukkan Nama Pelanggan: ');
        String nama = stdin.readLineSync() ?? 'Tanpa Nama';

        print('Pilih Jenis Kendaraan:');
        print('1. Motor (Estimasi cepat)');
        print('2. Mobil (Estimasi standar)');
        stdout.write('Pilihan (1/2): ');
        String? jenisK = stdin.readLineSync();
        String kendaraan = (jenisK == '1') ? 'Motor' : 'Mobil';

        print('\nPilih Jenis Layanan Cuci:');
        print('1. Cuci Reguler (Rp 20.000)');
        print('2. Cuci + Wax / Polish (Rp 50.000)');
        print('3. Detailing Lengkap (Rp 100.000)');
        stdout.write('Pilihan Layanan (1-3): ');
        String? jenisL = stdin.readLineSync();

        String layanan = '';
        int harga = 0;

        if (jenisL == '1') {
          layanan = 'Cuci Reguler';
          harga = 20000;
        } else if (jenisL == '2') {
          layanan = 'Cuci + Wax / Polish';
          harga = 50000;
        } else if (jenisL == '3') {
          layanan = 'Detailing Lengkap';
          harga = 100000;
        } else {
          layanan = 'Cuci Reguler (Default)';
          harga = 20000;
        }

        daftarAntrean.add(AntreanCucian(nama, kendaraan, layanan, harga));
        print('\n[SUKSES] Antrean atas nama $nama berhasil ditambahkan!');
        break;

      case '2':
        print('\n--- DAFTAR ANTREAN SAAT INI ---');
        if (daftarAntrean.isEmpty) {
          print('Belum ada antrean.');
        } else {
          for (int i = 0; i < daftarAntrean.length; i++) {
            print('${i + 1}. Nama: ${daftarAntrean[i].namaPelanggan} | '
                'Kendaraan: ${daftarAntrean[i].jenisKendaraan} | '
                'Layanan: ${daftarAntrean[i].jenisLayanan} | '
                'Biaya: Rp ${daftarAntrean[i].harga}');
          }
        }
        break;

      case '3':
        print('\n--- KASIR & PEMBAYARAN ---');
        if (daftarAntrean.isEmpty) {
          print('Tidak ada kendaraan dalam antrean untuk diproses.');
        } else {
          // Melayani antrean terdepan (FIFO - First In First Out)
          AntreanCucian pelangganKeluar = daftarAntrean.removeAt(0);
          print('Melayani pelanggan: ${pelangganKeluar.namaPelanggan}');
          print('Total tagihan untuk ${pelangganKeluar.jenisLayanan} (${pelangganKeluar.jenisKendaraan}): Rp ${pelangganKeluar.harga}');

          bool bayarSelesai = false;
          while (!bayarSelesai) {
            stdout.write('Masukkan uang pembayaran (Rp): ');
            String? inputUang = stdin.readLineSync();
            int uangBayar = int.tryParse(inputUang ?? '0') ?? 0;

            if (uangBayar < pelangganKeluar.harga) {
              print('[GAGAL] Uang kurang! Tagihan sebesar Rp ${pelangganKeluar.harga}');
            } else {
              int kembalian = uangBayar - pelangganKeluar.harga;
              print('[SUKSES] Pembayaran berhasil!');
              print('Kembalian Anda: Rp $kembalian');
              print('Terima kasih, kendaraan ${pelangganKeluar.namaPelanggan} siap diambil.');
              bayarSelesai = true;
            }
          }
        }
        break;

      case '4':
        jalan = false;
        print('\nTerima kasih telah menggunakan sistem kasir dan antrean!');
        break;

      default:
        print('[ERROR] Pilihan tidak valid, silakan coba lagi.');
    }
  }
}