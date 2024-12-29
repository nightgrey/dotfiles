# https://www.jetbrains.com/help/webstorm/2024.1/working-with-the-ide-features-from-command-line.html?Working_with_the_IDE_Features_from_Command_Line=&utm_source=product&utm_medium=link&utm_campaign=WS&utm_content=2024.1
export PATH="/opt/webstorm/bin:${PATH}"

webstorm() {
  # https://youtrack.jetbrains.com/issue/IJPL-1495/Starting-from-CLI-should-run-in-the-background-and-not-log-output-to-console
  nohup webstorm "$@" > /dev/null 2>&1 &
}