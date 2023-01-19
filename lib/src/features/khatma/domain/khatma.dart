/// * The khatma identifier is an important concept and can have its own type.
typedef KhatmaID = String;

/// Class representing a khatma.
class Khatma {
  const Khatma({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.availableQuantity,
    this.avgRating = 0,
    this.numRatings = 0,
  });

  /// Unique khatma id
  final KhatmaID id;
  final String title;
  final String description;
  final double price;
  final int availableQuantity;
  final double avgRating;
  final int numRatings;
}
