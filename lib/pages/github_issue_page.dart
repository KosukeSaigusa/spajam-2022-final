import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../features/github_issue/github_issue.dart';
import '../utils/extensions/build_context.dart';

class GitHubIssuePage extends HookConsumerWidget {
  const GitHubIssuePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleController = useTextEditingController();
    final commentController = useTextEditingController();
    final isTitleEmpty = useState<bool>(true);
    final isCommentEmpty = useState<bool>(true);

    bool titleFieldEmpty() => titleController.text.isEmpty;
    bool commentFieldEmpty() => commentController.text.isEmpty;

    useEffect(
      () {
        titleController.addListener(
          () => isTitleEmpty.value = titleFieldEmpty(),
        );
        commentController.addListener(
          () => isCommentEmpty.value = commentFieldEmpty(),
        );
        return null;
      },
      [
        titleController,
        commentController,
      ],
    );

    return ListView(
      padding: const EdgeInsets.all(16),
      physics: const NeverScrollableScrollPhysics(),
      children: [
        const Gap(8),
        Text(
          'Create a new Issue on KosukeSaigusa/spajam-2022-final',
          style: context.displaySmall,
        ),
        const Gap(8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: context.displaySize.width * 0.4,
              child: ElevatedButton(
                onPressed: !isTitleEmpty.value || !isCommentEmpty.value
                    ? () {
                        titleController.clear();
                        commentController.clear();
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(32),
                    ),
                  ),
                ),
                child: const Text(
                  'Cancel',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(
              width: context.displaySize.width * 0.4,
              child: ElevatedButton(
                onPressed: !isCommentEmpty.value && !isTitleEmpty.value
                    ? () {
                        ref.read(createIssueProvider).call(
                              comment: commentController.text,
                              title: titleController.text,
                              onSuccess: () {
                                titleController.clear();
                                commentController.clear();
                              },
                            );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade500,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(32),
                    ),
                  ),
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
        const Gap(8),
        TextField(
          controller: titleController,
          decoration: InputDecoration(
            hintText: 'Title',
            hintStyle: context.headlineMedium,
            border: InputBorder.none,
          ),
        ),
        SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints.expand(height: context.displaySize.height * 0.6),
            child: TextField(
              controller: commentController,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                hintText: 'Leave a comment',
                hintStyle: context.headlineSmall,
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
