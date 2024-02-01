@tool

var script_path: String
var instance: Variant

var _script: GDScript

func _init(script_path: String):
    self.script_path = script_path

func load_script() -> Error:
    if script_path.is_empty():
        _script = null
        return ERR_DOES_NOT_EXIST

    var script: Script = load(script_path)
    if !script || !(script is GDScript):
        printerr("Post import script is not a GDScript.")
        _script = null
        return ERR_INVALID_PARAMETER

    _script = script
    instance = _script.new()
    return OK

func validate_method(method_name: StringName) -> Error:
    if instance == null:
        printerr("Import script not loaded.")
        return ERR_INVALID_PARAMETER

    if !instance.has_method(method_name):
        printerr("Import script does not have a '%d' method." % method_name)
        return ERR_INVALID_PARAMETER

    return OK

# TODO  remove this method
static func run(
    target: Variant,
    script_path: String,
    name: String,
) -> Variant:
    var _class_name: String = target.get_class()

    if !script_path.is_empty():
        var script = load(script_path)
        if !script || !(script is GDScript):
            printerr("Post import script is not a GDScript.")
            return ERR_INVALID_PARAMETER

        script = script.new()
        if !script.has_method("post_import"):
            printerr("World post import script does not have a 'post_import' method.")
            return ERR_INVALID_PARAMETER

        target = script.post_import(target)
        if target == null || target.get_class() != _class_name:
            printerr("[" + name + "]" +"Invalid scene returned from post import script.")
            return ERR_INVALID_DATA

    return target
