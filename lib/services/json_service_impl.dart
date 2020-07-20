
import 'package:http/http.dart' as http;

import 'json_service.dart';

class JsonServiceImpl extends JsonService {

  @override
  Future getACtivity() async {
    var response = await http.get('https://www.boredapi.com/api/activity');
    print(response.body);
    return response.body;
  }

}
