class IwantModel {
  //Verbs
  String verb1;
  String verb2;
  String v1pic;
  String v2pic;

  //Foods
  String singledish_foods;
  String soup_foods;
  String fried_foods;
  String steamed_foods;
  String grilled_foods;
  String salads_foods;
  String desserts_foods;
  String fruits_foods;

  //Drinks
  String hotdrinks_drinks;
  String colddrinks_drinks;
  String frappe_drinks;

  //Method
  IwantModel(
      this.verb1,
      this.verb2,
      this.singledish_foods,
      this.soup_foods,
      this.fried_foods,
      this.steamed_foods,
      this.grilled_foods,
      this.salads_foods,
      this.desserts_foods,
      this.fruits_foods,
      this.hotdrinks_drinks,
      this.colddrinks_drinks,
      this.frappe_drinks);

  IwantModel.fromMap(Map<String, dynamic> map) {
    verb1 = map['verb1'];
    verb2 = map['verb2'];
    v1pic = map['v1pic'];
    v2pic = map['v2pic'];

    singledish_foods = map['Sdname'];
    soup_foods = map['Spname'];
    fried_foods = map['Fdname'];
    steamed_foods = map['Stname'];
    grilled_foods = map['Grname'];
    salads_foods = map['Slname'];
    desserts_foods = map['Dsname'];
    fruits_foods = map['Funame'];

    hotdrinks_drinks = map['Hdname'];
    colddrinks_drinks = map['Cdname'];
    frappe_drinks = map['Frname'];
  }
}