package shell
{
import com.greensock.events.LoaderEvent;
import com.greensock.loading.SWFLoader;

import flash.display.DisplayObject;

import net.kaegi.utilities.pigeons.PigeonConstants;
import net.kaegi.utilities.pigeons.PigeonModule;

import org.puremvc.as3.multicore.interfaces.IMediator;
import org.puremvc.as3.multicore.interfaces.INotification;
import org.puremvc.as3.multicore.patterns.mediator.Mediator;

import shell.constant.AppConstants;
import shell.model.AppProxy;
import shell.view.BlueModuleButtonsMediator;
import shell.view.RedModuleButtonsMediator;

public class AppMediator extends Mediator implements IMediator
{
	public static const NAME:String = 'AppMediator';
	private var redModule:PigeonModule;
	private var redModuleLoader:SWFLoader;
	private var blueModule:PigeonModule;
	private var blueModuleLoader:SWFLoader;

	private var appProxy:AppProxy;

	public function AppMediator(viewComponent:App)
	{
		super(NAME, viewComponent);
	}

	override public function onRegister():void
	{
		appProxy = facade.retrieveProxy(AppProxy.NAME) as AppProxy;
	}

	override public function listNotificationInterests():Array
	{
		var interests:Array = [];
		interests.push(AppConstants.STARTUP_COMPLETE);
		interests.push(AppConstants.ADD_VIEW);
		interests.push(PigeonConstants.LOAD_MODULE);
		interests.push(PigeonConstants.UNLOAD_MODULE);
		return interests;
	}

	override public function handleNotification(note:INotification):void
	{
		switch (note.getName())
		{
			case AppConstants.STARTUP_COMPLETE:
				// Model and views of the Shell are ready now.
				break;
			case AppConstants.ADD_VIEW :
				var component:DisplayObject = DisplayObject(note.getBody());
				switch (note.getType())
				{
					case RedModuleButtonsMediator.NAME :
						component.y = 200;
						break;
					case BlueModuleButtonsMediator.NAME :
						component.x = appProxy.vo.width - component.width - 10;
						component.y = 200;
						break;
				}
				view.addChild(component);
				break;
			case PigeonConstants.LOAD_MODULE :
				switch (note.getBody())
				{
					case "RedModule" :
						redModuleLoader = new SWFLoader("RedModule.swf", {onComplete: redModuleLoadCompleteHandler, onError: redModuleLoadErrorHandler, autoDispose: true});
						redModuleLoader.load();
						break;
					case "BlueModule" :
						blueModuleLoader = new SWFLoader("BlueModule.swf", {onComplete: blueModuleLoadCompleteHandler, onError: blueModuleLoadErrorHandler, autoDispose: true});
						blueModuleLoader.load();
						break;
					default :
						// TODO Error handling, Module not found
						break;
				}
				break;
			case PigeonConstants.UNLOAD_MODULE :
				switch (note.getBody())
				{
					case "RedModule" :
						appProxy.pigeonry.removeModule(redModule);
						view.removeChild(redModule);
						redModule = null;
						sendNotification(PigeonConstants.MODULE_UNLOADED, note.getBody());
						break;
					case "BlueModule" :
						appProxy.pigeonry.removeModule(blueModule);
						view.removeChild(blueModule);
						blueModule = null;
						sendNotification(PigeonConstants.MODULE_UNLOADED, note.getBody());
						break;
				}
				break;
		}
	}

	private function get view():App
	{
		return viewComponent as App;
	}

	/**
	 * Red Module Message Handling
	 */
	private function redModuleLoadCompleteHandler(event:LoaderEvent):void
	{
		// SWFLoader has loaded the SWF and we have now access to the root of it:
		redModule = PigeonModule(redModuleLoader.rawContent) as PigeonModule;
		redModule.x = 5;
		redModule.y = 250;
		view.addChild(redModule);
		redModule.run({width: appProxy.vo.width * 0.5 - 10, height: 290});
		sendNotification(PigeonConstants.MODULE_LOADED, redModule.moduleName);
	}

	private function redModuleLoadErrorHandler(event:LoaderEvent):void
	{
		// TODO Error handling, Module could not be loaded, error message: event.text
	}

	/**
	 * Blue Module Message Handling
	 */
	private function blueModuleLoadCompleteHandler(event:LoaderEvent):void
	{
		// SWFLoader has loaded the SWF and we have now access to the root of it:
		blueModule = PigeonModule(blueModuleLoader.rawContent) as PigeonModule;
		blueModule.x = 405;
		blueModule.y = 250;
		view.addChild(blueModule);
		blueModule.run({width: appProxy.vo.width * 0.5 - 10, height: 290});
		sendNotification(PigeonConstants.MODULE_LOADED, blueModule.moduleName);
	}

	private function blueModuleLoadErrorHandler(event:LoaderEvent):void
	{
		// TODO Error handling, Module could not be loaded, error message: event.text
	}

}
}