class PlanFeature {
  final String text;
  final bool isIncluded;

  PlanFeature(this.text, {this.isIncluded = true});
}

class PlanModel {
  final String id;
  final String name;
  final String price;
  final String description;
  final List<PlanFeature> features;

  // UI Badges/States
  final bool isCurrentPlan;
  final bool isPopular;
  final String? discountText; // e.g., "Save £21/year"
  final String? period; // e.g., "/Yearly", default implicit monthly if null

  PlanModel({
    required this.id,
    required this.name,
    required this.price,
    this.description = '',
    required this.features,
    this.isCurrentPlan = false,
    this.isPopular = false,
    this.discountText,
    this.period,
  });
}
