package shell.view
{
import flash.display.Shape;
import flash.display.Sprite;

public class Background extends Sprite
{

	private var bg:Shape;

	public function Background()
	{
	}

	public function init(width:uint, height:uint, bgColor:Number):void
	{
		createBackground(width, height, bgColor);
	}

	private function createBackground(width:uint, height:uint, bgColor:Number):void
	{
		bg = new Shape();
		bg.graphics.beginFill(bgColor);
		bg.graphics.drawRect(0, 0, width, height);
		bg.graphics.endFill();
		addChild(bg);
	}

	public function destroy():void
	{
		removeChild(bg);
		bg = null;
	}
}
}
