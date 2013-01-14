package shell.view
{
import common.ui.TestButton;

import flash.display.Sprite;

import org.osflash.signals.Signal;

public class BlueModuleButtons extends Sprite
{

	private static const SPACING:uint = 5;

	public var signalLoadModule:Signal;
	public var signalUnloadModule:Signal;
	public var signalSendMessageToModule:Signal;

	private var loadButton:TestButton;
	private var unloadButton:TestButton;
	private var sendMessageButton:TestButton;

	public function BlueModuleButtons()
	{
		signalLoadModule = new Signal();
		signalUnloadModule = new Signal();
		signalSendMessageToModule = new Signal(String);
	}

	/**
	 * Initialization
	 */
	public function init():void
	{
		createLoadButton();
		createUnloadButton();
		createSendMessageButton();
	}

	/**
	 * Module loaded: disable load button, enable unload button
	 */
	public function moduleLoaded(moduleName:String):void
	{
		switch (moduleName)
		{
			case "BlueModule" :
				loadButton.enabled = false;
				unloadButton.enabled = true;
				sendMessageButton.enabled = true;
				break;
			default :
		}
	}

	/**
	 * Module unloaded: enable load button, disable unload button
	 */
	public function moduleUnloaded(moduleName:String):void
	{
		switch (moduleName)
		{
			case "BlueModule" :
				loadButton.enabled = true;
				unloadButton.enabled = false;
				sendMessageButton.enabled = false;
				break;
			default :
		}
	}

	/**
	 * Create Buttons
	 */
	private function createLoadButton():void
	{
		loadButton = new TestButton("Load Module");
		loadButton.x = SPACING;
		loadButton.signalClick.add(loadModuleButtonClickHandler);
		addChild(loadButton);
	}

	private function createUnloadButton():void
	{
		unloadButton = new TestButton("Unload Module");
		unloadButton.x = loadButton.x + loadButton.width + SPACING;
		unloadButton.signalClick.add(unloadModuleButtonClickHandler);
		unloadButton.enabled = false;
		addChild(unloadButton);
	}

	/**
	 * Send Message
	 */
	private function createSendMessageButton():void
	{
		sendMessageButton = new TestButton("Send Message to Module");
		sendMessageButton.x = unloadButton.x + unloadButton.width + SPACING;
		sendMessageButton.signalClick.add(sendMessageButtonClickHandler);
		sendMessageButton.enabled = false;
		addChild(sendMessageButton);
	}

	/**
	 * Event Handler
	 */
	private function loadModuleButtonClickHandler(buttonName:String):void
	{
		signalLoadModule.dispatch();
	}

	private function unloadModuleButtonClickHandler(buttonName:String):void
	{
		signalUnloadModule.dispatch();
	}

	private function sendMessageButtonClickHandler(buttonName:String):void
	{
		signalSendMessageToModule.dispatch("Hello from the Shell!");
	}

	/**
	 * Clean up
	 */
	public function destroy():void
	{
		// TODO...
	}
}
}
