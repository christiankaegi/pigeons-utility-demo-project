package shell.view
{
import org.puremvc.as3.multicore.interfaces.IMediator;
import org.puremvc.as3.multicore.patterns.mediator.Mediator;

import shell.constant.AppConstants;
import shell.model.AppProxy;

public class BackgroundMediator extends Mediator implements IMediator
{
	public static const NAME:String = "BackgroundMediator";

	public function BackgroundMediator(viewComponent:Object)
	{
		super(NAME, viewComponent);
	}

	override public function onRegister():void
	{
		var appProxy:AppProxy = facade.retrieveProxy(AppProxy.NAME) as AppProxy;
		view.init(appProxy.vo.width, appProxy.vo.height, appProxy.vo.backgroundColor);
		sendNotification(AppConstants.ADD_VIEW, view, NAME);
	}

	override public function onRemove():void
	{
		view.destroy();
	}

	private function get view():Background
	{
		return viewComponent as Background;
	}

}
}
