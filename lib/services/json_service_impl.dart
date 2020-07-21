
import 'package:http/http.dart' as http;

import 'json_service.dart';

class JsonServiceImpl extends JsonService {

  @override
  Future getACtivity(String type) async {
    var response = await http.get('http://www.boredapi.com/api/activity?type=$type');
    print(response.request.url);
    print(response.body);
    return response.body;
  }

}
