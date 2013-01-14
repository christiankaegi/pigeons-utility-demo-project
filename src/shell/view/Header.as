package shell.view
{
import common.ui.TestButton;

import flash.display.Shape;
import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

import org.osflash.signals.Signal;

public class Header extends Sprite
{

	private static const SPACING:uint = 5;
	public var signalSendMessageToModules:Signal;
	private var title:TextField;
	private var messagesFromModulesOutput:TextField;
	private var _width:uint;
	private var _height:uint;

	public function Header()
	{
		signalSendMessageToModules = new Signal(String);
	}

	/**
	 * Initialization
	 */
	public function init(title:String, width:uint, height:uint):void
	{
		_width = width;
		_height = height;
		createTitle(title);
		createMessagesFromModulesOutput();
		createVerticalLine();
		createSendMessageToAllModulesButton();
	}

	/**
	 * Create Title
	 */
	private function createTitle(text:String):void
	{
		var fmt:TextFormat = new TextFormat();
		fmt.font = "_sans";
		fmt.color = 0xFFFFFF;
		fmt.size = 16;
		title = new TextField();
		title.defaultTextFormat = fmt;
		title.text = text;
		title.autoSize = TextFieldAutoSize.LEFT;
		title.y = 10;
		title.x = _width * 0.5 - title.width * 0.5;
		addChild(title);
	}

	/**
	 * Create Output Textfield to display messages from the modules
	 */
	private function createMessagesFromModulesOutput():void
	{
		var fmt:TextFormat = new TextFormat();
		fmt.font = "_sans";
		fmt.color = 0x00FF00;
		fmt.size = 12;
		messagesFromModulesOutput = new TextField();
		messagesFromModulesOutput.width = _width - 10;
		messagesFromModulesOutput.height = 100;
		messagesFromModulesOutput.y = title.y + title.height + SPACING;
		messagesFromModulesOutput.x = SPACING;
		messagesFromModulesOutput.background = true;
		messagesFromModulesOutput.backgroundColor = 0x000000;
		messagesFromModulesOutput.defaultTextFormat = fmt;
		messagesFromModulesOutput.text = "Waiting for messages from modules...";
		addChild(messagesFromModulesOutput);
	}

	/**
	 * Create vertical Line in the center
	 */
	private function createVerticalLine():void
	{
		var line:Shape = new Shape();
		line.graphics.lineStyle(1, 0xFFFFFF);
		var posY:int = messagesFromModulesOutput.y + messagesFromModulesOutput.height + SPACING;
		line.graphics.moveTo(_width * 0.5, posY);
		line.graphics.lineTo(_width * 0.5, _height - SPACING);
		addChild(line);
	}

	public function updateMessageOutput(pigeonCounter:uint, message:String):void
	{
		if (messagesFromModulesOutput.text.substr(0, 7) == "Waiting")
		{
			messagesFromModulesOutput.text = pigeonCounter + ": " + message + "\n";
		} else
		{
			messagesFromModulesOutput.text = pigeonCounter + ": " + message + "\n" + messagesFromModulesOutput.text;
		}
	}

	private function createSendMessageToAllModulesButton():void
	{
		var sendMessageButton:TestButton = new TestButton("Send Message to all Modules");
		sendMessageButton.x = _width * 0.5 - sendMessageButton.width * 0.5;
		sendMessageButton.y = 150;
		sendMessageButton.signalClick.add(sendMessageButtonClickHandler);
		addChild(sendMessageButton);
	}

	private function sendMessageButtonClickHandler(buttonName:String):void
	{
		signalSendMessageToModules.dispatch("Message from Shell to all Modules");
	}

	/**
	 * Clean up
	 */
	public function destroy():void
	{
	}
}
}
