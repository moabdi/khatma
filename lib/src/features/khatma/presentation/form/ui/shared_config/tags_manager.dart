import 'package:flutter/material.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma_ui/constants/app_sizes.dart';

/// Widget for managing tags with add/remove functionality
///
/// Can be reused in any screen that needs tag management (max 5 tags)
class TagsManager extends StatefulWidget {
  const TagsManager({
    super.key,
    required this.tags,
    required this.onTagsChanged,
    this.maxTags = 5,
  });

  final List<String> tags;
  final ValueChanged<List<String>> onTagsChanged;
  final int maxTags;

  @override
  State<TagsManager> createState() => _TagsManagerState();
}

class _TagsManagerState extends State<TagsManager> {
  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  bool get _canAddMoreTags => widget.tags.length < widget.maxTags;

  void _addTag() {
    final tagText = _controller.text.trim();

    if (tagText.isEmpty) return;

    // Check if limit reached
    if (widget.tags.length >= widget.maxTags) {
      _showSnackBar(context.loc.maximumTagsAllowed);
      return;
    }

    // Check if tag already exists
    if (widget.tags.contains(tagText)) {
      _showSnackBar(context.loc.tagAlreadyExists);
      _controller.clear();
      _focusNode.requestFocus();
      return;
    }

    // Add the tag
    final updatedTags = List<String>.from(widget.tags)..add(tagText);
    widget.onTagsChanged(updatedTags);
    _controller.clear();

    // Keep focus if we can still add more tags
    if (widget.tags.length < widget.maxTags - 1) {
      _focusNode.requestFocus();
    }
  }

  void _removeTag(String tag) {
    final updatedTags = List<String>.from(widget.tags)..remove(tag);
    widget.onTagsChanged(updatedTags);
    _focusNode.requestFocus();
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Input field for new tags
        TextField(
          controller: _controller,
          focusNode: _focusNode,
          enabled: _canAddMoreTags,
          decoration: InputDecoration(
            labelText: context.loc.addTag,
            hintText: _canAddMoreTags
                ? context.loc.addTagHint
                : context.loc.maximumTagsReached,
            prefixIcon: const Icon(Icons.label),
            suffixIcon: _controller.text.isNotEmpty && _canAddMoreTags
                ? IconButton(
                    icon: const Icon(Icons.add_circle),
                    onPressed: _addTag,
                  )
                : null,
          ),
          textInputAction: TextInputAction.done,
          onSubmitted: (_) => _addTag(),
          onChanged: (_) => setState(() {}), // Rebuild to show/hide add button
        ),

        // Display existing tags as chips
        if (widget.tags.isNotEmpty) gapH16,
        if (widget.tags.isNotEmpty)
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: widget.tags.map((tag) {
              return Chip(
                label: Text(tag),
                deleteIcon: const Icon(Icons.close, size: 18),
                onDeleted: () => _removeTag(tag),
              );
            }).toList(),
          ),
      ],
    );
  }
}
