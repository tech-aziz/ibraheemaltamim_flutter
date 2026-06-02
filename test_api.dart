import 'package:dio/dio.dart';

void main() async {
  final dio = Dio();
  final url = "https://ibraheemaltamim.thesyndicates.team/api/researcher/favourites";
  try {
    final response = await dio.get(
      url,
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer 206|wIe3wB72q4BfBwA1lI0h4i5c1M8P8x2z3z1q', // Wait, we don't have the token!
        }
      )
    );
    print(response.data);
  } catch (e) {
    print("Error: \$e");
  }
}
