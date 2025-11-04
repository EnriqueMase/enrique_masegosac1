class Languages {
  static int idiomaseleccionado = 0;

  static List<String> Bienvenido = ["Bienvenido", "Welcome", "Bienvenue"];

  static List<String> appBar = [
    "Ajustes de la App",
    "App Settings",
    "Paramètres de l'application",
  ];

  static List<String> idiomaselect = [
    "Idioma seleccionado: Español",
    "Selected Language: English",
    "Langue sélectionnée: Francais",
  ];

  static String getTexto(List<String> textos) {
    return textos[idiomaseleccionado];
  }
}
