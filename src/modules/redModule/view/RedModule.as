package modules.redModule.view {
import common.ui.TestButton;

import flash.display.Shape;
import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

import org.osflash.signals.Signal;

public class RedModule extends Sprite {

	public var signalSendMessageToShell:Signal;
	public var signalSendMessageToBlueModule:Signal;
	private static const SPACING:uint = 5;
	private var title:TextField;
	private var bg:Shape;
	private var messagesFromShellOutput:TextField;
	private var _width:uint;
	private var _height:uint;

	public function RedModule() {
		signalSendMessageToShell = new Signal(String);
		signalSendMessageToBlueModule = new Signal(String);
	}

	// -----------------------------------------------------------------------------------------------------
	// Initialization 
	// -----------------------------------------------------------------------------------------------------
	public function init(title:String, width:uint, height:uint, bgColor:Number):void {
		_width = width;
		_height = height;
		createBackground(bgColor);
		createTitle(title);
		createMessagesFromShellOutput();
		createSendMessageToShellButton();
		createSendMessageToBlueModuleButton();
	}

	// -----------------------------------------------------------------------------------------------------
	// Create Background 
	// -----------------------------------------------------------------------------------------------------
	private function createBackground(bgColor:Number = 0xFF0000):void {
		bg = new Shape();
		bg.graphics.beginFill(bgColor);
		bg.graphics.drawRect(0, 0, _width, _height);
		bg.graphics.endFill();
		addChild(bg);
	}

	// -----------------------------------------------------------------------------------------------------
	// Create Title 
	// -----------------------------------------------------------------------------------------------------
	private function createTitle(text:String):void {
		var fmt:TextFormat = new TextFormat();
		fmt.font = "_sans";
		fmt.color = 0xFFFFFF;
		fmt.size = 16;
		title = new TextField();
		title.defaultTextFormat = fmt;
		title.text = text;
		title.autoSize = TextFieldAutoSize.LEFT;
		title.y = 10;
		title.x = bg.x + bg.width * 0.5 - title.width * 0.5;
		addChild(title);
	}

	// -----------------------------------------------------------------------------------------------------
	// Create Output Textfield to display messages from the shell
	// -----------------------------------------------------------------------------------------------------
	private function createMessagesFromShellOutput():void {
		var fmt:TextFormat = new TextFormat();
		fmt.font = "_sans";
		fmt.color = 0x00FF00;
		fmt.size = 12;
		messagesFromShellOutput = new TextField();
		messagesFromShellOutput.width = _width - 10;
		messagesFromShellOutput.height = _height - title.y - title.height - 70;
		messagesFromShellOutput.y = title.y + title.height + SPACING;
		messagesFromShellOutput.x = SPACING;
		messagesFromShellOutput.background = true;
		messagesFromShellOutput.backgroundColor = 0x000000;
		messagesFromShellOutput.defaultTextFormat = fmt;
		messagesFromShellOutput.text = "Waiting for messages from the Shell...";
		addChild(messagesFromShellOutput);
	}

	private function createSendMessageToShellButton():void {
		var sendMessageButton:TestButton = new TestButton("Send Message to Shell");
		sendMessageButton.x = _width * 0.5 - sendMessageButton.width * 0.5;
		sendMessageButton.y = bg.y + bg.height - 60;
		sendMessageButton.signalClick.add(sendMessageToShellButtonClickHandler);
		addChild(sendMessageButton);
	}

	private function sendMessageToShellButtonClickHandler(buttonName:String):void {
		signalSendMessageToShell.dispatch("Howdy shell! Greetings from Red Module...");
	}

	private function createSendMessageToBlueModuleButton():void {
		var sendMessageButton:TestButton = new TestButton("Send Message to Blue Module");
		sendMessageButton.x = _width * 0.5 - sendMessageButton.width * 0.5;
		sendMessageButton.y = bg.y + bg.height - 30;
		sendMessageButton.signalClick.add(sendMessageToBlueModuleButtonClickHandler);
		addChild(sendMessageButton);
	}

	private function sendMessageToBlueModuleButtonClickHandler(buttonName:String):void {
		signalSendMessageToBlueModule.dispatch("Hi Blue Module: Greetings from Red Module!");
	}

	public function updateMessageOutput(pigeonCounter:uint, message:String):void {
		if (messagesFromShellOutput.text.substr(0, 7) == "Waiting") {
			messagesFromShellOutput.text = pigeonCounter + ": " + message + "\n";
		} else {
			messagesFromShellOutput.text = pigeonCounter + ": " + message + "\n" + messagesFromShellOutput.text;
		}
	}

	// ************************************************************************************************************
	//
	// Clean up
	//
	// ************************************************************************************************************
	public function destroy():void {
		// TODO: clean up, remove event handlers etc.
	}
}
}
