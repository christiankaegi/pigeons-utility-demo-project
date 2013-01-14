package modules.redModule {
import flash.display.DisplayObject;

import modules.redModule.constant.AppConstants;
import modules.redModule.model.AppProxy;

import net.kaegi.utilities.pigeons.PigeonConstants;

import org.puremvc.as3.multicore.interfaces.IMediator;
import org.puremvc.as3.multicore.interfaces.INotification;
import org.puremvc.as3.multicore.patterns.mediator.Mediator;

public class AppMediator extends Mediator implements IMediator {
	public static const NAME:String = 'AppMediator';
	private var appProxy:AppProxy;

	public function AppMediator(viewComponent:App) {
		super(NAME, viewComponent);
	}

	override public function onRegister():void {
		appProxy = facade.retrieveProxy(AppProxy.NAME) as AppProxy;
	}

	override public function listNotificationInterests():Array {
		var interests:Array = [];
		interests.push(AppConstants.STARTUP_COMPLETE);
		interests.push(AppConstants.ADD_VIEW);
		return interests;
	}

	override public function handleNotification(note:INotification):void {
		switch (note.getName()) {
			case AppConstants.STARTUP_COMPLETE:
				// Let the Shell know that this module is now ready:
				appProxy.pigeonry.sendMessage([PigeonConstants.SHELL], PigeonConstants.MODULE_READY, AppConstants.APP_NAME);
				break;
			case AppConstants.ADD_VIEW :
				var component:DisplayObject = DisplayObject(note.getBody());
				view.addChild(component);
				break;
		}
	}

	private function get view():App {
		return viewComponent as App;
	}

}
}