@tool

const Importer = preload("../util/importer.gd")

static func pre_import(world_data: Dictionary, options: Dictionary):
    var importer := Importer.new(options.setup_script)

    if importer.load_script() != OK:
        return

    if importer.validate_method(&"_pre_import") == OK:
        importer.instance._pre_import(world_data)
