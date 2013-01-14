package shell.view
{

import net.kaegi.utilities.pigeons.PigeonConstants;

import org.puremvc.as3.multicore.interfaces.IMediator;
import org.puremvc.as3.multicore.interfaces.INotification;
import org.puremvc.as3.multicore.patterns.mediator.Mediator;

import shell.constant.AppConstants;
import shell.model.AppProxy;

public class BlueModuleButtonsMediator extends Mediator implements IMediator
{
	public static const NAME:String = "BlueModuleButtonsMediator";
	private var appProxy:AppProxy;

	public function BlueModuleButtonsMediator(viewComponent:Object)
	{
		super(NAME, viewComponent);
	}

	override public function onRegister():void
	{
		appProxy = facade.retrieveProxy(AppProxy.NAME) as AppProxy;
		view.signalLoadModule.add(loadModuleHandler);
		view.signalUnloadModule.add(unloadModuleHandler);
		view.signalSendMessageToModule.add(sendMessageToModuleHandler);
		view.init();
		sendNotification(AppConstants.ADD_VIEW, view, NAME);
	}

	override public function onRemove():void
	{
		view.destroy();
	}

	private function get view():BlueModuleButtons
	{
		return viewComponent as BlueModuleButtons;
	}

	override public function listNotificationInterests():Array
	{
		var interests:Array = [];
		interests.push(PigeonConstants.MODULE_LOADED);
		interests.push(PigeonConstants.MODULE_UNLOADED);
		return interests;
	}

	override public function handleNotification(note:INotification):void
	{
		switch (note.getName())
		{
			case PigeonConstants.MODULE_LOADED:
				view.moduleLoaded(String(note.getBody()));
				break;
			case PigeonConstants.MODULE_UNLOADED :
				view.moduleUnloaded(String(note.getBody()));
				break;
			default :
		}
	}

	private function loadModuleHandler():void
	{
		sendNotification(PigeonConstants.LOAD_MODULE, "BlueModule");
	}

	private function unloadModuleHandler():void
	{
		sendNotification(PigeonConstants.UNLOAD_MODULE, "BlueModule");
	}

	private function sendMessageToModuleHandler(message:String):void
	{
		appProxy.pigeonry.sendMessage(["BlueModule"], PigeonConstants.MESSAGE, message);
	}

}
}
