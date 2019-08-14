installer_path="$(dirname ${BASH_SOURCE[0]})"
destination_path="$HOME/Documents/.script"
script_name="teleportation_system.sh"


# remove executable
"rm" "$destination_path/$script_name"
echo "executable removed" : "rm $destination_path/$script_name" 

# remove autosource
sed -ie '/# teleportation_system.*/,+1d' $HOME/.bashrc
echo "autosource removed"

