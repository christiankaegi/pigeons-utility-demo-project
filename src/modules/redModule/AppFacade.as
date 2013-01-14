package modules.redModule {
import modules.redModule.constant.AppConstants;
import modules.redModule.controller.StartupCommand;

import org.puremvc.as3.multicore.interfaces.IFacade;
import org.puremvc.as3.multicore.patterns.facade.Facade;

public class AppFacade extends Facade implements IFacade {

	public function AppFacade(key:String) {
		super(key);
	}

	public static function getInstance(key:String):AppFacade {
		if (instanceMap[ key ] == null) instanceMap[ key ] = new AppFacade(key);
		return instanceMap[ key ] as AppFacade;
	}

	public function startup(app:App, startupData:Object):void {
		sendNotification(AppConstants.STARTUP, {app: app, startupData: startupData});
	}

	override protected function initializeController():void {
		super.initializeController();
		registerCommand(AppConstants.STARTUP, StartupCommand);
	}
}
}