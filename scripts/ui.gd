extends CanvasLayer

var timer_precission = 0.001

func stop_ui():
	$Timer.stop()
	$TimeLabel.text = ""
	$LapLabel.text = ""

func update_ui(laps_left):
	if $Timer.is_stopped():
		$TimeLabel.text = "Time: " + str(snappedf($Timer.time_left, timer_precission))
	else:
		$TimeLabel.text = "Time: " + str(snappedf($Timer.wait_time - $Timer.time_left, timer_precission))
	$LapLabel.text = "Laps left: " + str(laps_left)
