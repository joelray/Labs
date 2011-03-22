package labs.ommenu.ui {
	
	import ca.joelray.events.AnimationEvent;
	import ca.joelray.math.MathBase;
	import ca.joelray.utils.Out;
	import ca.joelray.utils.stageutils.StageUtils;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.setTimeout;
	
	import labs.ommenu.utils.getMenuScrollAmount;
	
	public class Menu extends Sprite {
		
		// props
		private var _isInit:Boolean = false;
		private var _offset:Number = 0;
		private var _diff:Number = 0;
		
		// instances
		private var _container:Sprite;
		
		
		// =======================================================================================================
		// CONSTRUCTOR -------------------------------------------------------------------------------------------
		
		public function Menu() {
			Out.status(this, "CONSTRUCTOR");
		};
		
		
		public function initialize():void {
			Out.info(this, "_initialize");
			_createContainer();
			_createThumbs();
			_animateIn();
		};
		
		
		public function slide($pos:Number):void {
			_offset = MathBase.clamp(_offset + $pos, -_getWidth() + StageUtils.stage.stageWidth, 0);
			if(!hasEventListener(Event.ENTER_FRAME)) addEventListener(Event.ENTER_FRAME, _onEnterFrame);
		};
		
		
		// =======================================================================================================
		// INTERNAL interface ------------------------------------------------------------------------------------
		
		private function _createContainer():void {
			Out.info(this, "_createContainer");
			_container = new Sprite();
			_container.y = 75;
			_container.graphics.beginFill(0xFFFFFF, 0);
			_container.graphics.drawRect(0, 0, 1430, 500);
			_container.graphics.endFill();
			_container.buttonMode = true;
			addChild(_container);
		};
		
		
		private function _createThumbs():void {
			Out.info(this, "_createThumbs");
			
			var menuItem:MenuItem;
			for(var i:int=0; i<10; i++) {
				menuItem = new MenuItem();
				menuItem.x = (200 + 3) * i;
				_container.addChild(menuItem);
			}
			
			_isInit = true;
		};
		
		private function _animateIn():void {
			Out.info(this, "animateIn");
			
			var mi:MenuItem, i:int = _container.numChildren;
			while(i--) {
				mi = _container.getChildAt(i) as MenuItem;
				mi.animateIn(i * .1);
			}
			
			// hacky, but okay for this example
			setTimeout(_onAnimateIn, 1700);
		};
		
		
		private function _doSlide():void {
			_diff = (_getTargetX() - _container.x) / 5;
			_container.x += _diff;
		};
		
		
		private function _getTargetX():Number {
			var i:Number = StageUtils.getLeftX() + _offset;
			if(i + _getWidth() < StageUtils.getRightX() && _getWidth() > stage.stageWidth) i = StageUtils.getRightX() - _getWidth();
			else if(_getWidth() < stage.stageWidth) i = StageUtils.getLeftX(); 
			return i;
		};
		
		
		private function _getWidth():Number {
			return _container.width;
		};
		
		
		// =======================================================================================================
		// EVENT interface ---------------------------------------------------------------------------------------
		
		private function _onAnimateIn($evt:AnimationEvent = null):void {
			Out.info(this, "_onAnimateIn");
			dispatchEvent(new MenuEvent(MenuEvent.READY));
		};
		
		private function _onEnterFrame($evt:Event):void {
			if(getMenuScrollAmount() > .001) _doSlide();
			else removeEventListener(Event.ENTER_FRAME, _onEnterFrame);
		};
		
	}
};