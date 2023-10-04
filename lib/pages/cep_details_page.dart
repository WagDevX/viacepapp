import 'package:flutter/material.dart';
import 'package:viacepapp/models/back4app_viacep_model.dart';

class CepDetailsPage extends StatelessWidget {
  final Back4AppViaCepModel consultaCepModel;
  final int index;
  const CepDetailsPage(
      {super.key, required this.consultaCepModel, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close))
              ],
            ),
            const Center(
              child: Text("Detalhes da consulta",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700)),
            ),
            const SizedBox(height: 50),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SelectableText(
                      "Cep: ${consultaCepModel.results![index].cep!}",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    const Divider(),
                    SelectableText(
                      "Rua: ${consultaCepModel.results![index].logradouro!}",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    const Divider(),
                    SelectableText(
                      "Bairro: ${consultaCepModel.results![index].bairro!}",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    const Divider(),
                    SelectableText(
                      "Cidade: ${consultaCepModel.results![index].localidade!}",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    const Divider(),
                    SelectableText(
                      "Estado: ${consultaCepModel.results![index].uf!}",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    const Divider(),
                    SelectableText(
                      "DDD: ${consultaCepModel.results![index].ddd!}",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    const Divider(),
                  ]),
            ),
            const SizedBox(height: 50),
            const Icon(
              Icons.location_on_outlined,
              size: 150,
            )
          ],
        ),
      ),
    );
  }
}
