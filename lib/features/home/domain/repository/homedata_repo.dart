
import 'package:doctors_app/features/home/presentation/model/home_model.dart';


abstract class HomeRepository {
  Future<List<ConsultationModel>> getHomeData();
}
