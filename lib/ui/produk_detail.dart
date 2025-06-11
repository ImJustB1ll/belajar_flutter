import 'package:belajar_flutter/bloc/produk_bloc.dart';
import 'package:belajar_flutter/model/produk.dart';
import 'package:belajar_flutter/ui/produk_form.dart';
import 'package:belajar_flutter/ui/produk_page.dart';
import 'package:belajar_flutter/widget/warning_dialog.dart';
import 'package:flutter/material.dart';

class ProdukDetail extends StatefulWidget {
  final Produk? produk;

  const ProdukDetail({super.key, this.produk});

  @override
  _ProdukDetailState createState() => _ProdukDetailState();
}

class _ProdukDetailState extends State<ProdukDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Produk')),
      body: Center(
        child: Column(
          children: [
            Text(
              "Kode : ${widget.produk!.kodeProduk}",
              style: const TextStyle(fontSize: 20.0),
            ),
            Text(
              "Nama : ${widget.produk!.namaProduk}",
              style: const TextStyle(fontSize: 18.0),
            ),
            Text(
              "Harga : Rp. ${widget.produk!.hargaProduk.toString()}",
              style: const TextStyle(fontSize: 18.0),
            ),
            _tombolHapusEdit(),
          ],
        ),
      ),
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        //Tombol Edit
        OutlinedButton(
          child: const Text("EDIT"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProdukForm(produk: widget.produk!),
              ),
            );
          },
        ),
        //Tombol Hapus
        OutlinedButton(
          child: const Text("DELETE"),
          onPressed: () => confirmHapus(),
        ),
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      content: const Text("Yakin ingin menghapus data ini?"),
      actions: [
        // Tombol Ya (Hapus)
        OutlinedButton(
          child: const Text("Ya"),
          onPressed: () {
            // Memanggil BLoC untuk menghapus produk berdasarkan ID
            ProdukBloc.deleteProduk(id: widget.produk!.id).then(
              (value) {
                // Jika berhasil, kembali ke halaman daftar produk
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => const ProdukPage(),
                  ),
                );
              },
              onError: (error) {
                // Jika gagal, tampilkan dialog error
                showDialog(
                  context: context,
                  builder: (BuildContext context) => const WarningDialog(
                    description: "Hapus data gagal, silahkan coba lagi",
                  ),
                );
              },
            );
          },
        ),

        // Tombol Batal
        OutlinedButton(
          child: const Text("Batal"),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );

    showDialog(builder: (context) => alertDialog, context: context);
  }
}
