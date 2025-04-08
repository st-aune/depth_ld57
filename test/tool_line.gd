@tool
extends EditorScript




func _run() -> void:
	for node in get_editor_interface().get_selection().get_selected_nodes():
		if node.is_class("Polygon2D") : 
			draw_line(node)
			pass
		else:
			push_warning("You should select a Polygon2D node! Your class is " +  node.get_class())

func draw_line(node: Polygon2D):
	var line := (node.get_child(0) as Line2D)
	line.points = node.polygon
	line.closed = true
