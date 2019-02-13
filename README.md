# terminal-teleportation-system

move/cd to to your file destination quicker

## Dependency

1. bash-extension

## Installation

1. execute 

    ``bash install.sh``

## Usage / Workflow : 
1. Create a `platform`. ("platform" is like category that contain a set of "bookmarked location")

    `platform_new <choose_a_name> <index>`

    example

    `platform_new "project" 1`

3. Use a `platform`

    `platform <index> <is_global:optional>`

    example
    
    `platform 1 yes`

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

## Other Command: 

1. Show help

    `teleportation_system`

2. Show all platform

    `platform`

3. Show all portal

    `teleport`

4. Clear all portal

    `portal_clear`


## License : 
GNU GPL


## TODO : 
- Convert the script to go-lang, so this library could be used on any OS

## Contribution

Found bugs, want to contribute, etc?, 
contact me : serdralfs@gmail.com
