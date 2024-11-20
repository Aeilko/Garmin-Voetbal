import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;

using Toybox.Application.Storage;

class TeamTextView extends WatchUi.View {

	protected var _teamID as Number;

	// Constructor
	function initialize(teamID as Number) {
		View.initialize();
		self._teamID = teamID;
	}

	// Abstract method, return a Rez.Layouts.xxx(dc) instance
	protected function getLayout(dc as Dc) as Array<Drawable> or Null {
		return null;
	}
	// Abstract method, set the text of the layout
	protected function updateText() as Void { }

	// Load your resources here
	function onLayout(dc as Dc) as Void {
		// Basic layout
		setLayout(self.getLayout(dc));

		// Custom background color
		var bg = findDrawableById("Background") as CustomBackground;
		bg.setColor(voetbalApp.TEAM_COLORS[self._teamID]);
	}

	// Called when this View is brought to the foreground. Restore
	// the state of this View and prepare it to be shown. This includes
	// loading resources into memory.
	function onShow() as Void {
	}

	// Update the view
	function onUpdate(dc as Dc) as Void {
		// Set texts before drawing layout
		updateText();

		// Call the parent onUpdate function to redraw the layout
		View.onUpdate(dc);
	}

	// Called when this View is removed from the screen. Save the
	// state of this View here. This includes freeing resources from
	// memory.
	function onHide() as Void {
	}
}
