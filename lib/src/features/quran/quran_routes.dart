import 'package:go_router/go_router.dart';
import 'package:khatma/src/features/quran/presentations/moushaf_screen.dart';
import 'package:khatma/src/routing/app_router.dart';

List<GoRoute> quranRoutes = [
  GoRoute(
    path: 'quran/:idSourat/:idVerset',
    name: AppRoute.quran.name,
    builder: (context, state) {
      final idSourat = int.parse(state.pathParameters['idSourat']!);
      final idVerset = int.parse(state.pathParameters['idVerset']!);
      return MoushafScreen(
        idSourat: idSourat,
        idVerse: idVerset,
      );
    },
  )
];
