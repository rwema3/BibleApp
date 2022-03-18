import 'package:bible/src/model/PassageQuery.dart';
import 'package:reference_parser/reference_parser.dart';

/// A source for bible content
abstract class BibleProvider {
  final bool _requiresKey;
  final Set<String> _versions;
  final String name;

  BibleProvider(this.name, this._requiresKey, this._versions);

  /// Whether or not this provider can query certain a versions.
  bool containsVersion(String version) => _versions.contains(version);

  /// Whether this provider requires an API key to work.
  bool get requiresKey => _requiresKey;

  List<String> get versions => _versions.toList();

  /// Fetch a passage from this provider's designated provider source.
  Future<PassageQuery> getPassage(BibleReference query,
      {Map<String, String>? parameters, String? key, String? version});
}
