library shared;

import 'package:injectable/injectable.dart';
export 'package:iconsax/iconsax.dart';

@InjectableInit.microPackage(
  preferRelativeImports: true,
  usesNullSafety: true,
  throwOnMissingDependencies: true,
)
void shared() {}
