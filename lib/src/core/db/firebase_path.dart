class FirestorePath {
  static String temperature(String id) => 'temperatures/$id';
  static String temperatures()=>'temperatures';
  static String oxygenSaturation(String id) => 'oxygenSaturations/$id';
  static String oxygenSaturations()=>'oxygensaturations';
  static String question(String id) => 'questions/$id';
  static String questions()=>'questions';
  static String user(String id) => 'user/$id';
  static String users()=>'users';
}