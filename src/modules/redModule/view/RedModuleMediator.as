package modules.redModule.view {
import modules.redModule.constant.AppConstants;
import modules.redModule.model.AppProxy;

import net.kaegi.utilities.pigeons.PigeonConstants;
import net.kaegi.utilities.pigeons.PigeonMessage;
import net.kaegi.utilities.pigeons.Pigeonry;

import org.puremvc.as3.multicore.interfaces.IMediator;
import org.puremvc.as3.multicore.interfaces.INotification;
import org.puremvc.as3.multicore.patterns.mediator.Mediator;

public class RedModuleMediator extends Mediator implements IMediator {
	public static const NAME:String = "RedModuleMediator";
	private var appProxy:AppProxy;

	public function RedModuleMediator(viewComponent:Object) {
		super(NAME, viewComponent);
	}

	override public function onRegister():void {
		appProxy = facade.retrieveProxy(AppProxy.NAME) as AppProxy;
		view.signalSendMessageToShell.add(sendMessageToShellHandler);
		view.signalSendMessageToBlueModule.add(sendMessageToBlueModuleHandler);
		view.init(appProxy.vo.title, appProxy.vo.width, appProxy.vo.height, appProxy.vo.backgroundColor);
		sendNotification(AppConstants.ADD_VIEW, view, NAME);
	}

	override public function onRemove():void {
		view.destroy();
	}

	private function get view():RedModule {
		return viewComponent as RedModule;
	}

	override public function listNotificationInterests():Array {
		var interests:Array = [];
		interests.push(PigeonConstants.MESSAGE);
		return interests;
	}

	override public function handleNotification(note:INotification):void {
		switch (note.getName()) {
			case PigeonConstants.MESSAGE :
				view.updateMessageOutput(appProxy.vo.pigeonCounter++, String(note.getBody()));
				break;
			default :
		}
	}

	private function sendMessageToShellHandler(message:String):void {
		appProxy.pigeonry.sendMessage([PigeonConstants.SHELL], PigeonConstants.MESSAGE, message);
	}

	private function sendMessageToBlueModuleHandler(message:String):void {
		appProxy.pigeonry.sendMessage(["BlueModule"], PigeonConstants.MESSAGE, message);
	}
}
}
