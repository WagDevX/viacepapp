import 'package:flutter/material.dart';
import 'package:viacepapp/pages/consulta_cep_page.dart';
import 'package:viacepapp/services/navigation_service.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 180,
            child: Container(
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 21, 128, 27),
                  border: BorderDirectional(
                      bottom: BorderSide(
                          color: Color.fromARGB(255, 230, 255, 42), width: 5))),
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Image.asset(
                      'assets/images/logo_viacep.png',
                      color: Colors.white,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Consulte CEPs de todo o Brasil',
                      style: TextStyle(
                          fontWeight: FontWeight.w400, color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                    "Procurando um webservice gratuito e de alto desempenho para consultar Códigos de Endereçamento Postal (CEP) do Brasil?"),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                    "Utilize nosso serviço, melhore a qualidade de suas aplicações web e colabore para manter esta base de dados atualizada."),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Acessando o webservice de CEP",
                  style: TextStyle(fontSize: 20, color: Colors.green[900]),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                    "Para acessar o webservice, um CEP no formato de {8} dígitos deve ser fornecido, por exemplo: \"01001000\"."),
                const Text(
                    "Após o CEP, deve ser fornecido o tipo de retorno desejado, que deve ser \"json\" ou \"xml\"."),
                const SizedBox(height: 10),
                const Text("Exemplo de pesquisa por CEP:"),
                const SelectableText(
                  "viacep.com.br/ws/01001000/json/",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 60),
                ElevatedButton(
                    style: const ButtonStyle(
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(7))))),
                    onPressed: () {
                      Navigator.of(context).push(NavigationService.navigateTo(
                          const ConsultaCepPage()));
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text("Consultar CEP"), Icon(Icons.forward)],
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
