Bezier.coffee
=====

A lightweight library for generating n-dimensional bezier curves with an arbitrary number of control points.
Curves are defined parametrically. `BezierPath` enables a curve to be exported as an SVG path.

Usage
=====

To generate a simple 2D bezier curve with two control points (with JavaScript):

Define the control points:
		
		var start = new Point(0, 0),
				end   = new Point(1, 1),
				cont1 = new Point(0.5, 0),
				cont2 = new Point(0.5, 1);

Define the curve:
		
		var curve = new BezierCurve(start, cont1, cont2, end);

Evaluate for specific t values:
		
		curve.evaluate(0).coords();    // => 0,0
		curve.evaluate(0.25).coords(); // => 0.3671875,0.0859375
		curve.evaluate(1).coords();    // => 1,1

Sample curve to generate SVG:
		
		var path = new BezierPath(curve);
		path.sample(); // => M0,0 L...

Reduce sample interval (default is 20 samples):
		
		path.sample(100); // => M0,0 L...

Generate a 'debug' path between the control points:

		path.control(); // => M0,0 L...

Now a 3D example of a bezier curve, this time with three control points (with CoffeeScript):

		points = [
			new Point 0,   0,   0  
			new Point 0.5, 0.5, 1  
			new Point 1,   0,   0.5
			new Point 1,   0.5, 0  
			new Point 1,   1,   1  
		]

		curve = new BezierCurve points...
		path  = new BezierPath curve

		path.sample 50 # => M0,0,0 L...
		path.control() # => M0,0,0 L...
		
Results in the following (green path is the control curve):

![3D bezier](/images/3d_bezier.png "A 3D bezier curve")

(Drawn with [SVG3d](https://code.google.com/p/svg3d/))
