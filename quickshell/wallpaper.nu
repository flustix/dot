def main [x: string] {
    list_and_display $x
}

def list_and_display [path: string] {
    let files = ls -f $path;

    let names = $files | sort-by type name -i | each {
       $in.name
    }

    let items = $names | to text;
    select_item ($items | vicinae dmenu)
}

def select_item [path: string] {
    let type = $path | path type

    if $type == "dir" {
        list_and_display $path
    } else if $type == "file" {
        matugen image $path
    }
}