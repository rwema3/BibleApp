/// Contains the information returned by a [queryPassage()].
class PassageQuery {
  /// The text of the returned query.
  String? passage;

  /// The bible reference that this query refers to.
  String? reference;

  /// The passage version in shortened form. (i.e 'NIV' or 'KJV').
  String? version;

  /// If the provider can return an array with each of the verses it will be added here.
  /// Most cannot so this field will be `null`.
  final Map<String, String?>? verses;

  /// Either the original response by the API.
  /// or extra information from the query, possibly null.
  final Map<String, dynamic>? extra;

  /// The needed and optional parameters that providers should contain.
  PassageQuery.fromProvider(this.passage, this.reference, this.version,
      {this.verses, this.extra});

  @override
  String toString() {
    return '${reference} (${version})\n${passage}';
  }
}
