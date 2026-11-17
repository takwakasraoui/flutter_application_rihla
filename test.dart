num somme(List<num> nombres) {
  return nombres.fold<num>(0, (total, nombre) => total + nombre);
}
