import "package:flutter/material.dart";
import "package:its_aa_pn_2025_cross_platform/models/review.dart";
import "package:reactive_forms/reactive_forms.dart";

class AddReviewFormDialog extends StatefulWidget {
  const AddReviewFormDialog({this.review, super.key});
  final Review? review;

  @override
  State<AddReviewFormDialog> createState() => _AddReviewFormDialogState();
}

class _AddReviewFormDialogState extends State<AddReviewFormDialog> {
  late final FormGroup _form;

  @override
  void initState() {
    super.initState();
    final isEdit = widget.review != null;
    _form = FormGroup({
      "title": FormControl<String>(
        value: isEdit ? widget.review!.title : "",
        validators: [Validators.required, Validators.minLength(5)],
      ),
      "comment": FormControl<String>(
        value: isEdit ? widget.review!.comment : "",
      ),
      "rating": FormControl<int>(
        value: isEdit ? widget.review!.rating : 5,
        validators: [
          Validators.required,
          Validators.number(
            allowNegatives: false,
          ),
          Validators.min(1),
          Validators.max(5),
        ],
      ),
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final isEdit = widget.review != null;

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ReactiveForm(
          formGroup: _form,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isEdit ? "Modify Review!" : "New Review!",
                style: theme.textTheme.headlineSmall,
              ),
              const SizedBox(height: 40),
              ReactiveTextField<String>(
                formControlName: "title",
                decoration: const InputDecoration(hintText: "title..."),
                validationMessages: {
                  ValidationMessage.required: (_) => "Title is required!",
                  ValidationMessage.minLength: (error) => "At least 5 carachters!",
                },
              ),
              ReactiveTextField<String>(
                formControlName: "comment",
                decoration: const InputDecoration(hintText: "comment...(if you want!)"),
              ),
              const SizedBox(height: 20),
              ReactiveTextField<int>(
                formControlName: "rating",
                decoration: const InputDecoration(hintText: "rating..."),
                validationMessages: {
                  ValidationMessage.required: (_) => "Rating is required!",
                  ValidationMessage.number: (_) => "Insert positive number!",
                  ValidationMessage.min: (error) => "Min rating is 1!",
                  ValidationMessage.max: (error) => "Max rating is 5!",
                },
              ),
              const SizedBox(height: 80),
              ReactiveFormConsumer(
                builder: (context, form, child) {
                  return form.valid
                      ? ElevatedButton(onPressed: _submit, child: const Text("Save!"))
                      : const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (!_form.valid) return;

    final review = Review(
      title: _form.control("title").value as String,
      comment: _form.control("comment").value as String,
      rating: _form.control("rating").value as int,
    );

    Navigator.pop(context, review);
    return;
  }
}
