#!/bin/bash

# Corlos for messages
RED="\033[38;5;167m"
NC="\033[0m" # Reset colors

# Logo function
print_logo() {
  echo "                                                                                                                                                    ";
  echo "██████╗ ███████╗ █████╗  ██████╗████████╗    ███╗   ██╗ █████╗ ████████╗██╗██╗   ██╗███████╗    ███╗   ███╗ ██████╗ ██████╗ ███████╗██╗     ███████╗";
  echo "██╔══██╗██╔════╝██╔══██╗██╔════╝╚══██╔══╝    ████╗  ██║██╔══██╗╚══██╔══╝██║██║   ██║██╔════╝    ████╗ ████║██╔═══██╗██╔══██╗██╔════╝██║     ██╔════╝";
  echo "██████╔╝█████╗  ███████║██║        ██║       ██╔██╗ ██║███████║   ██║   ██║██║   ██║█████╗      ██╔████╔██║██║   ██║██║  ██║█████╗  ██║     █████╗  ";
  echo "██╔══██╗██╔══╝  ██╔══██║██║        ██║       ██║╚██╗██║██╔══██║   ██║   ██║╚██╗ ██╔╝██╔══╝      ██║╚██╔╝██║██║   ██║██║  ██║██╔══╝  ██║     ██╔══╝  ";
  echo "██║  ██║███████╗██║  ██║╚██████╗   ██║       ██║ ╚████║██║  ██║   ██║   ██║ ╚████╔╝ ███████╗    ██║ ╚═╝ ██║╚██████╔╝██████╔╝███████╗███████╗███████╗";
  echo "╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝ ╚═════╝   ╚═╝       ╚═╝  ╚═══╝╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═══╝  ╚══════╝    ╚═╝     ╚═╝ ╚═════╝ ╚═════╝ ╚══════╝╚══════╝╚══════╝";
  echo "                                                                                                                                                    ";

}

# Function to display a message in blue
print_info() {
  if [ -z $2 ]; then
    echo
  fi

  echo -e "${BLUE}$1${NC} \c"
}

# Function to display a message in green
print_success() {
  if [ -z $2 ]; then
    echo
  fi

  echo -e "${GREEN}$1${NC}"
}

# Function to display a message in red
print_error() {
  if [ -z $2 ]; then
    echo
  fi

  echo -e "${RED}$1${NC}"
}

print_logo

print_error " _   _      _ _                                               _           _   ";
print_error "| | | |    | | |                                             (_)         | |  ";
print_error "| |_| | ___| | | ___    _ __   _____      __  _ __  _ __ ___  _  ___  ___| |_ ";
print_error "|  _  |/ _ \ | |/ _ \  | '_ \ / _ \ \ /\ / / | '_ \| '__/ _ \| |/ _ \/ __| __|";
print_error "| | | |  __/ | | (_) | | | | |  __/\ V  V /  | |_) | | | (_) | |  __/ (__| |_ ";
print_error "\_| |_/\___|_|_|\___/  |_| |_|\___| \_/\_/   | .__/|_|  \___/| |\___|\___|\__|";
print_error "                                             | |            _/ |              ";
print_error "                                             |_|           |__/               ";

print_info "  ⌂"

echo "Welcome to the setup wizard for your new project"
echo

echo "  Please enter the Git repository address or your project name:"
ASK=$(print_success ">" 0)
read -p "$ASK " GIT_REPO

if [ -z "$GIT_REPO" ]; then
  print_error " ❌ No Git repository path or name specified."
  exit 1
fi

if [[ "$GIT_REPO" =~ \.git$ ]]; then
  if ! git ls-remote --exit-code "$GIT_REPO" >/dev/null 2>&1; then
    print_error " ❌ The Git repository does not exist or is inaccessible."
    exit 1
  fi

  git clone "$GIT_REPO"

  if [ $? -eq 0 ]; then
    TARGET_DIRECTORY=$(basename "$GIT_REPO" .git)
  else
    print_error " ❌ Failed to clone Git repository."
    exit 1
  fi
else
  TARGET_DIRECTORY="$GIT_REPO"
  mkdir "$TARGET_DIRECTORY"
fi

cd "./$TARGET_DIRECTORY"

echo "Enter the name of your React Native project : " projectName

# Vérifier si un nom a été entré
if [[ -z "$projectName" ]]; then
  echo "Please enter a project name."
  exit 1
fi

npx @react-native-community/cli@latest init "$projectName"

echo "✓ The project $projectName was created successfully!"

print_info "  →"
echo "Installing dependencies with yarn"

DEPENDECIES=(
 "react-native-bootsplash",
 "react-native-gesture-handler",
 "react-native-permissions",
 "react-native-reanimated",
 "react-native-safe-area-context",
 "react-native-webview"
)

for DEP in "${DEPENDENCIES[@]}"
do
  print_info "  →"
  echo "Installing $DEP"
  yarn add "$DEP"
  if [ $? -eq 0]; then
    print_success "✓ $DEP was successfully installed"
  else
    print_error " ❌ Failed to install $DEP"
    exit 1
  fi
done

print_success "✓ Dependencies are installed"

print_info "  →"
echo "Generating the first commit"

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  git init
fi

git add .
git commit -m "Install React-modele-vite"

if git remote >/dev/null 2>&1; then
  git push
fi
print_success "✓ The first commit is validated"

print_info "  →"
echo "Opening the project in VS Code"
code .
print_success "✓ The project is open"

print_info "  →"
echo "Launching the server with yarn dev"
yarn dev --open