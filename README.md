# terminal-teleportation-system

move/cd to to your file destination quicker

## Installation

1. execute 

    ``bash install.sh``

## Usage / Workflow : 
1. Create a `portal group`. ("portal group" is like category that contain a set of portal)

    `new_portal_group <choose_a_name> <index>`

    example

    `new_portal_group project 1`

3. Use a `portal group`

    `portal_group <index> <set_global:optional>`

    example
    
    `portal_group 1 yes`

4. Bookmark a location. (save current path)

    `bookmark <index>`
    or 
    `mark <index>`

    example

    `mark 2`

    (you can bookmark more than one place by just specifying the number)

5. Go to your bookmarked location using `teleport`

    `teleport <index>`

    example
    
    `teleport 2`

## Other Comman: 

1. Show help

    `teleportation_system`

2. Show all portal group

    `portal_group`

3. Show all portal

    `teleport`

4. Clear all portal

    `portal_clear`


## License : 
GNU GPL


## TODO : 
- Convert the script to go-lang, so this library could be used on any OS
