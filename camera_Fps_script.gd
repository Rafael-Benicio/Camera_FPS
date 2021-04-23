extends Camera

export var mouseVisible:bool= false
export(int, 50,1000,-1) var sensitivity =200;
onready var Yaw = get_parent()

func _ready():
	mouseVisibleToClick()
	set_process_input(true)
	set_process(true)

func _process(_delta):
	mouseVisibleToClick()
	
#Ser ou não possivel ver o cursor
func mouseVisibleToClick():
	if mouseVisible:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func look_updown_rotation(rotation = 0):
	var toReturn = self.get_rotation() + Vector3(rotation, 0, 0)
#	Inpedir que o player olhe para cima em uma curvatura acima de 90°
#	e nem para baixo em menos de 90°
	toReturn.x = clamp(toReturn.x, PI / -2, PI / 2)
	return toReturn

func look_leftright_rotation(rotation = 0):
#	virar para a esquera ou para a direita
	return Yaw.get_rotation() + Vector3(0, rotation, 0)

func mouse(event):
#	Usamos o node "Yaw" para setar a rotation de esquera e direita
#	isso impede de adicionar a rotation x para a rotation y
#	O qual iria criar uma sensasao de simulacao de voo 
	Yaw.set_rotation(look_leftright_rotation(event.relative.x / -sensitivity))
	
	self.set_rotation(look_updown_rotation(event.relative.y / -sensitivity))

func _input(event):
#	processa os movimentos do mouse
	if event is InputEventMouseMotion:
		if mouseVisible==false:
			return mouse(event)

func _leave_tree():
	"""
	Show the mouse when we leave
	"""
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
