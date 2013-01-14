package modules.redModule.model {
import modules.redModule.App;

public class AppVO {
	public var app:App;
	public var title:String = "I am 'Red Module' (built with PureMVC)"
	public var width:uint;
	public var height:uint;
	public var backgroundColor:Number = 0x990000;
	public var pigeonCounter:uint = 1;

	public function AppVO(data:Object):void {
		app = data.app;
		width = data.width;
		height = data.height;
	}

}
}
