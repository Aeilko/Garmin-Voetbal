import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;

class TeamLogo extends WatchUi.Drawable {

	private var _teamID = 197; // Default is PSV
	
	// Added parameters: teamID (Number) - The ID of the team
	public function initialize(params as Dictionary) {
		Drawable.initialize(params);
		if(params.hasKey(:teamID)){
			self._teamID = params.get(:teamID) as Number;
		}
	}

	// Draws the background of the correct color
	function draw(dc as Dc) as Void {
		var logo_width = loadResource(voetbalApp.TEAM_LOGOS[self._teamID]).getWidth();
		var logo = new WatchUi.Bitmap({
			:rezId => voetbalApp.TEAM_LOGOS[self._teamID],
			:locX => dc.getWidth()/2 - logo_width/2,
			:locY => 5,
		});
		logo.draw(dc);
	}

	// Change the color
	function setTeam(teamID as Number) as Void {
		self._teamID = teamID;
	}
}
