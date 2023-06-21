import 'package:accordion/accordion.dart';
import 'package:batubara/source/service/Batubara/cubit/history_cubit.dart';
import 'package:batubara/source/widget/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HistoryCubit>(context).getHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: merah,
          centerTitle: true,
          title: const Text("History", style: TextStyle(color: Colors.white)),
        ),
        body: BlocBuilder<HistoryCubit, HistoryState>(
          builder: (context, state) {
            if (state is HistoryLoading) {
              return Center(child: CircularProgressIndicator(color: merah));
            }
            if (state is HistoryLoaded == false) {
              return Container();
            }
            var list = (state as HistoryLoaded).json;
            return RefreshIndicator(
              onRefresh: () async {
                BlocProvider.of<HistoryCubit>(context).getHistory();
              },
              child: list.isEmpty
                  ? InkWell(
                      onTap: () {
                        BlocProvider.of<HistoryCubit>(context).getHistory();
                      },
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Text('Data History Kosong'),
                            Text('Ketuk Layar Untuk Memuat Data'),
                          ],
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (BuildContext context, int index) {
                        var data = list[index];
                        return Container(
                          // margin: const EdgeInsets.all(8.0),
                          padding: const EdgeInsets.all(8.0),
                          child: Accordion(
                            paddingListBottom: 0,
                            paddingListTop: 0,
                            disableScrolling: true,
                            scaleWhenAnimating: true,
                            openAndCloseAnimation: true,
                            headerBackgroundColorOpened: merah,
                            headerBackgroundColor: headerAccordion,
                            contentBorderColor: contentAccordion,
                            headerPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                            children: [
                              AccordionSection(
                                  header: Text(
                                    data['nama_mesin'],
                                    style: const TextStyle(color: Colors.white, fontSize: 17),
                                  ),
                                  content: Column(
                                    children: [
                                      Table(
                                        columnWidths: const {
                                          0: FixedColumnWidth(100),
                                          1: FixedColumnWidth(10),
                                        },
                                        children: [
                                          TableRow(children: [
                                            const SizedBox(
                                              height: 25,
                                              child: Text('Frequency Speed', style: TextStyle(fontSize: 17)),
                                            ),
                                            const Text(':', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
                                            Text('${data['speed_converter']} Hz', style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
                                          ]),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width,
                                        child: DataTable(
                                            showBottomBorder: true,
                                            headingRowColor: MaterialStateProperty.resolveWith((states) => merah),
                                            headingRowHeight: 30,
                                            border: TableBorder(borderRadius: BorderRadius.circular(4.0)),
                                            dividerThickness: 2,
                                            columns: const [
                                              DataColumn(label: Text('KCAL', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                                              DataColumn(label: Text('Rasio', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                                            ],
                                            rows: (data['detail'] as List).map((e) {
                                              return DataRow(cells: [
                                                DataCell(Text(e['kcal'].toString())),
                                                DataCell(Text(e['rasio'].toString())),
                                              ]);
                                            }).toList()),
                                      )
                                      // ListView.builder(
                                      //   shrinkWrap: true,
                                      //   physics: const NeverScrollableScrollPhysics(),
                                      //   itemCount: data['detail'].length,
                                      //   itemBuilder: (BuildContext context, int index2) {
                                      //     var detail = data['detail'][index2];
                                      //     return;
                                      //   },
                                      // ),
                                    ],
                                  ))
                            ],
                          ),
                        );
                      },
                    ),
            );
          },
        ));
  }
}
