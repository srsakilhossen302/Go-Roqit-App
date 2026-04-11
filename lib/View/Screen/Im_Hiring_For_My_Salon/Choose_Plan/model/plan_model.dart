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
  final String? duration;
  final String? paymentType;
  final String? productId;
  final String? priceId;
  final String? status;

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
    this.duration,
    this.paymentType,
    this.productId,
    this.priceId,
    this.status,
    this.isCurrentPlan = false,
    this.isPopular = false,
    this.discountText,
    this.period,
  });

  factory PlanModel.fromJson(Map<String, dynamic> json) {
    List<PlanFeature> featureList = [];
    if (json['features'] != null && json['features'] is List) {
      featureList = (json['features'] as List)
          .map((f) => PlanFeature(f.toString()))
          .toList();
    }

    return PlanModel(
      id: json['_id'] ?? '',
      name: json['title'] ?? '',
      price: json['price']?.toString() ?? '0.00',
      description: json['description'] ?? '',
      duration: json['duration'],
      paymentType: json['paymentType'],
      productId: json['productId'],
      priceId: json['priceId'],
      status: json['status'],
      features: featureList,
      period: json['paymentType'] != null ? "/${json['paymentType']}" : null,
    );
  }
}
