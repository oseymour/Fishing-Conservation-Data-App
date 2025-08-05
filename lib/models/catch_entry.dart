class CatchEntry {
  final String uuid;
  final double length;
  final double weight;
  final double? girth;
  final int datetime; // int because should be UNIX timestamp

  const CatchEntry({
    required this.uuid, 
    required this.length, 
    required this.weight, 
    required this.girth, 
    required this.datetime
  });

  Map<String, Object?> toMap() {
    return {
      'uuid': uuid, 
      'length': length, 
      'weight': weight, 
      'girth': girth, 
      'datetime': datetime // convert to string for JSON compatibility
    };
  }

  factory CatchEntry.fromMap(Map<String, dynamic> map) {
    return CatchEntry(
      uuid: map['uuid'], 
      length: map['length'], 
      weight: map['weight'], 
      girth: map['girth'], 
      datetime: map['datetime']
    );
  }

  @override
  String toString() {
    return 'CatchEntry{uuid: $uuid, length: $length, weight: $weight, girth: $girth, datetime, $datetime}';
  }
}