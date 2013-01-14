package shell
{
import flash.display.StageAlign;
import flash.display.StageScaleMode;

import net.kaegi.utilities.pigeons.IPigeonShell;
import net.kaegi.utilities.pigeons.PigeonMessage;
import net.kaegi.utilities.pigeons.PigeonShell;
import net.kaegi.utilities.pigeons.Pigeonry;

import shell.constant.AppConstants;

[SWF(backgroundColor="#222222", frameRate="30", width="1000", height="800")]
public class App extends PigeonShell implements IPigeonShell
{

	private var pigeonry:Pigeonry;
	private var facade:AppFacade;

	public function App()
	{
		pigeonry = Pigeonry.getInstance();
		pigeonry.addShell(this);
		facade = AppFacade.getInstance(AppConstants.APP_NAME);
		stage.scaleMode = StageScaleMode.NO_SCALE;
		stage.align = StageAlign.TOP_LEFT;
		facade.startup(this);
	}

	override public function handlePigeonMessage(message:PigeonMessage):void
	{
		facade.sendNotification(message.getName(), message.getBody(), message.getType());
	}
}
}
