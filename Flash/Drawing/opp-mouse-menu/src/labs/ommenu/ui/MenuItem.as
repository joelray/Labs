package labs.ommenu.ui {
	
	import ca.joelray.utils.Out;
	
	import com.greensock.TweenLite;
	import com.greensock.easing.Quint;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class MenuItem extends Sprite {
		
		// instances
		private var _bkg:Shape;
		private var _mask:Shape;
		
		// props
		private var _color:uint;
		
		
		// =======================================================================================================
		// CONSTRUCTOR -------------------------------------------------------------------------------------------
		
		public function MenuItem() {
			Out.status(this, "CONSTRUCTOR");
			_createItem();
			_addListeners();
		};
		
		
		// =======================================================================================================
		// PUBLIC interface --------------------------------------------------------------------------------------
		
		public function animateIn($delay:Number = 0):void {
			TweenLite.to(_mask, .8, { delay:$delay, scaleY:500, ease:Quint.easeOut });
		};
		
		
		// =======================================================================================================
		// INTERNAL interface ------------------------------------------------------------------------------------
		
		private function _createItem():void {
			Out.info(this, "_createItem");
			
			_color = 0xFFFFFF * Math.random();
			
			_mask = new Shape();
			_mask.graphics.beginFill(_color);
			_mask.graphics.drawRect(0, 0, 200, 1);
			_mask.y = -1;
			addChild(_mask);
			
			_bkg = new Shape();
			_bkg.graphics.beginFill(_color);
			_bkg.graphics.drawRect(0, 0, 200, 500);
			_bkg.alpha = .25;
			_bkg.mask = _mask;
			addChild(_bkg);
		};
		
		
		private function _addListeners():void {
			Out.info(this, "_addListeners");
			addEventListener(MouseEvent.MOUSE_OVER, _onMouseOver, false, 0, true);
			addEventListener(MouseEvent.MOUSE_OUT, _onMouseOut, false, 0, true);
		};
		
		
		// =======================================================================================================
		// EVENT interface ---------------------------------------------------------------------------------------
			
		private function _onMouseOver($evt:MouseEvent):void {
		//	Out.debug(this, "_onMouseOver");
			_bkg.alpha = .75;
		};
		
		
		private function _onMouseOut($evt:MouseEvent):void {
		//	Out.debug(this, "_onMouseOut");
			_bkg.alpha = .25;
		};
		
	};
};