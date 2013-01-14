/**
 * @author: Christian Kaegi
 */

package modules.blueModule
{
import common.ui.TestButton;

import flash.display.Shape;
import flash.display.Stage;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

import net.kaegi.utilities.pigeons.IPigeonModule;
import net.kaegi.utilities.pigeons.PigeonConstants;
import net.kaegi.utilities.pigeons.PigeonMessage;
import net.kaegi.utilities.pigeons.PigeonModule;
import net.kaegi.utilities.pigeons.Pigeonry;

import org.osflash.signals.Signal;

[SWF(backgroundColor="#222222", frameRate="30", width="700", height="500")]
public class App extends PigeonModule implements IPigeonModule
{

	public static var APP_NAME:String = "BlueModule";
	public var signalSendMessageToShell:Signal;

	private static var SPACING:uint = 5;
	private var bg:Shape;
	private var title:TextField;
	private var messagesFromShellOutput:TextField;
	private var pigeonCounter:uint = 1;
	private var pigeonry:Pigeonry;

	private var _width:uint;
	private var _height:uint;


	public function App()
	{
		signalSendMessageToShell = new Signal(String);
		pigeonry = Pigeonry.getInstance();
		pigeonry.addModule(this);
		if (parent is Stage)
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			startApp({width: 500, height: 300});
		}
	}

	private function startApp(startupData:Object):void
	{
		_width = startupData.width;
		_height = startupData.height;
		createBackground(0x000099);
		createTitle("I am 'Blue Module' (single class, no framework used)");
		createSendMessageToShellButton();
		createSendMessageToRedModuleButton();
		createMessagesFromShellOutput();
		// Let the Shell know that this module is now ready:
		pigeonry.sendMessage([PigeonConstants.SHELL], PigeonConstants.MODULE_READY, APP_NAME);
	}

	// ************************************************************************************************************
	//
	// Intercommunication: Pigeon Utility
	//
	// ************************************************************************************************************

	override public function run(startupData:Object = null):void
	{
		startApp(startupData);
	}

	override public function get moduleName():String
	{
		return APP_NAME;
	}

	override public function handlePigeonMessage(message:PigeonMessage):void
	{
		updateMessageOutput(pigeonCounter++, String(message.getBody()));
	}

	public function updateMessageOutput(pigeonCounter:uint, message:String):void
	{
		if (messagesFromShellOutput.text.substr(0, 7) == "Waiting")
		{
			messagesFromShellOutput.text = pigeonCounter + ": " + message + "\n";
		} else
		{
			messagesFromShellOutput.text = pigeonCounter + ": " + message + "\n" + messagesFromShellOutput.text;
		}
	}

	// -----------------------------------------------------------------------------------------------------
	// Create Background
	// -----------------------------------------------------------------------------------------------------
	private function createBackground(bgColor:Number):void
	{
		bg = new Shape();
		bg.graphics.beginFill(bgColor);
		bg.graphics.drawRect(0, 0, _width, _height);
		bg.graphics.endFill();
		addChild(bg);
	}

	// -----------------------------------------------------------------------------------------------------
	// Create Title
	// -----------------------------------------------------------------------------------------------------
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
		title.x = bg.x + bg.width * 0.5 - title.width * 0.5;
		addChild(title);
	}

	// -----------------------------------------------------------------------------------------------------
	// Create Output Textfield to display messages from the shell
	// -----------------------------------------------------------------------------------------------------
	private function createMessagesFromShellOutput():void
	{
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

	// -----------------------------------------------------------------------------------------------------
	// Create button to send messages to the Shell
	// -----------------------------------------------------------------------------------------------------
	private function createSendMessageToShellButton():void
	{
		var sendMessageButton:TestButton = new TestButton("Send Message to Shell");
		sendMessageButton.x = _width * 0.5 - sendMessageButton.width * 0.5;
		sendMessageButton.y = bg.y + bg.height - 60;
		sendMessageButton.signalClick.add(sendMessageToShellButtonClickHandler);
		addChild(sendMessageButton);
	}

	private function sendMessageToShellButtonClickHandler(buttonName:String):void
	{
		pigeonry.sendMessage([PigeonConstants.SHELL], PigeonConstants.MESSAGE, "Hi shell, hello from Blue Module!");
	}

	// -----------------------------------------------------------------------------------------------------
	// Create button to send messages to the Red Module
	// -----------------------------------------------------------------------------------------------------
	private function createSendMessageToRedModuleButton():void
	{
		var sendMessageButton:TestButton = new TestButton("Send Message to Red Module");
		sendMessageButton.x = _width * 0.5 - sendMessageButton.width * 0.5;
		sendMessageButton.y = bg.y + bg.height - 30;
		sendMessageButton.signalClick.add(sendMessageToRedModuleButtonClickHandler);
		addChild(sendMessageButton);
	}

	private function sendMessageToRedModuleButtonClickHandler(buttonName:String):void
	{
		pigeonry.sendMessage(["RedModule"], PigeonConstants.MESSAGE, "Hello Red Module, it's me: Blue Module!");
	}

	// ************************************************************************************************************
	//
	// Clean up
	//
	// ************************************************************************************************************
	override public function destroy():void
	{
		// TODO: clean up, remove event handlers etc.
	}

}
}
