import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:viacepapp/models/consulta_cep_model.dart';
import 'package:viacepapp/services/show_snackback_service.dart';

class ViaCepRepository {
  ViaCepRepository();

  Future<ConsultaCepModel> getCepData(String cep, BuildContext bc) async {
    var dio = Dio();
    var url = dotenv.get("VIA_CEP_BASE_URL");
    try {
      var response = await dio.get("$url/$cep/json/");
      if (response.statusCode == 200) {
        return ConsultaCepModel.fromJson(response.data);
      } else {
        return ConsultaCepModel.vazio();
      }
    } catch (e) {
      if (bc.mounted) {
        showSnackBar(bc,
            "Houve um erro ao consultar! Verifique os dados e tente novamente!");
      }
      return ConsultaCepModel.vazio();
    }
  }
}
