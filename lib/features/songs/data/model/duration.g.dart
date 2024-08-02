import 'package:hive/hive.dart';

class DurationAdapter extends TypeAdapter<Duration> {
  @override
  final typeId = 1;

  @override
  Duration read(BinaryReader reader) {
    // Read the duration in microseconds
    final microseconds = reader.readInt();
    return Duration(microseconds: microseconds);
  }

  @override
  void write(BinaryWriter writer, Duration obj) {
    // Write the duration in microseconds
    writer.writeInt(obj.inMicroseconds);
  }
}
