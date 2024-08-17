class_name Util
static func parseVector(vec: Vector2) -> String:
	return "(" + str(vec.x) + ", " + str(vec.y) + ")"
static func findChild (node: Node, clazz: String) -> Node:
	for i in range(0, node.get_children().size()):
		if (node.get_child(i).get_class() == clazz):
			return node.get_child(i)
	return null
