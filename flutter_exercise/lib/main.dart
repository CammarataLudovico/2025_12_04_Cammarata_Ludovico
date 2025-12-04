import "package:flutter/material.dart";
import "package:its_aa_pn_2025_cross_platform/form.dart";
import "package:its_aa_pn_2025_cross_platform/models/review.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "MyFork - Flutter Exam",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      home: const ReviewListPage(),
    );
  }
}

class ReviewListPage extends StatefulWidget {
  const ReviewListPage({super.key});

  @override
  State<ReviewListPage> createState() => _ReviewListPageState();
}

class _ReviewListPageState extends State<ReviewListPage> {
  final List<Review> _reviews = [];

  @override
  void initState() {
    super.initState();
  }

  Future<void> _addReview() async {
    final newReview = await showDialog<Review>(
      context: context,
      builder: (context) => const AddReviewFormDialog(),
    );

    if (newReview != null) {
      setState(() {
        _reviews.add(newReview);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Review added")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MyFork - Flutter Exam"),
      ),
      body: ListView(
        children: _reviews.map((review) {
          return ListTile(
            leading: const Icon(Icons.reviews),
            title: Text("Title: ${review.title}\nComment: ${review.comment}\nRating: ${review.rating}/5"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () async {
                    final updated = await showDialog<Review>(
                      context: context,
                      builder: (context) => AddReviewFormDialog(review: review),
                    );
                    if (updated != null) {
                      setState(() {
                        final idx = _reviews.indexOf(review);
                        if (idx != -1) _reviews[idx] = updated;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Review edited!")),
                      );
                    }
                  },
                ),
              ],
            ),
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addReview,
        tooltip: "Add review!",
        child: const Icon(Icons.add),
      ),
    );
  }
}
