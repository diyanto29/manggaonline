import 'package:dropdown_search/dropdown_search.dart';
import 'package:fashion_app/main.dart';
import 'package:fashion_app/src/data/model/city_model/result.dart';
import 'package:fashion_app/src/data/model/cost_model/result.dart';
import 'package:fashion_app/src/data/model/province_model/result.dart';
import 'package:fashion_app/src/viewmodel/cart_viewmodel.dart';
import 'package:flutter/material.dart';

import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class AddressView extends StatefulWidget {
  const AddressView({Key? key}) : super(key: key);

  @override
  State<AddressView> createState() => _AddressViewState();
}

class _AddressViewState extends State<AddressView> {
  @override
  void initState() {
    Provider.of<CartViewModel>(context, listen: false).getProvince();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartViewModel>(builder: (context, data, _) {
      return DraggableScrollableSheet(
        expand: false,
        minChildSize: 0.6,
        initialChildSize: 0.6,
        builder: (context, scrollController) {
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: Colors.white),
            child: Consumer<CartViewModel>(builder: (context, data, child) {
              return ListView(
                controller: scrollController,
                physics: const ClampingScrollPhysics(),
                children: [
                  16.height,
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      height: 5.0,
                      width: 70.0,
                      decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                  ),
                  15.height,
                  ListView(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    children: [
                      if (data.provinceModel == null)
                        DropdownSearch<String>(
                          items: [],
                          onChanged: print,
                          selectedItem: 'Cari Provinsi',
                        ),
                      if (data.provinceModel != null)
                        DropdownSearch<Result>(
                          items: data.provinceModel?.rajaongkir?.results ?? [],
                          onChanged: (value) => data.setProviceSleect(value!),
                          selectedItem: data.provinceSelect ?? null,
                          dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                  hintText: 'Cari Provinsi',
                                  border: OutlineInputBorder())),
                          itemAsString: (item) => item.province!,
                        ),
                      10.height,
                      if (data.cityModel != null)
                        DropdownSearch<CityData>(
                          items: data.cityModel?.rajaongkir?.results ?? [],
                          onChanged: (value) => data.setCitySelected(value!),
                          selectedItem: data.citySelected ?? null,
                          dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                  hintText: 'Cari Kota',
                                  border: OutlineInputBorder())),
                          itemAsString: (item) =>
                              item.type! + " ${item.cityName}",
                        ),
                      10.height,
                      TextField(
                        controller: data.controllerAddress,
                        decoration: InputDecoration(
                            hintText: 'Detail Alamat',
                            border: OutlineInputBorder()),
                      ),
                      10.height,
                      Text(
                        'Kurir',
                        style: boldTextStyle(),
                      ),
                      10.height,
                      DropdownSearch<String>(
                        items: ['jne'],
                        onChanged: (v) => data.getCostData(v),
                        selectedItem: 'jne',
                      ),
                      10.height,
                      if (data.costModel != null)
                        ListView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemBuilder: (context, index) {
                            var costDara =
                                data.costModel!.rajaongkir!.results![index];
                            return RadioListTile<CostData>(
                              value: costDara,
                              groupValue: data.costData,
                              // selected: true,
                              onChanged: (ind) {
                                data.tapOngkir(ind!);
                              },
                              title: Text(
                                  costDara.costs![0].description.toString() +
                                      "( " +
                                      costDara.costs![0].cost![0]['etd'] +
                                      ")"),
                              subtitle: Text(
                                  "Rp ${formatCurrency.format(costDara.costs![0].cost![0]['value'])}"),
                            );
                          },
                          itemCount:
                              data.costModel!.rajaongkir!.results!.length,
                        )
                    ],
                  ),
                ],
              );
            }),
          );
        },
      );
    });
  }
}