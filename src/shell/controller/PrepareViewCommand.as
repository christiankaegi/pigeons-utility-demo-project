package shell.controller {
import org.puremvc.as3.multicore.interfaces.ICommand;
import org.puremvc.as3.multicore.interfaces.INotification;
import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

import shell.AppMediator;
import shell.constant.AppConstants;
import shell.model.AppProxy;
import shell.view.Background;
import shell.view.BackgroundMediator;
import shell.view.BlueModuleButtons;
import shell.view.BlueModuleButtonsMediator;
import shell.view.Header;
import shell.view.HeaderMediator;
import shell.view.RedModuleButtons;
import shell.view.RedModuleButtonsMediator;

public class PrepareViewCommand extends SimpleCommand implements ICommand {
	override public function execute(note:INotification):void {
		var appProxy:AppProxy = facade.retrieveProxy(AppProxy.NAME) as AppProxy;
		facade.registerMediator(new AppMediator(appProxy.app));
		facade.registerMediator(new BackgroundMediator(new Background()));
		facade.registerMediator(new HeaderMediator(new Header()));
		facade.registerMediator(new RedModuleButtonsMediator(new RedModuleButtons()));
		facade.registerMediator(new BlueModuleButtonsMediator(new BlueModuleButtons()));
		sendNotification(AppConstants.STARTUP_COMPLETE);
	}
}
}