class_name ItemComponent
extends Resource

var id : String

@export var name : String
@export var texture : Texture2D
@export var weight : float
@export_multiline var description : String
@export var stacksize : int

@export var is_flamable : bool = false
@export var is_equipable : bool = false
