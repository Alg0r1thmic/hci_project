class FirestorePath {
  static String temperature(String id) => 'temperatures/$id';
  static String temperatures()=>'temperatures';
  static String oxygenSaturation(String id) => 'oxygenSaturations/$id';
  static String oxygenSaturations()=>'oxygenSaturations';
  static String question(String id) => 'questions/$id';
  static String questions()=>'questions';
  static String user(String id) => 'users/$id';
  static String users()=>'users';
  static String sensor(String id) => 'sensors/$id';
  static String sensors()=>'sensors';
  
  static String hearthRate(String id) => 'hearthRates/$id';
  static String hearthRates()=>'hearthRates';
  static String imc(String id) => 'imcs/$id';
  static String imcs()=>'imcs';

}