if which swiftformat >/dev/null; then
  echo swiftformat $(cat .swiftformat | xargs) . | sh
else
  echo \"warning: SwiftFormat not installed, you should run `brew bundle` in the terminal\"
  exit 1
fi
