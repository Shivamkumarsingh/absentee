class Attendance {
  int id;
  String name;
  int roll_number;
  bool present;


  Attendance(
      {this.id,
      this.name,
      this.roll_number,
      this.present,
      });

  factory Attendance.fromJson(Map<String, dynamic> parsedJson) {
    return Attendance(
        id: parsedJson['id'],
        name: parsedJson['name'],
        roll_number: parsedJson['roll_number'],
        present: parsedJson['present'],
      );
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