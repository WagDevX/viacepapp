import 'package:flutter/material.dart';
import 'package:viacepapp/models/back4app_viacep_model.dart';
import 'package:viacepapp/models/consulta_cep_model.dart';
import 'package:viacepapp/pages/cep_details_page.dart';
import 'package:viacepapp/respositories/back4app/back4app_repository.dart';
import 'package:viacepapp/respositories/via_cep_repository.dart';
import 'package:viacepapp/services/show_snackback_service.dart';

class ConsultaCepPage extends StatefulWidget {
  const ConsultaCepPage({super.key});

  @override
  State<ConsultaCepPage> createState() => _ConsultaCepPageState();
}

class _ConsultaCepPageState extends State<ConsultaCepPage> {
  late Back4AppRepository back4AppRepository;
  late ViaCepRepository viaCepRepository;
  var cepController = TextEditingController();
  var cepQueryResult = ConsultaCepModel.vazio();
  var cepQueryHistory = Back4AppViaCepModel();
  var loading = false;

  @override
  void initState() {
    super.initState();
    viaCepRepository = ViaCepRepository();
    back4AppRepository = Back4AppRepository();
    loadData();
  }

  loadData() async {
    setState(() {
      loading = true;
    });
    try {
      cepQueryHistory = await back4AppRepository.getCepsHistoryQuery();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            margin: EdgeInsets.all(8),
            behavior: SnackBarBehavior.floating,
            showCloseIcon: true,
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4))),
            elevation: 2,
            content: Text(
                "Houve um erro ao processar a requisição! Tente novamente")));
      }
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 21, 128, 27),
        centerTitle: true,
        title: const Text("Consulta CEP"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext bc) => AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text("Digite o CEP"),
                        TextField(
                          controller: cepController,
                          autofocus: true,
                          maxLength: 8,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(hintText: "CEP"),
                        )
                      ],
                    ),
                    actions: [
                      IconButton(
                          onPressed: () async {
                            if (cepController.text.length < 8) {
                              showDialog(
                                  context: context,
                                  builder: (_) => const AlertDialog(
                                        content: Text(
                                          "O cep precisa ter 8 dígitos!",
                                          style: TextStyle(fontSize: 16),
                                          textAlign: TextAlign.center,
                                        ),
                                        icon: Icon(
                                          Icons.warning,
                                          color: Colors.red,
                                          size: 50,
                                        ),
                                      ));
                              return;
                            }

                            setState(() {
                              loading = true;
                            });
                            if (mounted) {
                              Navigator.pop(context);
                            }
                            var cepQueryResult = await viaCepRepository
                                .getCepData(cepController.text, context);
                            if (cepQueryResult.cep == "") {
                              setState(() {
                                loading = false;
                              });
                              return;
                            }
                            await back4AppRepository.sendCepToBack4app(
                                ConsultaCepModel(
                                    cepQueryResult.cep,
                                    cepQueryResult.logradouro,
                                    cepQueryResult.complemento,
                                    cepQueryResult.bairro,
                                    cepQueryResult.localidade,
                                    cepQueryResult.uf,
                                    cepQueryResult.ibge,
                                    cepQueryResult.gia,
                                    cepQueryResult.ddd,
                                    cepQueryResult.siafi));
                            loadData();
                          },
                          icon: const Icon(Icons.search))
                    ],
                  ));
        },
        child: const Icon(Icons.search_sharp),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          const Text("Histórico de consultas"),
          loading
              ? const Expanded(
                  child: Center(child: CircularProgressIndicator()))
              : Expanded(
                  child: ListView.builder(
                  itemCount: cepQueryHistory.results?.length,
                  itemBuilder: (context, index) {
                    var query = cepQueryHistory.results?[index];
                    return Dismissible(
                      background: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        color: Colors.red,
                        child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [Icon(Icons.delete), Icon(Icons.delete)]),
                      ),
                      key: UniqueKey(),
                      onDismissed: (DismissDirection dismissdirection) async {
                        try {
                          cepQueryHistory.results?.remove(query);
                          await back4AppRepository
                              .deleteCepFromBack4app(query.objectId!);
                          if (mounted) {
                            showSnackBar(context, "Item excluido!");
                          }
                        } catch (e) {
                          if (mounted) {
                            showSnackBar(context, "Houve um erro ao excluir!");
                            loadData();
                          }
                        }
                      },
                      child: ListTile(
                        leading: const Icon(Icons.location_on),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CepDetailsPage(
                                      consultaCepModel: cepQueryHistory,
                                      index: index)));
                        },
                        title: Text(query!.cep ?? ""),
                        subtitle: Text(query.logradouro ?? ""),
                        trailing: const Icon(Icons.ads_click_outlined),
                      ),
                    );
                  },
                ))
        ],
      ),
    );
  }
}
