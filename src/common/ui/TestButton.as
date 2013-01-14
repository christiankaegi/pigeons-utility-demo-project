package common.ui {
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

import org.osflash.signals.Signal;

/**
 * @author Christian Kaegi
 */

public class TestButton extends Sprite {
	public static const FONT:String = "_sans";
	public static const FONT_SIZE:uint = 12;
	public static const FONT_COLOR:Number = 0x000000;
	public static const BG_COLOR:Number = 0xCCCCCC;
	public var signalClick:Signal;
	//
	private static const MIN_WIDTH:uint = 20;
	private static const MIN_HEIGTH:uint = 15;
	//
	private var bg:Shape;
	private var textField:TextField;
	private var textFormat:TextFormat;
	//
	private var _label:String;
	private var _width:uint = MIN_WIDTH;
	private var _height:uint = MIN_HEIGTH;
	private var _enabled:Boolean = true;

	public function TestButton(label:String) {
		super();
		_label = label;
		createTextFormat();
		createLabel();
		setSize();
		createBg();
		signalClick = new Signal(String);
		addEventListener(MouseEvent.CLICK, clickHandler);
		this.buttonMode = true;
	}

	public function set enabled(value:Boolean):void {
		_enabled = value;
		if (_enabled) {
			this.alpha = 1;
		} else {
			this.alpha = 0.5;
		}
		this.buttonMode = _enabled;
	}

	public function get enabled():Boolean {
		return _enabled;
	}

	private function createTextFormat():void {
		textFormat = new TextFormat();
		textFormat.font = FONT;
		textFormat.color = FONT_COLOR;
		textFormat.size = FONT_SIZE;
	}

	private function createLabel():void {
		textField = new TextField();
		textField.defaultTextFormat = textFormat;
		textField.autoSize = TextFieldAutoSize.LEFT;
		textField.multiline = true;
		textField.wordWrap = false;
		textField.text = _label;
		textField.mouseEnabled = false;
		addChild(textField);
	}

	private function setSize():void {
		_width = textField.width + 5;
		_height = textField.height + 5;
		if (_width < MIN_WIDTH) _width = MIN_WIDTH;
		if (_height < MIN_HEIGTH) _height = MIN_HEIGTH;
	}

	private function createBg():void {
		bg = getRectangle(_width, _height, BG_COLOR);
		addChildAt(bg, 0);
		positionTextField();
	}

	private function positionTextField():void {
		textField.x = _width / 2 - textField.width / 2;
		textField.y = _height / 2 - textField.height / 2;
	}

	private function getRectangle(width:uint, height:uint, color:Number = 0xCCCCCC):Shape {
		var shape:Shape = new Shape();
		shape.graphics.beginFill(color, alpha);
		shape.graphics.drawRect(0, 0, width, height);
		shape.graphics.endFill();
		return shape;
	}

	private function clickHandler(event:MouseEvent):void {
		if (_enabled) signalClick.dispatch(this.name);
	}

}
}
