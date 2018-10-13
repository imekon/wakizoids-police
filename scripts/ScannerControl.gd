extends Control

const TRACKING_WIDTH = 210
const TRACKING_HEIGHT = 150

var trackingRange = 10000.0
var trackingRange2 = trackingRange / 2.0
var trackingRatio = TRACKING_HEIGHT / trackingRange

func set_short_range_scan():
	trackingRange = 10000.0
	trackingRange2 = trackingRange / 2.0
	trackingRatio = TRACKING_HEIGHT / trackingRange
	
func set_long_range_scan():
	trackingRange = 65536.0
	trackingRange2 = trackingRange / 2.0
	trackingRatio = TRACKING_HEIGHT / trackingRange

func _process(delta):
	update()
	
func _draw():
	# draw a dot to signify the player
	var rect = Rect2(TRACKING_WIDTH / 2, TRACKING_HEIGHT / 2, 4, 4)
	var colour = Color(1.0, 0.0, 0.0, 0.7)
	draw_rect(rect, colour)

	# there's only one player but...
	var players = get_tree().get_nodes_in_group("player")
	var player = players[0]
	var playerPos = player.position
	var rocks = get_tree().get_nodes_in_group("rocks")
	for rock in rocks:
		var pos = rock.position
		var dist = playerPos.distance_to(pos)
		if dist < trackingRange2:
			var x = (pos.x - playerPos.x) * trackingRatio + TRACKING_WIDTH / 2
			var y = (pos.y - playerPos.y) * trackingRatio + TRACKING_HEIGHT / 2
			rect = Rect2(x - 1, y - 1, 3, 3)
			colour = Color(0.5, 0.5, 1.0, 0.7)
			draw_rect(rect, colour)
