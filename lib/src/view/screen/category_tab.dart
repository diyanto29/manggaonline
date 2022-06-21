import 'dart:math';

import 'package:fashion_app/main.dart';
import 'package:fashion_app/src/viewmodel/cart_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../../const/endpoint.dart';

class CategoryTab extends StatefulWidget {
  @override
  State<CategoryTab> createState() => _CategoryTabState();
}

class _CategoryTabState extends State<CategoryTab> {
  @override
  void initState() {
    Provider.of<CartViewModel>(context, listen: false).getTransaksi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Riwayat Transaksi'),
      ),
      body: Consumer<CartViewModel>(
        builder: (context, value, child) {
          if (value.transaksiModel == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (value.transaksiModel!.data!.isEmpty) {
              return Center(
                child: Text('Data Transaksi Kosong'),
              );
            } else {
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: value.transaksiModel!.data!.length,
                itemBuilder: (context, index) {
                  var data = value.transaksiModel!.data![index];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                data.invoice ?? '',
                                style: boldTextStyle(size: 12),
                              ),
                              5.height,
                              Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.green),
                                child: Text(
                                  data.statusOrder?.name ?? '',
                                  style: primaryTextStyle(
                                    size: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          10.height,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Metode Pembayaran',
                                style: secondaryTextStyle(size: 12),
                              ),
                              5.height,
                              Text(
                                data.metodePembayaran ?? '',
                                style: boldTextStyle(size: 12),
                              ),
                            ],
                          ),
                          10.height,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Total',
                                style: secondaryTextStyle(size: 12),
                              ),
                              5.height,
                              Text(
                                "Rp ${formatCurrency.format(data.subtotal)}",
                                style: boldTextStyle(size: 12),
                              ),
                            ],
                          ),
                          10.height,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Ongkir',
                                style: secondaryTextStyle(size: 12),
                              ),
                              5.height,
                              Text(
                                "Rp ${formatCurrency.format(data.ongkir)}",
                                style: boldTextStyle(size: 12),
                              ),
                            ],
                          ),
                          10.height,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Biaya Admin',
                                style: secondaryTextStyle(size: 12),
                              ),
                              5.height,
                              Text(
                                "Rp ${formatCurrency.format(4000)}",
                                style: boldTextStyle(size: 12),
                              ),
                            ],
                          ),
                          10.height,
                          Divider(),
                          5.height,
                          Text(
                            'Detail Alamat',
                            style: boldTextStyle(size: 12),
                          ),
                          5.height,
                          Text(
                              '${data.detailAlamat} ${data.type} ${data.cityName} Provinsi ${data.provinceName}'),
                          10.height,
                          Divider(),
                          5.height,
                          Text(
                            'Produk yang dibeli',
                            style: boldTextStyle(size: 12),
                          ),
                          5.height,
                          ListView.builder(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemCount: data.detailTransaksi!.length,
                            itemBuilder: (c, i) {
                              var produk = data.detailTransaksi![i];

                              return ListTile(
                                leading: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                          EndPoint.photoUrl +
                                              produk.product!.image!,
                                        ),
                                        fit: BoxFit.cover),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                ),
                                title: Text(
                                  produk.product?.name ?? '',
                                  style: boldTextStyle(size: 12),
                                ),
                                subtitle: Text(
                                  "${produk.qty} x ${formatCurrency.format(produk.product!.price!)}",
                                  style: primaryTextStyle(size: 12),
                                ),
                                trailing: Text(
                                  "Rp ${formatCurrency.format(produk.qty! * produk.product!.price!)}",
                                  style: boldTextStyle(size: 12),
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          }
        },
      ),
    );
  }
}
