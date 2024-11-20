import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;

using Toybox.Application.Storage;

class statsView extends TeamTextView {

	function initialize(teamID as Number) {
		TeamTextView.initialize(teamID);
	}

	protected function getLayout(dc as Dc) {
		return Rez.Layouts.StatsLayout(dc);
	}

	protected function updateText(){
		var team = (Storage.getValue(self._teamID) as Dictionary);
		if (team != null){
			var game = team["stats"] as Dictionary;
			if (game != null){
				var s = (game["stats"] as Dictionary);

				var opponent = (game["opponent"] as String);
				opponent = opponent + " " + (game["away"] ? "(U)" : "(T)");
				var oppView = (findDrawableById("TextOpponent") as WatchUi.Text);
				oppView.setText(opponent);

				for(var i = 0; i < s.keys().size(); i+=1){
					var key = s.keys()[i];
					var val = s.get(key) as Dictionary;
					
					var homeStat = (findDrawableById("Stat" + key + "Home") as WatchUi.Text);
					var awayStat = (findDrawableById("Stat" + key + "Away") as WatchUi.Text);
					homeStat.setText("" + val["home"]);
					awayStat.setText("" + val["away"]);
				}
			}
		}
	}
}
