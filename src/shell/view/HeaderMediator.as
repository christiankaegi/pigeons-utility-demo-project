package shell.view
{

import net.kaegi.utilities.pigeons.PigeonConstants;

import org.puremvc.as3.multicore.interfaces.IMediator;
import org.puremvc.as3.multicore.interfaces.INotification;
import org.puremvc.as3.multicore.patterns.mediator.Mediator;

import shell.constant.AppConstants;
import shell.model.AppProxy;

public class HeaderMediator extends Mediator implements IMediator
{
	public static const NAME:String = "HeaderMediator";
	private var appProxy:AppProxy;

	public function HeaderMediator(viewComponent:Object)
	{
		super(NAME, viewComponent);
	}

	override public function onRegister():void
	{
		appProxy = facade.retrieveProxy(AppProxy.NAME) as AppProxy;
		view.signalSendMessageToModules.add(sendMessageToModulesHandler);
		view.init(appProxy.vo.title, appProxy.vo.width, appProxy.vo.height);
		sendNotification(AppConstants.ADD_VIEW, view, NAME);
	}

	override public function onRemove():void
	{
		view.destroy();
	}

	private function get view():Header
	{
		return viewComponent as Header;
	}

	override public function listNotificationInterests():Array
	{
		var interests:Array = [];
		interests.push(PigeonConstants.MODULE_READY);
		interests.push(PigeonConstants.MESSAGE);
		interests.push(PigeonConstants.MODULE_UNLOADED);
		return interests;
	}

	override public function handleNotification(note:INotification):void
	{
		switch (note.getName())
		{
			case PigeonConstants.MODULE_READY :
				view.updateMessageOutput(appProxy.vo.pigeonCounter++, "Module ready: " + String(note.getBody()));
				break;
			case PigeonConstants.MESSAGE :
				view.updateMessageOutput(appProxy.vo.pigeonCounter++, String(note.getBody()));
				break;
			case PigeonConstants.MODULE_UNLOADED :
				view.updateMessageOutput(appProxy.vo.pigeonCounter++, "Module unloaded: " + String(note.getBody()));
				break;
			default :
		}
	}

	private function sendMessageToModulesHandler(message:String):void
	{
		appProxy.pigeonry.sendMessage([PigeonConstants.ALL_MODULES], PigeonConstants.MESSAGE, message);
	}

}
}
