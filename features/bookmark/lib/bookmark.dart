import 'package:bookmark/presentation/ui/bookmark_page.dart';
import 'package:dependencies/dependencies.dart';
import 'package:shared/common/common.dart';

class FeatureBookmarkModule extends ChildModule {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(
          Modular.get<NamedRoutes>().bookmarkPage,
          child: (context, arg) => BookmarkPage(),
        ),
      ];
}
