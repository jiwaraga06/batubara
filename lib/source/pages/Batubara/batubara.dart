import 'package:batubara/source/router/string.dart';
import 'package:batubara/source/service/Batubara/cubit/batubara_cubit.dart';
import 'package:batubara/source/service/Batubara/cubit/insert_cubit.dart';
import 'package:batubara/source/service/model/modelDetail.dart';
import 'package:batubara/source/widget/color.dart';
import 'package:batubara/source/widget/customButton.dart';
import 'package:batubara/source/widget/customDialog.dart';
import 'package:batubara/source/widget/customForm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Batubara extends StatefulWidget {
  const Batubara({super.key});

  @override
  State<Batubara> createState() => _BatubaraState();
}

class _BatubaraState extends State<Batubara> {
  TextEditingController controllerKet = TextEditingController();
  String? valuenama, valueAll;
  var idMesin, kapasitas, efisiensi, aktual, hz;
  List<ModelDetail> details = [];
  List<ModelDetail> selectedDetail = [];
  var subTotal, rasio, total, roundHz;
  onSelected(bool selected, ModelDetail tabel) async {
    setState(() {
      if (selected) {
        selectedDetail.add(tabel);
      } else {
        selectedDetail.remove(tabel);
      }
      print(selectedDetail);
    });
  }

  deleteSelected() async {
    setState(() {
      if (selectedDetail.isNotEmpty) {
        List<ModelDetail> temp = [];
        temp.addAll(selectedDetail);
        for (ModelDetail tabel in temp) {
          details.remove(tabel);
          selectedDetail.remove(tabel);
        }
        SnackBar snackBar = SnackBar(duration: const Duration(seconds: 1), backgroundColor: Colors.red[700], content: Text('Berhasil Hapus Kolom'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }

  void add() {
    if (kapasitas == null && efisiensi == null) {
      MyDialog.dialogAlert(context, 'ValueKapasitas atau Efisiensi Kosong');
    } else {
      ModelDetail list = ModelDetail(0, 0, 0);
      details.add(list);
      print(details);
      setState(() {
        subTotal = details.map((e) => e.subtotal).fold(0, (a, b) => a + b!);
        rasio = details.map((e) => e.rasio).fold(0, (a, b) => a + b!);
      });
    }
  }

  void save() {
    var resultDetail = [];
    if (valuenama == null) {
      MyDialog.dialogAlert(context, "Boiler Belum di Pilih");
    } else if (details.isEmpty) {
      MyDialog.dialogAlert(context, "Belum ada perhitungan");
    } else {
      setState(() {
        double hitungtotal = subTotal / rasio;
        var resultTotal = hitungtotal.roundToDouble();
        total = resultTotal;
        // total = resultTotal;
        print(resultTotal);
        print("Total: $total");
        print("Sub Total: $subTotal");
        var bagi = kapasitas / total;
        aktual = (bagi / efisiensi) / 1000;
        var roundAktual = double.parse(aktual.toString()).toStringAsFixed(1);
        print("Aktual: $aktual");
        hz = (aktual * 22) / (18 / 10);
        roundHz = double.parse(hz.toString()).toStringAsFixed(1);
        NumberFormat();
        print("Hz: $roundHz");
        // print(details);
        int i = 1;
        details.forEach((e) {
          // print({'seq': e.seq, 'kcal': e.kcal, 'rasio': e.rasio});
          resultDetail.add({'seq': i++, 'kcal': e.kcal, 'rasio': e.rasio});
        });
        print(resultDetail);
        BlocProvider.of<InsertCubit>(context).insert(idMesin, controllerKet.text, valuenama, subTotal, roundAktual, roundHz, resultDetail);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<BatubaraCubit>(context).getBatubara();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: merah,
          centerTitle: true,
          title: const Text('Perhitungan Batubara', style: TextStyle(color: Colors.white)),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, CHANGE_PW);
                },
                icon: const Icon(Icons.more_horiz, color: Colors.white))
          ],
        ),
        body: BlocListener<InsertCubit, InsertState>(
          listener: (context, state) {
            if (state is InsertLoading) {
              EasyLoading.show();
            }
            if (state is InsertLoaded) {
              EasyLoading.dismiss();
              var json = state.json;
              var statusCode = state.statusCode;
              if (statusCode == 200) {
                if (json['errors'] != null) {
                  MyDialog.dialogAlert(context, json['errors'].toString());
                } else {
                  MyDialog.dialogSuccess(
                      context,
                      "${json['message']}",
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("${json['message']}", style: const TextStyle(fontSize: 16)),
                          const Text("Lakukan Pengecekan Pada", style: TextStyle(fontSize: 15)),
                          const Text("Frequency Speed", style: TextStyle(fontSize: 15)),
                          const Text("Rekomendasi Frequensi", style: TextStyle(fontSize: 15)),
                          Text("$roundHz Hz", style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                        ],
                      ));
                  setState(() {
                    details.clear();
                    valuenama!;
                    total = null;
                  });
                }
              } else {
                MyDialog.dialogAlert(context, json['message'].toString());
              }
            }
          },
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0),
                      child: Text('Pilih Boiler', style: TextStyle(fontSize: 17)),
                    ),
                    BlocBuilder<BatubaraCubit, BatubaraState>(
                      builder: (context, state) {
                        if (state is BatubaraLoading) {
                          return const SizedBox(
                            height: 50,
                            child: Center(
                              child: CupertinoActivityIndicator(),
                            ),
                          );
                        }
                        if (state is BatubaraLoaded == false) {
                          DropdownButton(
                            isExpanded: true,
                            hint: const Text("Boiler", style: TextStyle(fontSize: 17)),
                            items: [],
                            onChanged: (value) {},
                          );
                        }
                        List list = (state as BatubaraLoaded).json;
                        return Container(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButton(
                            dropdownColor: Colors.white,
                            style: const TextStyle(fontSize: 17, color: Colors.black),
                            isExpanded: true,
                            value: valuenama,
                            hint: const Text("Boiler", style: TextStyle(fontSize: 17)),
                            items: list
                                .map((e) => DropdownMenuItem(
                                      child: Text(e['nama']),
                                      value: e['nama'],
                                      onTap: () {
                                        setState(() {
                                          idMesin = e['id'];
                                          if (e['kapasitas'] != null && e['efisiensi'] != null) {
                                            kapasitas = e['kapasitas'];
                                            efisiensi = e['efisiensi'] / 100;
                                          } else {
                                            kapasitas = e['kapasitas'];
                                            efisiensi = e['efisiensi'];
                                          }
                                          details.clear();
                                        });
                                      },
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                valuenama = value.toString();
                              });
                            },
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomFormField(
                        controller: controllerKet,
                        color: border,
                        hint: 'Isi Keterangan',
                        label: "Keterangan",
                        obscureText: false,
                      ),
                    ),
                    const SizedBox(height: 20),
                    if (kapasitas != null && efisiensi != null)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
                            ),
                            onPressed: add,
                            child: const Text('Add Detail', style: TextStyle(color: Colors.white))),
                      ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: DataTable(
                          showBottomBorder: true,
                          headingRowColor: MaterialStateProperty.resolveWith((states) => headerTabel),
                          columns: const [
                            DataColumn(label: Text('KCAL', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                            DataColumn(label: Text('Rasio', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                            DataColumn(label: Text('Sub Total', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                            DataColumn(label: Text('Aksi', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                          ],
                          rows: kapasitas == null && efisiensi == null
                              ? []
                              : details.map((e) {
                                  return DataRow(cells: [
                                    DataCell(
                                      TextFormField(
                                          keyboardType: TextInputType.number,
                                          initialValue: e.kcal.toString(),
                                          onChanged: (value) {
                                            if (value.isNotEmpty) {
                                              setState(() {
                                                e.kcal = int.parse(value.toString());
                                                e.subtotal = int.parse(e.kcal.toString()) * int.parse(e.rasio.toString());
                                                subTotal = details.map((e) => e.subtotal).fold(0, (previousValue, element) => previousValue + element!);
                                                rasio = details.map((e) => e.rasio).fold(0, (previousValue, element) => previousValue + element!);
                                                print(e.subtotal);
                                              });
                                            }
                                          }),
                                    ),
                                    DataCell(
                                      TextFormField(
                                          keyboardType: TextInputType.number,
                                          initialValue: e.rasio.toString(),
                                          onChanged: (value) {
                                            if (value.isNotEmpty) {
                                              setState(() {
                                                e.rasio = int.parse(value.toString());
                                                e.subtotal = int.parse(e.kcal.toString()) * int.parse(e.rasio.toString());
                                                subTotal = details.map((e) => e.subtotal).fold(0, (previousValue, element) => previousValue + element!);
                                                rasio = details.map((e) => e.rasio).fold(0, (previousValue, element) => previousValue + element!);
                                                print(e.subtotal);
                                              });
                                            }
                                          }),
                                    ),
                                    DataCell(Text(e.subtotal.toString())),
                                    DataCell(IconButton(
                                        onPressed: () {
                                          setState(() {
                                            onSelected(true, e);
                                            deleteSelected();
                                          });
                                        },
                                        icon: const Icon(Icons.delete_forever, color: Colors.red))),
                                  ]);
                                }).toList()),
                    ),
                    const SizedBox(height: 8.0),
                    const Divider(thickness: 2),
                    const SizedBox(height: 8.0),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: DataTable(showBottomBorder: true, columns: [
                        const DataColumn(label: Text('Total', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
                        const DataColumn(label: Text(' ', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
                        DataColumn(
                            label: Text(total == null ? '' : total.toString(), style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
                        const DataColumn(label: Text(' ', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
                      ], rows: const []),
                    ),
                  ],
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomButton(text: 'Simpan', textStyle: TextStyle(color: Colors.white, fontSize: 16), color: simpan, onTap: save),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
