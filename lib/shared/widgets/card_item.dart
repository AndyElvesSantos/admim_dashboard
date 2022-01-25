import 'package:admin_dashboard/shared/model/denuncia.model.dart';
import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  final Denuncia denuncia;
  Function() onPressed;
  CardItem({
    Key? key,
    required this.onPressed, required this.denuncia,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      shadowColor: Colors.black87,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LineCard(
              title: "Situação",
              resposta: denuncia.usuario!,
            ),
            LineCard(
              title: "Nome",
              resposta: denuncia.nome!,
            ),
            LineCard(
              title: "Sexo",
              resposta: denuncia.sexo!,
            ),
            LineCard(
              title: "Idade",
              resposta: denuncia.idade!.toString(),
            ),
            LineCard(
              title: "Telefone",
              resposta: denuncia.telefone!,
            ),
            LineCard(
              title: "Endereço",
              resposta: "${
                denuncia.estado!+", "+
                denuncia.cidade!+", "+
                denuncia.bairro!+", "+
                denuncia.rua!+", nº"+
                denuncia.numero!
              }",
            ),
            const Divider(),
            LineCard(
              title: "Relato",
              resposta: denuncia.descricao!,
            ),
            const Divider(),
            if (!denuncia.atendido!) 
            FloatingActionButton.extended(
              onPressed: onPressed,
              label: const Text("Atender"),
            ),
          ],
        ),
      ),
    );
  }
}

class LineCard extends StatelessWidget {
  final String title;
  final String resposta;

  const LineCard({Key? key, required this.title, required this.resposta})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: <TextSpan>[
          TextSpan(
            text: '$title: ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: resposta,
          ),
        ],
      ),
    );
  }
}
