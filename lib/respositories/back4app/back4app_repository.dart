import 'package:viacepapp/models/back4app_viacep_model.dart';
import 'package:viacepapp/models/consulta_cep_model.dart';
import 'package:viacepapp/respositories/back4app/back4app_custom_dio.dart';

class Back4AppRepository {
  final back4AppCustomDio = Back4AppCustomDio();
  Future<Back4AppViaCepModel> getCepsHistoryQuery() async {
    var response = await back4AppCustomDio.dio.get('/Viacep?order=createdAt');
    return Back4AppViaCepModel.fromJson(response.data);
  }

  Future<void> sendCepToBack4app(ConsultaCepModel consultaCepModel) async {
    try {
      await back4AppCustomDio.dio
          .post('/Viacep', data: consultaCepModel.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> changeCepData(
      ConsultaCepModel consultaCepModel, String id) async {
    try {
      await back4AppCustomDio.dio
          .put("/Viacep/$id", data: consultaCepModel.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteCepFromBack4app(String objectId) async {
    try {
      await back4AppCustomDio.dio.delete("/Viacep/$objectId");
    } catch (e) {
      rethrow;
    }
  }
}
