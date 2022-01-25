import 'dart:async';

import 'package:admin_dashboard/shared/constants/constants.dart';
import 'package:admin_dashboard/shared/model/denuncia.model.dart';
import 'package:admin_dashboard/shared/widgets/app_bar_constom.dart';
import 'package:admin_dashboard/shared/widgets/card_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hasura_connect/hasura_connect.dart';

class AtendidosPage extends StatefulWidget {
  const AtendidosPage({Key? key}) : super(key: key);

  @override
  _AtendidosPageState createState() => _AtendidosPageState();
}

class _AtendidosPageState extends State<AtendidosPage> {
  StreamController<DenunciaModel> _denuncias = StreamController.broadcast();
  final controller = TextEditingController();

  String doQuery = """
    subscription MySubscription {
    Denuncia(order_by: {id: desc}, where: {atendido: {_eq: true}}) {
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
        title: "Atendidos",
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
            List<Denuncia> list = snapshot.data!.data!.denuncia!.where((value)=>value.nome!.startsWith(controller.text)).toList();

            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(20),
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
                          onPressed: () {},
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
}
