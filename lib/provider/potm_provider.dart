import 'package:booking_football_schedule/helper/potm_helper.dart';
import 'package:booking_football_schedule/models/potm_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PotmNotifier extends StateNotifier<PotmModel> {
  PotmNotifier()
      : super(PotmModel(
            name: 'Loading...',
            position: ['Loading...'],
            team: ['Loading...'],
            image: 'https://firebasestorage.googleapis.com/v0/b/main-app-e9209.appspot.com/o/potm_images%2Fdefault.png?alt=media&token=69ed3826-4b8d-472f-81e8-f58d88ba19e2&_gl=1*pphzt7*_ga*MTgxNTMzMDk5My4xNjk1NTI1OTky*_ga_CW55HF8NVT*MTY5NzQzMDEyOS42NS4xLjE2OTc0MzAxODcuMi4wLjA.',
            content: 'Loading...'));

  Future<void> loadPOTM(int month) async {
    PotmHelper potmHelper = PotmHelper();
    final potm = await potmHelper.getPotmData(month);

    state = potm!;
  }
}

final potmProvider = StateNotifierProvider<PotmNotifier,PotmModel>((ref) => PotmNotifier());
