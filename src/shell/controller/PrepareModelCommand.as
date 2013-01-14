package shell.controller {
import org.puremvc.as3.multicore.interfaces.ICommand;
import org.puremvc.as3.multicore.interfaces.INotification;
import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

import shell.App;
import shell.model.AppProxy;
import shell.model.AppVO;

public class PrepareModelCommand extends SimpleCommand implements ICommand {
	override public function execute(note:INotification):void {
		var app:App = note.getBody() as App;
		facade.registerProxy(new AppProxy(new AppVO({app: app})));
	}
}
}