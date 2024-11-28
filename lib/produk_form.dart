import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:produk/details.dart';
import 'package:produk/models/mproduk.dart';
import 'package:produk/models/api.dart';

import 'package:http/http.dart' as http;
import 'package:produk/tambah_produk.dart';

class ProdukForm extends StatefulWidget {
  const ProdukForm({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProdukFormState();
}

class _ProdukFormState extends State<ProdukForm> {
  late Future<List<ProdukModel>> sw;

  @override
  void initState() {
    super.initState();
    sw = getSwList();
  }

  Future<List<ProdukModel>> getSwList() async {
    final response = await http.get(Uri.parse(Baseurl.data));
    final items = json.decode(response.body).cast<Map<String, dynamic>>();
    List<ProdukModel> sw = items.map<ProdukModel>((json) {
      return ProdukModel.fromJson(json);
    }).toList();
    return sw;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'DAFTAR PRODUK',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: FutureBuilder<List<ProdukModel>>(
          future: sw,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }
            return ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                var data = snapshot.data[index];
                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(15),
                    leading: CircleAvatar(
                      backgroundColor: Colors.teal,
                      child: const Icon(Icons.shopping_bag, color: Colors.white),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, color: Colors.teal),
                    title: Text(
                      data.nama,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        "Harga: Rp ${data.harga}",
                        style: const TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Details(sw: data),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        backgroundColor: Colors.teal,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) {
                return TambahProduk();
              },
            ),
          );
        },
      ),
    );
  }
}
