part of 'terminal.dart';

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    App.init(context);
    final screenState = _ScreenState.s(context, true);
    final history = screenState.history;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(screenState.focusNode);
    });

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(screenState.focusNode),
      behavior: HitTestBehavior.translucent,
      child: Screen(
        padding: Space.sym(2.un(), 2.un()),
        child: ListView.builder(
          controller: screenState.scrollController,
          itemCount: history.length + 1,
          itemBuilder: (context, index) {
            if (index < history.length) {
              final command = history[index];
              return Linkify(
                text: command,
                linkStyle: AppText.s1.copyWith(
                  fontWeight: FontWeight.w900,
                  decoration: TextDecoration.underline,
                  color: AppTheme.primary,
                  decorationColor: AppTheme.primary,
                ),
                style: AppText.s1.copyWith(fontWeight: FontWeight.w900),
                onOpen: (link) => UrlService.launch(link.url),
              );
            } else {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${screenState.pathPrefix} ',
                    style: AppText.s1.copyWith(fontWeight: FontWeight.w900),
                  ),
                  Text(
                    '${screenState.fileSystem.currentDirectory.name} % ',
                    style: AppText.s1.copyWith(fontWeight: FontWeight.w900),
                  ),
                  Expanded(
                    child: TextField(
                      controller: screenState.controller,
                      autofocus: true,
                      style: AppText.s1.copyWith(fontWeight: FontWeight.w900),
                      cursorColor: AppTheme.primary,
                      textInputAction: TextInputAction.done,
                      onSubmitted: screenState.processCommand,
                      decoration: InputDecoration.collapsed(hintText: ''),
                      focusNode: screenState.focusNode,
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
