@tool

const Importer = preload("importer.gd")

static func run_post_import(element, script_path: String, source_file: String, name: String) -> Variant:
	return Importer.run(element, script_path, name)
