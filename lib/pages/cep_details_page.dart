import 'package:flutter/material.dart';
import 'package:viacepapp/models/back4app_viacep_model.dart';
import 'package:viacepapp/models/consulta_cep_model.dart';
import 'package:viacepapp/respositories/back4app/back4app_repository.dart';
import 'package:viacepapp/services/show_snackback_service.dart';

class CepDetailsPage extends StatefulWidget {
  final Back4AppViaCepModel consultaCepModel;
  final int index;
  const CepDetailsPage(
      {super.key, required this.consultaCepModel, required this.index});

  @override
  State<CepDetailsPage> createState() => _CepDetailsPageState();
}

class _CepDetailsPageState extends State<CepDetailsPage> {
  late Back4AppRepository back4appRepository;
  var cepController = TextEditingController();
  var ruaController = TextEditingController();
  var bairroController = TextEditingController();
  var cidadeController = TextEditingController();
  var estadoController = TextEditingController();
  var dddController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setDatas();
  }

  setDatas() {
    back4appRepository = Back4AppRepository();
    cepController.text = widget.consultaCepModel.results![widget.index].cep!;
    ruaController.text =
        widget.consultaCepModel.results![widget.index].logradouro!;
    bairroController.text =
        widget.consultaCepModel.results![widget.index].bairro!;
    cidadeController.text =
        widget.consultaCepModel.results![widget.index].localidade!;
    estadoController.text = widget.consultaCepModel.results![widget.index].uf!;
    dddController.text = widget.consultaCepModel.results![widget.index].ddd!;
  }

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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: cepController,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    TextField(
                      controller: ruaController,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    TextField(
                      controller: bairroController,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    TextField(
                      controller: cidadeController,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    TextField(
                      controller: estadoController,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    TextField(
                      controller: dddController,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () async {
                              try {
                                await back4appRepository.changeCepData(
                                    ConsultaCepModel(
                                        cepController.text,
                                        ruaController.text,
                                        widget
                                            .consultaCepModel
                                            .results![widget.index]
                                            .complemento!,
                                        bairroController.text,
                                        cidadeController.text,
                                        estadoController.text,
                                        widget.consultaCepModel
                                            .results![widget.index].ibge!,
                                        widget.consultaCepModel
                                            .results![widget.index].gia!,
                                        dddController.text,
                                        widget.consultaCepModel
                                            .results![widget.index].siafi!),
                                    widget.consultaCepModel
                                        .results![widget.index].objectId!);
                              } catch (e) {
                                if (mounted) {
                                  return showSnackBar(context,
                                      "Houve um erro ao salvar alterações! Tente novamente!");
                                }
                              }
                              if (mounted) {
                                Navigator.pop(context, widget.consultaCepModel);
                                showSnackBar(
                                    context, "Alterações salvas com sucesso!");
                              }
                            },
                            child: const Text("Salvar alterações")))
                  ]),
            ),
            const SizedBox(height: 15),
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
