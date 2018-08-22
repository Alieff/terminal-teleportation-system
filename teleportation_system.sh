
#----------------------------------------------------------------------------------- FEATURE - TELEPORTATION

# melist command fitur "TELEPORTATION" dan melihat konteks sekarang
# untuk menggunakan fitur "TELEPORTATION", harus buat folder 
function context(){
  echo "-----------------------CONTEXT MANAGER"
  echo "put_context <nama_context> <index>"
  echo "clist"
  echo "get_context"
  echo "use_context <index> <set_global:optional>"
  echo "clean_context_database"
  echo "-----------------------TELEPORTER"
  echo "bookmark"
  echo "blist"
  echo "bclear"
  echo "teleport"

  global_context=$(cat $HOME/Documents/.script/database/teleporter_GLOBAL_CONTEXT)
  # echo $(cat $HOME/Documents/.script/database/teleporter_GLOBAL_CONTEXT)
  if [ ! -z "$local_context" ]; then
    cat -n $HOME/Documents/.script/database/teleporter_$local_context
  else
    cat -n $HOME/Documents/.script/database/teleporter_$global_context
  fi
}

# membuat konteks baru 
# cara pakai : `put_context _nama_konteks(string)_`
function put_context(){
  if [ ! -d "$HOME/Documents/.script/database" ]; then
    mkdir -p "$HOME/Documents/.script/database";
  fi
  list_manager $HOME/Documents/.script/database/teleporter_CONTEXT $1 $2 
  touch $HOME/Documents/.script/database/teleporter_$1
}
alias clist="cat -n $HOME/Documents/.script/database/teleporter_CONTEXT"
# alias cclear="echo > $HOME/Documents/.script/database/teleporter_CONTEXT; 
# rm $HOME/Documents/.script/database/teleporter_*'


# mengguks yang sudah ada 
# cara pakai : `use_context _nama_konteks(string)_`
function use_context(){
  if [ ! -d "$HOME/Documents/.script/database" ]; then
    mkdir -p "$HOME/Documents/.script/database";
  fi
  if [ "$#" -lt 1 ]; then
    local num=1
  else
    local num=$1
  fi
  local_context=$(sed "${num}q;d;" $HOME/Documents/.script/database/teleporter_CONTEXT)
  # set global context
  if [ "$#" -gt 1 ]; then 
    echo "$local_context">$HOME/Documents/.script/database/teleporter_GLOBAL_CONTEXT
    echo "\"$local_context\" diset menjadi global context "
  fi
  echo "context \"$local_context\" telah siap"
}

# function set_global_context(){
# if [ -z $context ]; then context=$(cat $HOME/Documents/.script/database/teleporter_GLOBAL_CONTEXT); fi

# membersihkan database context
# cara pakai : `clean_context_database`
function clean_context_database(){
  if [ ! -d "$HOME/Documents/.script/database" ]; then
    mkdir -p "$HOME/Documents/.script/database";
  fi
  for ii in $(ls $HOME/Documents/.script/database/ | grep teleporter_) ; do
    local hapus=1
    while read jj; do
      # jika ii ga ada di list, hapus
      if [ ! -z $jj ] && echo $ii | grep "$jj\|CONTEXT" > /dev/null; then
        local hapus=0
      fi
    done < "$HOME/Documents/.script/database/teleporter_CONTEXT"
    if [ $hapus -eq 1 ]; then
      rm $ii
    fi
  done 

}

# menyimpan current path dengan index tertentu ke konteks yang sedang dipakai  
# cara pakai : `bookmark _index(int)_`
function bookmark(){
  if [ ! -d "$HOME/Documents/.script/database" ]; then
    mkdir -p "$HOME/Documents/.script/database";
  fi
  local path=$(pwd | sed 's/\//\\\//g') 
  #echo $path
  list_manager $HOME/Documents/.script/database/teleporter_$global_context "$path" $1
}

# melihat daftar path pada current context
# cara pakai : `blist`
function blist(){
  if [ ! -d "$HOME/Documents/.script/database" ]; then
    mkdir -p "$HOME/Documents/.script/database";
  fi
  global_context=$(cat $HOME/Documents/.script/database/teleporter_GLOBAL_CONTEXT)
  # echo $(cat $HOME/Documents/.script/database/teleporter_GLOBAL_CONTEXT)

  if [ -z $HOME/Documents/.script/database/teleporter_$global_context ]; then 
    echo "context global / local belum di set"
  else
    if [ ! -z "$local_context" ]; then
      cat -n $HOME/Documents/.script/database/teleporter_$local_context
    else
      cat -n $HOME/Documents/.script/database/teleporter_$global_context
    fi
  fi
}
alias bclear="echo > $HOME/Documents/.script/database/teleporter_$context"

# cd ke path yang ada di blist 
# cara pakai : `teleport 2`, cd ke path yang ada di index ke 2 pada blist
function teleport(){
  if [ ! -d "$HOME/Documents/.script/database" ]; then
    mkdir -p "$HOME/Documents/.script/database";
  fi
  if [ "$#" -ne 1 ]; then
    local num=1
  else
    local num=$1
  fi
  global_context=$(cat $HOME/Documents/.script/database/teleporter_GLOBAL_CONTEXT)
  # echo $(cat $HOME/Documents/.script/database/teleporter_GLOBAL_CONTEXT)

  if [ ! -z "$local_context" ]; then
    local path=$(sed "${num}q;d;" $HOME/Documents/.script/database/teleporter_$local_context)
  else
    local path=$(sed "${num}q;d;" $HOME/Documents/.script/database/teleporter_$global_context)
  fi


  cd "$path"

}
