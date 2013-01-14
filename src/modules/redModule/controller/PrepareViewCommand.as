package modules.redModule.controller {
import modules.redModule.AppMediator;
import modules.redModule.constant.AppConstants;
import modules.redModule.model.AppProxy;
import modules.redModule.view.RedModule;
import modules.redModule.view.RedModuleMediator;

import org.puremvc.as3.multicore.interfaces.ICommand;
import org.puremvc.as3.multicore.interfaces.INotification;
import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

public class PrepareViewCommand extends SimpleCommand implements ICommand {
	override public function execute(note:INotification):void {
		var appProxy:AppProxy = facade.retrieveProxy(AppProxy.NAME) as AppProxy;
		facade.registerMediator(new AppMediator(appProxy.app));
		facade.registerMediator(new RedModuleMediator(new RedModule()));
		sendNotification(AppConstants.STARTUP_COMPLETE);
	}
}
}