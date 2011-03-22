package labs.ommenu {
	
	import ca.joelray.utils.Out;
	import ca.joelray.utils.stageutils.StageUtils;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import labs.ommenu.ui.Menu;
	import labs.ommenu.ui.MenuEvent;
	import labs.ommenu.utils.getMenuScrollAmount;
	
	// ===========================================================================================
	// SWF META ----------------------------------------------------------------------------------
	
	[SWF(width="1200", height="650", backgroundColor="0xcccccc", frameRate="60")]
	
	public class Main extends Sprite {
		
		// instances
		private var _menu:Menu;
		
		
		// ===========================================================================================
		// CONSTRUCTOR -------------------------------------------------------------------------------
		
		public function Main() {
			if(!stage) addEventListener(Event.ADDED_TO_STAGE, _onAddedToStage, false, 0, true);
			else _onAddedToStage();
		};
		
		
		// ===========================================================================================
		// INTERNAL interface ------------------------------------------------------------------------
		
		private function _createMenu():void {
			Out.info(this, "_createMenu");
			_menu = new Menu();
			_menu.addEventListener(MenuEvent.READY, _onMenuReady, false, 0, true);
			_menu.initialize();
			addChild(_menu);
		};
		
		// ===========================================================================================
		// EVENT interface ---------------------------------------------------------------------------
		
		private function _onAddedToStage($evt:Event = null):void {
			Out.enableAllLevels(true, true);
			Out.disableAllLevels();
			Out.clear();
			
			StageUtils.initialize( stage, stage.stageWidth, stage.stageHeight, null, "tl", "noScale", false, false );
			_createMenu();
		};
		
		
		private function _onMenuReady($evt:MenuEvent):void {
			StageUtils.stage.addEventListener(Event.ENTER_FRAME, _onEnterFrame, false, 0, true);
		};
		
		
		private function _onEnterFrame($evt:Event):void {
			_menu.slide(getMenuScrollAmount() * 20 * ( StageUtils.stage.mouseX > StageUtils.getCenterX() ? -1 : 1 ));
		};
		
	};
};