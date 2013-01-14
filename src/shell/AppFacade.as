package shell
{
import org.puremvc.as3.multicore.interfaces.IFacade;
import org.puremvc.as3.multicore.patterns.facade.Facade;

import shell.constant.AppConstants;
import shell.controller.StartupCommand;

public class AppFacade extends Facade implements IFacade
{

	public function AppFacade(key:String)
	{
		super(key);
	}

	public static function getInstance(key:String):AppFacade
	{
		if (instanceMap[ key ] == null) instanceMap[ key ] = new AppFacade(key);
		return instanceMap[ key ] as AppFacade;
	}

	public function startup(stage:Object):void
	{
		sendNotification(AppConstants.STARTUP, stage);
	}

	override protected function initializeController():void
	{
		super.initializeController();
		registerCommand(AppConstants.STARTUP, StartupCommand);
	}
}
}