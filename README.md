# terminal-teleportation-system

move/cd to to your file destination quicker

## Usage : 
1. Specify an empty folder path, it will be used to store the data

    `TELEPORTATION_SYSTEM_DB_PATH="<enter the path here>"`

2. Create a `context`

    `put_context <choose_a_name>`

3. Use a `context`

    `use_context <your_choosen_name>`

4. Bookmark a location

    `bookmark 1`

    (you can bookmark more than one place by just specifying the number)

5. Go to your bookmarked location using `teleport`

    `teleport 1`

## Additional Usage :

1. blist : show list of bookmarked path
2. clist : show list of created context
3. clean_context_database : clear context database
4. context : see help

## Installation :

1. Downlod teleportation_system.sh
2. add this line into your `bashrc` 

    `source  <your-path>/teleportation_system.vim`

## License : 
GNU GPL


## TODO : 
- Convert the script to go-lang, so this could be used on any platform

