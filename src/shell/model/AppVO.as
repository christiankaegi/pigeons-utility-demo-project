package shell.model {
import shell.App;

/**
 * @author Christian Kaegi
 */
public class AppVO {
	public var app:App;
	public var title:String = "Hello, I am the Shell (built with PureMVC)";
	public var width:uint = 800;
	public var height:uint = 545;
	public var backgroundColor:Number = 0x555555;
	public var pigeonCounter:uint = 1;

	public function AppVO(data:Object):void {
		app = data.app;
	}

}
}
