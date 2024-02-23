
class_name GraphFunctions

static func wave(x, t):
	return sin(PI * (x+t))

static func multiwave(x, t):
	var y = sin(PI * (x + 0.5 * t))
	y += 0.5 * sin(2.0 * PI * (x + t))
	return y