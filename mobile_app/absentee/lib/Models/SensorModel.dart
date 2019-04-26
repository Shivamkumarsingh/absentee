class Sensor {
  String key;
  String sensor_name;
  String status;
  String last_reading_at;
  double min_reading;
  double max_reading;
  String current_readings;
  String description;

  Sensor(
      {this.key,
      this.sensor_name,
      this.status,
      this.last_reading_at,
      this.min_reading,
      this.max_reading,
      this.current_readings,
      this.description});

  factory Sensor.fromJson(Map<String, dynamic> parsedJson) {
    return Sensor(
        key: parsedJson['key'],
        sensor_name: parsedJson['sensor_name'],
        status: parsedJson['status'],
        last_reading_at: parsedJson['last_reading_at'],
        min_reading: parsedJson['min_reading'],
        max_reading: parsedJson['max_reading'],
        current_readings: parsedJson['current_readings'],
        description: parsedJson['description']);
  }
}
class Class {
  int id;
  int title;
  String name;


  Class(
      {this.id,
        this.title,
        this.name
      });

  factory Class.fromJson(Map<String, dynamic> parsedJson) {
    return Class(
      id: parsedJson['id'],
      title: parsedJson['title'],
      name: parsedJson['name'],
    );
  }
}