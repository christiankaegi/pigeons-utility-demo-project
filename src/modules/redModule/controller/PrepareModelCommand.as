package modules.redModule.controller {
import modules.redModule.App;
import modules.redModule.model.AppProxy;
import modules.redModule.model.AppVO;

import org.puremvc.as3.multicore.interfaces.ICommand;
import org.puremvc.as3.multicore.interfaces.INotification;
import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

public class PrepareModelCommand extends SimpleCommand implements ICommand {
	override public function execute(note:INotification):void {
		var app:App = note.getBody().app as App;
		var startupData:Object = note.getBody().startupData;
		var width:uint = startupData.width;
		var height:uint = startupData.height;
		facade.registerProxy(new AppProxy(new AppVO({app: app, width: width, height: height})));
	}
}
}