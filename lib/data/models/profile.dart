class Profile {
  String id = '';
  String name = 'Unknown';
  double weight = 0;
  //height
  double height = 0;

  Profile({
    this.id = 'Unknown',
    this.name = 'Unknown',
    this.weight = 0,
  });

  Profile clone() {
    return Profile(
      id: id,
      name: name,
      weight: weight,
    );
  }
}
