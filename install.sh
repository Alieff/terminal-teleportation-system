# create directory to store data
mkdir -p "$HOME/Documents/.script/database"
installer_path="$(dirname ${BASH_SOURCE[0]})"
destination_path="$HOME/Documents/.script"

# register the script for auto source
if [[ -z "$(cat $HOME/.bashrc | grep teleportation_system)" ]]; then 
  # copy source
  "cp" "$installer_path/teleportation_system.sh" "$destination_path"
  echo "Copying done" : "cp $installer_path/teleportation_system.sh" "$destination_path"

  # add auto source script
  echo "# teleportation_system" >> $HOME/.bashrc
  "echo" "source $HOME/Documents/.script/teleportation_system.sh" >> $HOME/.bashrc
  echo "registering to bashrc done"

else # case if already installed
  echo 
  echo "Teleportation system is already installed"
  echo
fi
