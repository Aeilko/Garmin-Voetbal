import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;

class CustomBackground extends WatchUi.Drawable {

	private var _color = 0xED1C24; // Default is red
	
	// Added parameters: color (Number) - The background color used
	public function initialize(params as Dictionary) {
		Drawable.initialize(params);
		if(params.hasKey(:color)){
			self._color = params.get(:color) as Number;
		}
	}

	// Draws the background of the correct color
	function draw(dc as Dc) as Void {
		dc.setColor(self._color, self._color);
		dc.fillRectangle(0, 0, dc.getWidth(), dc.getHeight());
	}

	// Change the color
	function setColor(color as Number) as Void {
		self._color = color;
	}
}
