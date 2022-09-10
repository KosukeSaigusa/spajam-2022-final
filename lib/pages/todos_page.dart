import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_bdaya/flutter_datetime_picker_bdaya.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../features/auth/auth.dart';
import '../features/todo/todo.dart';
import '../models/todo.dart';
import '../repositories/firestore/todo_repository.dart';
import '../utils/extensions/build_context.dart';
import '../utils/extensions/date_time.dart';
import '../utils/loading.dart';
import '../utils/scaffold_messenger_service.dart';
import '../widgets/dialog.dart';

/// Todo 一覧ページ。
class TodosPage extends HookConsumerWidget {
  const TodosPage({super.key});

  static const path = '/todos';
  static const name = 'TodosPage';
  static const location = path;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(userIdProvider).value;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo 一覧'),
        actions: [
          IconButton(
            onPressed: () => ref.read(showTodoFilterDialogProvider)(),
            icon: const Icon(Icons.sort),
          ),
        ],
      ),
      body: userId == null
          ? const SizedBox()
          : ref.watch(todosStreamProvider).when(
                data: (todos) {
                  return ListView.separated(
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: todos.length,
                    padding: const EdgeInsets.all(16),
                    itemBuilder: (context, index) => TodoItem(todo: todos[index]),
                  );
                },
                error: (_, __) => const SizedBox(),
                loading: () => const PrimarySpinkitCircle(),
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await ref.read(scaffoldMessengerServiceProvider).showDialogByBuilder<void>(
                barrierDismissible: false,
                builder: (context) => AlertDialog(
                  title: const Text('Todo の作成'),
                  content: CommonAlertDialogContent(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const TodoTitleTextField(),
                        const Gap(16),
                        const TodoDescriptionTextField(),
                        const Gap(16),
                        const TodoDateTimePicker(),
                        const Gap(32),
                        const SubmitButton(),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('キャンセル', style: context.labelSmall),
                        ),
                      ],
                    ),
                  ),
                ),
              );
        },
        child: const FaIcon(FontAwesomeIcons.pen),
      ),
    );
  }
}

/// Todo のひとつひとつのウィジェット。
class TodoItem extends HookConsumerWidget {
  const TodoItem({
    super.key,
    required this.todo,
  });

  final Todo todo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TodoStatusBudge(todo: todo),
              Text(
                todo.title,
                style: context.titleLarge,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (todo.description.isNotEmpty) ...[
                const Gap(2),
                Text(
                  todo.description,
                  style: context.bodySmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              if (todo.dueDateTime != null) ...[
                const Gap(2),
                Text(
                  '期限：${todo.dueDateTime!.toYYYYMMDDHHMM()}',
                  style: context.bodySmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ]
            ],
          ),
        ),
        IconButton(
          onPressed: () => ref.read(todoRepositoryProvider).toggleTodoStatus(todo),
          icon: Icon(todo.iconData, color: todo.statusColor),
        ),
      ],
    );
  }
}

/// 完了 or 未完了 のバッジ。
class TodoStatusBudge extends StatelessWidget {
  const TodoStatusBudge({super.key, required this.todo});

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: todo.statusColor,
      ),
      child: Text(
        todo.statusLabel,
        style: context.labelSmall!.copyWith(color: Colors.white),
      ),
    );
  }
}

/// 絞り込み条件を選択する ModalBottomSheet を表示する処理を提供する Provider。
final showTodoFilterDialogProvider = Provider<Future<void> Function()>(
  (ref) => () async {
    final todoFilter =
        await ref.read(scaffoldMessengerServiceProvider).showModalBottomSheetByBuilder<TodoFilter>(
              builder: (context) => ListView(
                children: [
                  const Gap(16),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text('絞り込み条件を選択してください'),
                  ),
                  const Gap(16),
                  ...TodoFilter.values.map(
                    (todoFilter) => ListTile(
                      leading: ref.watch(todoFilterProvider) == todoFilter
                          ? Icon(
                              Icons.check_circle,
                              color: context.theme.primaryColor,
                            )
                          : Icon(
                              Icons.circle_outlined,
                              color: context.theme.disabledColor,
                            ),
                      title: Text(todoFilter.label),
                      onTap: () => Navigator.pop(context, todoFilter),
                    ),
                  ),
                ],
              ),
            );
    if (todoFilter == null) {
      return;
    }
    ref.read(todoFilterProvider.notifier).update((state) => todoFilter);
  },
);

/// Todo のタイトルを入力する TextField。
class TodoTitleTextField extends HookConsumerWidget {
  const TodoTitleTextField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      controller: ref.watch(todoFormStateNotifierProvider.notifier).titleController,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      cursorWidth: 1,
      decoration: const InputDecoration(
        hintText: 'タイトルを入力',
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.all(12),
        isDense: true,
        filled: false,
      ),
    );
  }
}

/// Todo の説明を入力する TextField。
class TodoDescriptionTextField extends HookConsumerWidget {
  const TodoDescriptionTextField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      controller: ref.watch(todoFormStateNotifierProvider.notifier).descriptionController,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.done,
      cursorWidth: 1,
      minLines: 3,
      maxLines: 5,
      decoration: const InputDecoration(
        hintText: '説明を入力（任意）',
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.all(12),
        isDense: true,
        filled: false,
      ),
    );
  }
}

/// 期限を選択する DateTimePicker。
class TodoDateTimePicker extends HookConsumerWidget {
  const TodoDateTimePicker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dueDateString = ref.watch(todoFormStateNotifierProvider).dueDateTime?.toJaYYYYMMDDHHMM();
    return Row(
      children: [
        const Text('期限'),
        TextButton(
          onPressed: () async {
            await DatePicker.showDateTimePicker(
              context,
              minTime: DateTime.now(),
              locale: LocaleType.jp,
              onConfirm: (dateTime) =>
                  ref.read(todoFormStateNotifierProvider.notifier).updateDueDate(dateTime),
            );
          },
          child: Text(dueDateString ?? '設定しない'),
        ),
      ],
    );
  }
}

/// Todo を作成するボタン。
class SubmitButton extends HookConsumerWidget {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () async {
        Navigator.pop(context);
        try {
          await ref.read(todoFormStateNotifierProvider.notifier).submit();
          ref.read(scaffoldMessengerServiceProvider).showSnackBar('作成しました。');
        } on Exception catch (e) {
          ref.read(scaffoldMessengerServiceProvider).showSnackBarByException(e);
        }
      },
      child: const Text('作成する'),
    );
  }
}
