import 'package:aurask/app/model/question.dart';
import 'package:aurask/core/model/category.dart';
import 'package:dio/dio.dart';

const String baseUrl = "https://opentdb.com/api.php";
var dio = Dio();

Future postUserDetails(id, experience) async {
  try {
    var dio = Dio();
    final response = await dio.post(
        "https://t2v0d33au7.execute-api.ap-south-1.amazonaws.com/Staging01/customerorder?tenantSet_id=SIGNUP&tenantUsecase=xyz&usecase=aurask",
        data: {
          "user": {
            "id": id,
            "experience": experience,
          }
        });
    print(response.data);
  } catch (e) {
    print(e);
  }
}

Future login(id, email, name, refer) async {
  try {
    var dio = Dio();
    final response = await dio.post(
        "https://t2v0d33au7.execute-api.ap-south-1.amazonaws.com/Staging01/customerorder?tenantSet_id=SIGNUP&tenantUsecase=xyz&usecase=aurask",
        data: {
          "user": {
            "id": id,
            "email": email,
            "name": name ?? "",
            "refferedBy": refer
          }
        });
    print(response.data);
  } catch (e) {
    print(e);
  }
}

Future<List<Question>> getQuestions(
    Category category, int total, String difficulty) async {
  String url = "$baseUrl?amount=$total&category=${category.id}";
  if (difficulty.isNotEmpty) {
    url = "$url&difficulty=$difficulty";
  }
  var res = await dio.get(url);
  List<Map<String, dynamic>> questions =
      List<Map<String, dynamic>>.from(res.data["results"]);
  print(res.data["results"]);
  return Question.fromData(questions);
}
