import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.System;

using Toybox.Application.Storage;
using Toybox.Time;
using Toybox.Time.Gregorian;

class voetbalView extends WatchUi.View {

	function initialize() {
		View.initialize();
	}

	// Load your resources here
	function onLayout(dc as Dc) as Void {
		// Basic layout
		setLayout(Rez.Layouts.MainLayout(dc));

		// Load data from storage
		var data = (Storage.getValue("data") as Dictionary);
		if (data != null){
			var game = (data["game"] as Dictionary);

			var opponent = (game["opponent"] as String);
			opponent = opponent + " " + (game["away"] ? "(U)" : "(T)");
			var oppView = (findDrawableById("TextOpponent") as WatchUi.Text);
			oppView.setText(opponent);

			var ko = (game["kick-off"] as Number);
			var time = new Time.Moment(ko);
			var date = Gregorian.info(time, Time.FORMAT_SHORT);
			var timeView = (findDrawableById("TextTime") as WatchUi.Text);
			timeView.setText(Lang.format("$1$/$2$ $3$:$4$", [date.day, date.month.format("%02d"), date.hour.format("%02d"), date.sec.format("%02d")]));
		}
	}

	// Called when this View is brought to the foreground. Restore
	// the state of this View and prepare it to be shown. This includes
	// loading resources into memory.
	function onShow() as Void {
	}

	// Update the view
	function onUpdate(dc as Dc) as Void {
		// Call the parent onUpdate function to redraw the layout
		View.onUpdate(dc);
	}

	// Called when this View is removed from the screen. Save the
	// state of this View here. This includes freeing resources from
	// memory.
	function onHide() as Void {
	}
}
