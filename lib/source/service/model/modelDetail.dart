class ModelDetail {
  int? kcal, rasio, subtotal;

  ModelDetail(this.kcal, this.rasio, this.subtotal);

  Map toJson() => {'kcal': kcal, 'rasio': rasio, 'subtotal': subtotal};

  @override
  String toString() {
    return "{'kcal': $kcal, 'rasio': $rasio, 'subtotal': $subtotal}";
  }
}
