
#----------------------------------------------------------------------------------- FEATURE - TELEPORTATION

TELEPORTATION_SYSTEM_DB_PATH="$HOME/Documents/.script/database"

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

  global_context=$(cat $TELEPORTATION_SYSTEM_DB_PATH/teleporter_GLOBAL_CONTEXT)
  # echo $(cat $TELEPORTATION_SYSTEM_DB_PATH/teleporter_GLOBAL_CONTEXT)
  if [ ! -z "$local_context" ]; then
    cat -n $TELEPORTATION_SYSTEM_DB_PATH/teleporter_$local_context
  else
    cat -n $TELEPORTATION_SYSTEM_DB_PATH/teleporter_$global_context
  fi
}

# membuat konteks baru 
# cara pakai : `put_context _nama_konteks(string)_`
function put_context(){
  if [ ! -d "$TELEPORTATION_SYSTEM_DB_PATH" ]; then
    mkdir -p "$TELEPORTATION_SYSTEM_DB_PATH";
  fi
  list_manager $TELEPORTATION_SYSTEM_DB_PATH/teleporter_CONTEXT $1 $2 
  touch $TELEPORTATION_SYSTEM_DB_PATH/teleporter_$1
}
alias clist="cat -n $TELEPORTATION_SYSTEM_DB_PATH/teleporter_CONTEXT"
# alias cclear="echo > $TELEPORTATION_SYSTEM_DB_PATH/teleporter_CONTEXT; 
# rm $TELEPORTATION_SYSTEM_DB_PATH/teleporter_*'


# mengguks yang sudah ada 
# cara pakai : `use_context _nama_konteks(string)_`
function use_context(){
  if [ ! -d "$TELEPORTATION_SYSTEM_DB_PATH" ]; then
    mkdir -p "$TELEPORTATION_SYSTEM_DB_PATH";
  fi
  if [ "$#" -lt 1 ]; then
    local num=1
  else
    local num=$1
  fi
  local_context=$(sed "${num}q;d;" $TELEPORTATION_SYSTEM_DB_PATH/teleporter_CONTEXT)
  # set global context
  if [ "$#" -gt 1 ]; then 
    echo "$local_context">$TELEPORTATION_SYSTEM_DB_PATH/teleporter_GLOBAL_CONTEXT
    echo "\"$local_context\" diset menjadi global context "
  fi
  echo "context \"$local_context\" telah siap"
}

# function set_global_context(){
# if [ -z $context ]; then context=$(cat $TELEPORTATION_SYSTEM_DB_PATH/teleporter_GLOBAL_CONTEXT); fi

# membersihkan database context
# cara pakai : `clean_context_database`
function clean_context_database(){
  if [ ! -d "$TELEPORTATION_SYSTEM_DB_PATH" ]; then
    mkdir -p "$TELEPORTATION_SYSTEM_DB_PATH";
  fi
  for ii in $(ls $TELEPORTATION_SYSTEM_DB_PATH | grep teleporter_) ; do
    local hapus=1
    while read jj; do
      # jika ii ga ada di list, hapus
      if [ ! -z $jj ] && echo $ii | grep "$jj\|CONTEXT" > /dev/null; then
        local hapus=0
      fi
    done < "$TELEPORTATION_SYSTEM_DB_PATH/teleporter_CONTEXT"
    if [ $hapus -eq 1 ]; then
      rm $ii
    fi
  done 

}

# menyimpan current path dengan index tertentu ke konteks yang sedang dipakai  
# cara pakai : `bookmark _index(int)_`
function bookmark(){
  if [ ! -d "$TELEPORTATION_SYSTEM_DB_PATH" ]; then
    mkdir -p "$TELEPORTATION_SYSTEM_DB_PATH";
  fi
  local path=$(pwd | sed 's/\//\\\//g') 
  #echo $path
  list_manager $TELEPORTATION_SYSTEM_DB_PATH/teleporter_$global_context "$path" $1
}

# melihat daftar path pada current context
# cara pakai : `blist`
function blist(){
  if [ ! -d "$TELEPORTATION_SYSTEM_DB_PATH" ]; then
    mkdir -p "$TELEPORTATION_SYSTEM_DB_PATH";
  fi
  global_context=$(cat $TELEPORTATION_SYSTEM_DB_PATH/teleporter_GLOBAL_CONTEXT)
  # echo $(cat $TELEPORTATION_SYSTEM_DB_PATH/teleporter_GLOBAL_CONTEXT)

  if [ -z $TELEPORTATION_SYSTEM_DB_PATH/teleporter_$global_context ]; then 
    echo "context global / local belum di set"
  else
    if [ ! -z "$local_context" ]; then
      cat -n $TELEPORTATION_SYSTEM_DB_PATH/teleporter_$local_context
    else
      cat -n $TELEPORTATION_SYSTEM_DB_PATH/teleporter_$global_context
    fi
  fi
}
alias bclear="echo > $TELEPORTATION_SYSTEM_DB_PATH/teleporter_$context"

# cd ke path yang ada di blist 
# cara pakai : `teleport 2`, cd ke path yang ada di index ke 2 pada blist
function teleport(){
  if [ ! -d "$TELEPORTATION_SYSTEM_DB_PATH" ]; then
    mkdir -p "$TELEPORTATION_SYSTEM_DB_PATH";
  fi
  if [ "$#" -ne 1 ]; then
    local num=1
  else
    local num=$1
  fi
  global_context=$(cat $TELEPORTATION_SYSTEM_DB_PATH/teleporter_GLOBAL_CONTEXT)
  # echo $(cat $TELEPORTATION_SYSTEM_DB_PATH/teleporter_GLOBAL_CONTEXT)

  if [ ! -z "$local_context" ]; then
    local path=$(sed "${num}q;d;" $TELEPORTATION_SYSTEM_DB_PATH/teleporter_$local_context)
  else
    local path=$(sed "${num}q;d;" $TELEPORTATION_SYSTEM_DB_PATH/teleporter_$global_context)
  fi


  cd "$path"

}
