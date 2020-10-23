import 'package:sorted/sorted.dart';
import 'package:test/test.dart';

void main() {
  test('Smoke test', () {
    final house1 = House(
      Continent.europe,
      HouseType.detachedHouse,
      120,
      'Rachel',
    );
    final house2 = House(
      Continent.asia,
      HouseType.detachedHouse,
      145,
      'Mike',
    );
    final house3 = House(
      Continent.southAmerica,
      HouseType.flat,
      39,
      'Stanford',
    );
    final house4 = House(
      Continent.northAmerica,
      HouseType.detachedHouse,
      180,
      'Arthur',
    );
    final house5 = House(
      Continent.northAmerica,
      HouseType.detachedHouse,
      180,
      'Monica',
    );

    final before = [house1, house2, house3, house4, house5];
    final after = before.sorted([
      SortedOrdered<House, HouseType>(
        (x) => x.type,
        [HouseType.flat, HouseType.detachedHouse],
      ),
      SortedGroupOrdered<House, Continent>(
        (x) => x.location,
        [
          [Continent.asia, Continent.africa, Continent.northAmerica],
          [Continent.europe, Continent.southAmerica],
          [Continent.australiaOceania, Continent.antarctica],
        ],
      ),
      SortedComparable<House, int>((x) => x.area, invert: true),
      SortedComparator<House, String>(
        (x) => x.landlord,
        (a, b) => -a.compareTo(b),
      ),
    ]);

    expect(
      after,
      [house3, house5, house4, house2, house1],
    );
  });
}

enum HouseType { flat, detachedHouse }
enum Continent {
  asia,
  africa,
  europe,
  northAmerica,
  southAmerica,
  australiaOceania,
  antarctica,
}

class House {
  House(this.location, this.type, this.area, this.landlord);

  final Continent location;

  final HouseType type;
  final int area;

  final String landlord;
}
