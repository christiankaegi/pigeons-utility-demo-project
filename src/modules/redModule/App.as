package modules.redModule {
import flash.display.Stage;
import flash.display.StageAlign;
import flash.display.StageScaleMode;

import modules.redModule.constant.AppConstants;

import net.kaegi.utilities.pigeons.IPigeonModule;
import net.kaegi.utilities.pigeons.PigeonMessage;
import net.kaegi.utilities.pigeons.PigeonModule;
import net.kaegi.utilities.pigeons.Pigeonry;

import org.puremvc.as3.multicore.patterns.facade.Facade;

[SWF(backgroundColor="#222222", frameRate="30", width="700", height="500")]
public class App extends PigeonModule implements IPigeonModule {

	private var facade:AppFacade;
	private var pigeonry:Pigeonry;

	public function App() {
		pigeonry = Pigeonry.getInstance();
		pigeonry.addModule(this);
		facade = AppFacade.getInstance(AppConstants.APP_NAME);
		if (parent is Stage) {
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			facade.startup(this, {width:350, height:300});
		}
	}

	override public function run(startupData:Object = null):void {
		facade.startup(this, startupData);
	}

	override public function get moduleName():String {
		return AppConstants.APP_NAME;
	}

	override public function destroy():void {
		Facade.removeCore(AppConstants.APP_NAME);
	}

	override public function handlePigeonMessage(message:PigeonMessage):void {
		facade.sendNotification(message.getName(), message.getBody(), message.getType());
	}
}
}
