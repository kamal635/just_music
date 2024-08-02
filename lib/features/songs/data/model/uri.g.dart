import 'package:hive/hive.dart';

class UriAdapter extends TypeAdapter<Uri> {
  @override
  final int typeId = 3;

  @override
  Uri read(BinaryReader reader) {
    final uriString = reader.readString();
    return Uri.parse(uriString);
  }

  @override
  void write(BinaryWriter writer, Uri obj) {
    writer.writeString(obj.toString());
  }
}
