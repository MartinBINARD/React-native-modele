# 📦 React Native Modele

## Description
A handcraft react native CLI allowing you to create a React native template to a remote repo.
It builds the template to your local folder and make the first commit,
then open the repo with VSCode.

## Overview

- Coming soon ...

## TOOLS

 - react
 - react-native
 - react-native-bootsplash
 - react-native-gesture-handler
 - react-native-permissions
 - react-native-reanimated
 - react-native-safe-area-context
 - react-native-webview

## Use

It's basically a copying/pasting the interesting parts
of the model in the project folder, without overwriting any specific files.

To create a modele template :

- go to the folder which will contain your new project

  > the repo `React-native-modele` **must** also be there.

- run the wizard to get the remote repository :

      ```
      cd dossier/my_repo
      # Example : ../../../my_personnal_repo

      # launch script
      ./React-native-modele/bin/install.sh
      # if necessary, give rights to this file :
      # `sudo chmod +x ./React-native-modele/bin/install.sh`

      # Give :
      #   - new project name
      #   - Git repo SSH address (ex : git@github.com:random-project.git)
      ```
