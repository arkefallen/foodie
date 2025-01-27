import 'package:flutter/material.dart';
import 'package:foodie/data/model/menu_category.dart';
import 'package:foodie/data/model/restaurant_images_enum.dart';
import 'package:foodie/provider/add_review_provider.dart';
import 'package:foodie/provider/detail_restaurant_provider.dart';
import 'package:foodie/screens/state/add_review_state.dart';
import 'package:foodie/screens/state/detail_restaurant_state.dart';
import 'package:provider/provider.dart';

class DetailRestaurantScreen extends StatefulWidget {
  final String restaurantId;

  const DetailRestaurantScreen({super.key, required this.restaurantId});

  @override
  State<DetailRestaurantScreen> createState() => _DetailRestaurantScreenState();
}

class _DetailRestaurantScreenState extends State<DetailRestaurantScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context
        .read<DetailRestaurantProvider>()
        .fetchDetailRestaurant(widget.restaurantId);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _reviewController.dispose();
    super.dispose();
  }

  Future<void> addNewReview(BuildContext context) async {
    final addReviewProvider = context.read<AddReviewProvider>();
    final detailProvider = context.read<DetailRestaurantProvider>();

    await addReviewProvider.addReview(
      widget.restaurantId,
      _nameController.text,
      _reviewController.text,
    );

    if (!context.mounted) return;

    final state = addReviewProvider.state;
    if (state is AddReviewSuccess) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Sukses Menambah Review")),
      );
      await detailProvider.fetchDetailRestaurant(widget.restaurantId);
    } else if (state is AddReviewError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.error)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Consumer<DetailRestaurantProvider>(
        builder: (context, provider, _) {
          final state = provider.state;
          if (state is DetailRestaurantLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is DetailRestaurantSuccess) {
            return Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: ListView(
                children: [
                  const SizedBox(
                    height: 24.0,
                  ),
                  Hero(
                    tag: RestaurantImage.small
                        .getImageUrl(state.restaurant.pictureId.toString()),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        RestaurantImage.large
                            .getImageUrl(state.restaurant.pictureId.toString()),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Row(
                          children: state.restaurant.categories!
                              .map(
                                (category) =>
                                    _buildCategoryComponent(context, category),
                              )
                              .toList(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          state.restaurant.name.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant,
                              ),
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.place_rounded,
                            size: 24,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          const SizedBox(
                            width: 16.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.restaurant.city.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                    ),
                              ),
                              Text(
                                state.restaurant.address.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                    ),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 24.0,
                      ),
                      Text(
                        "Deskripsi",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        state.restaurant.description.toString(),
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                      ),
                      const SizedBox(
                        height: 24.0,
                      ),
                      Text(
                        "Daftar Menu",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Column(
                        children: [
                          _buildFoodsComponent(
                              context, state.restaurant.menus!.foods),
                          _buildDrinkComponent(
                              context, state.restaurant.menus!.drinks)
                        ],
                      ),
                      const SizedBox(
                        height: 24.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Review",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                          ),
                          TextButton.icon(
                            onPressed: () {
                              _nameController.clear();
                              _reviewController.clear();

                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(
                                      "Tambah Review",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge
                                          ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                    ),
                                    content: SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const SizedBox(
                                            height: 8.0,
                                          ),
                                          TextField(
                                            controller: _nameController,
                                            decoration: InputDecoration(
                                              labelText: "Nama",
                                              border:
                                                  const OutlineInputBorder(),
                                              hintText: "Isi Namamu",
                                              labelStyle: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge
                                                  ?.copyWith(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onSurface,
                                                  ),
                                              hintStyle: Theme.of(context)
                                                  .textTheme
                                                  .labelMedium
                                                  ?.copyWith(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .outline,
                                                  ),
                                            ),
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium
                                                ?.copyWith(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onSurface,
                                                ),
                                          ),
                                          const SizedBox(
                                            height: 16.0,
                                          ),
                                          TextField(
                                              controller: _reviewController,
                                              decoration: InputDecoration(
                                                labelText: "Review",
                                                border:
                                                    const OutlineInputBorder(),
                                                hintText: "Isi Reviewmu",
                                                labelStyle: Theme.of(context)
                                                    .textTheme
                                                    .labelLarge
                                                    ?.copyWith(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .onSurface,
                                                    ),
                                                hintStyle: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium
                                                    ?.copyWith(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .outline,
                                                    ),
                                              ),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelMedium
                                                  ?.copyWith(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onSurface,
                                                  )),
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Batal"),
                                      ),
                                      FilledButton.tonal(
                                        onPressed: () {
                                          addNewReview(context);
                                        },
                                        child: Consumer<AddReviewProvider>(
                                          builder: (context, provider, _) {
                                            final state = provider.state;
                                            if (state is AddReviewLoading) {
                                              return const SizedBox(
                                                width: 16.0,
                                                height: 16.0,
                                                child:
                                                    CircularProgressIndicator(
                                                  strokeWidth: 2,
                                                ),
                                              );
                                            } else {
                                              return const Text("Kirim");
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            label: const Text("Tambah"),
                            icon: const Icon(Icons.add),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Column(
                        children: state.restaurant.customerReviews!
                            .map(
                              (review) => Card.filled(
                                child: ListTile(
                                  title: Text(review.name.toString()),
                                  subtitle: Text(review.review.toString()),
                                  leading: const Icon(
                                    Icons.person_rounded,
                                    size: 32,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      const SizedBox(
                        height: 24.0,
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else if (state is DetailRestaurantError) {
            return Center(
              child: Text(state.error),
            );
          } else {
            return const Center(
              child: Text("Unknown error"),
            );
          }
        },
      ),
    );
  }

  SizedBox _buildFoodsComponent(BuildContext context, List<Food> state) {
    return SizedBox(
      width: double.infinity,
      child: Card.filled(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Makanan",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              Wrap(
                spacing: 8.0,
                runSpacing: 12.0,
                children: state
                    .map(
                      (food) => Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8.0)),
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            food.name,
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.surface),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              )
            ],
          ),
        ),
      ),
    );
  }

  SizedBox _buildDrinkComponent(BuildContext context, List<Drink> state) {
    return SizedBox(
      width: double.infinity,
      child: Card.filled(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Minuman",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              Wrap(
                spacing: 8.0,
                runSpacing: 12.0,
                children: state
                    .map(
                      (drink) => Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8.0)),
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            drink.name,
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.surface),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Padding _buildCategoryComponent(
      BuildContext context, RestaurantCategory category) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: FilledButton.tonal(
        onPressed: null,
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(
            Theme.of(context).colorScheme.secondaryContainer,
          ),
          foregroundColor: WidgetStatePropertyAll(
            Theme.of(context).colorScheme.onSecondaryContainer,
          ),
          textStyle: WidgetStatePropertyAll(
            Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
        child: Text(category.name.toString()),
      ),
    );
  }
}
