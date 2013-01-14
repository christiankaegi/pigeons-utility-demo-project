package shell.model {
import net.kaegi.utilities.pigeons.Pigeonry;

import org.puremvc.as3.multicore.interfaces.IProxy;
import org.puremvc.as3.multicore.patterns.proxy.Proxy;

import shell.App;

public class AppProxy extends Proxy implements IProxy {
	public static const NAME:String = 'AppProxy';

	public function AppProxy(data:Object = null) {
		super(NAME, data);
	}

	public function get vo():AppVO {
		return AppVO(data) as AppVO;
	}

	public function get app():App {
		return vo.app;
	}

	public function get pigeonry():Pigeonry {
		return Pigeonry.getInstance();
	}
}
}