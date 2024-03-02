
class_name GraphFunctions

static func wave(u, v, t):
	var p = Vector3.ZERO
	p.x = u
	p.y = sin(PI * (u + v + t))
	p.z = v
	return p

static func multiwave(u, v, t):
	var p = Vector3.ZERO
	p.x = u
	p.y = sin(PI * (u + 0.5 * t))
	p.y += 0.5 * sin(2.0 * PI * (v + t))
	p.y += sin(PI * (u + v + 0.25 * t))
	p.y *= 1.0 / 2.5
	p.z = v
	return p

static func ripple(u, v, t):
	var d = sqrt(u * u + v * v)
	var p = Vector3.ZERO
	p.x = u
	p.y = sin(PI * (4.0 * d - t))
	p.y /= 1.0 + 10.0 * d
	p.z = v
	return p
	
static func sphere(u, v, t):
	var pos = Vector3.ZERO
	var r = 0.9 + 0.1 * sin(PI * (6.0 * u + 4.0 * v + t))
	var s = r * cos(0.5 * PI * v)
	pos.x = s * sin(PI * u)
	pos.y = r * sin(PI * 0.5 * v)
	pos.z = s * cos(PI * u)
	return pos

static func torus(u, v, t):
	var pos = Vector3.ZERO
	var r1 = 0.7 + 0.1 * sin(PI * (6.0 * u + 0.5 * t))
	var r2 = 0.15 + 0.05 * sin(PI * (8 * u + 4 * v + 2 * t))
	var s = r1 + r2 * cos(PI * v)
	pos.x = s * sin(PI * u)
	pos.y = r2 * sin(PI * v)
	pos.z = s * cos(PI * u)
	return pos
