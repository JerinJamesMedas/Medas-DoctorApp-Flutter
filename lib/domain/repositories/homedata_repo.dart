
import 'package:doctors_app/model/home_model.dart';


abstract class HomeRepository {
  Future<List<ConsultationModel>> getHomeData();
}
