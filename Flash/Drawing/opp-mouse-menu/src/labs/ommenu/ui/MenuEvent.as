package labs.ommenu.ui {
	
	import flash.events.Event;
	
	public class MenuEvent extends Event {
		
		public static const READY:String = "ready";
		
		
		// =======================================================================================================
		// CONSTRUCTOR -------------------------------------------------------------------------------------------
		
		public function MenuEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
		};
		
		
		// =======================================================================================================
		// PUBLIC interface --------------------------------------------------------------------------------------
		
		override public function clone():Event {
			return new MenuEvent(type, bubbles, cancelable);
		};
		
	};
};