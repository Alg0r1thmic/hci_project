class DiseaseModel {
  DiseaseModel({
    this.name,
    this.description,
    this.causes,
  });

  String name;
  String description;
  List<String> causes;
}

List<DiseaseModel> diseases = [
  DiseaseModel(
      name: "Fiebre",
      description: "Usualmente es ocasionado cuando el cuerpo necesita eliminar componentes invasores.",
      causes: <String>["Virus", "Bacterias"]
  ),
  DiseaseModel(
      name: "Hipotermia",
      description: "La hipotermia ocurre cuando su cuerpo pierde calor mas rapido de lo que produce, usualmente por la exposicion a condiciones frias.",
      causes: <String>[""]
  ),
  DiseaseModel(
    name: "Hipoxemia",
    description: "La hipoxemia son niveles de oxigeno bajos en la sangre que podria estar relacionado con la respiracion y la circulacion de sangre.",
    causes: <String>["Enfermedades cardiovasculares", "Enfermedades respiratorias"]
  ),

];