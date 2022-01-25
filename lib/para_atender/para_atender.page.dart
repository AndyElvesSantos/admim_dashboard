import 'dart:async';
import 'dart:developer';

import 'package:admin_dashboard/shared/constants/constants.dart';
import 'package:admin_dashboard/shared/model/denuncia.model.dart';
import 'package:admin_dashboard/shared/widgets/app_bar_constom.dart';
import 'package:admin_dashboard/shared/widgets/card_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hasura_connect/hasura_connect.dart';

class ParaAtenderPage extends StatefulWidget {
  const ParaAtenderPage({Key? key}) : super(key: key);

  @override
  _ParaAtenderPageState createState() => _ParaAtenderPageState();
}

class _ParaAtenderPageState extends State<ParaAtenderPage> {
  StreamController<DenunciaModel> _denuncias = StreamController.broadcast();
  final controller = TextEditingController();

  String doQuery = """
    subscription MySubscription {
    Denuncia(order_by: {id: desc}, where: {atendido: {_eq: false}}) {
      atendido
      bairro
      cidade
      descricao
      estado
      id
      idade
      nome
      numero
      rua
      sexo
      telefone
      usuario
    }
  }
  """;

  Future<void> _listaDenuncias() async {
    Snapshot snapshot = await hasuraConnect.subscription(doQuery);
    snapshot.listen((data) {
      final res = DenunciaModel.fromJson(data);
      _denuncias.add(res);
    }).onError((err) {
      print(err);
    });
  }

  @override
  void initState() {
    _listaDenuncias();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCustom(
        title: "Aguardando Atendimento",
      ),
      body: StreamBuilder<DenunciaModel>(
        stream: _denuncias.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.data!.denuncia!.isEmpty) {
              return const Center(
                child: Text("Não possui denuncias"),
              );
            }

            List<Denuncia> list = snapshot.data!.data!.denuncia!
                .where((value) => value.nome!.startsWith(controller.text))
                .toList();

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: CupertinoSearchTextField(
                    controller: controller,
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(
                      right: 20,
                      left: 20,
                      bottom: 20,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.shade300,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (_, i) {
                        return CardItem(
                          denuncia: list.elementAt(i),
                          onPressed: () {
                            _realizarAtendimento(
                              idDenuncia: list.elementAt(i).id!,
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Future<void> _realizarAtendimento({required int idDenuncia}) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Atenção"),
          content: const Text("Deseja marcar essa denuncia como atendida?"),
          actions: [
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Não"),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green),
              ),
              onPressed: () async {
                _atender(id: idDenuncia);
                Navigator.pop(context);
              },
              child: const Text("Sim"),
            )
          ],
        );
      },
    );
  }

  Future<void> _atender({required int id}) async {
    String query = """
      mutation MyMutation {
        update_Denuncia(where: {id: {_eq: $id}}, _set: {atendido: true}) {
          affected_rows
        }
      }
    """;

    await hasuraConnect.mutation(query);
  }
}
