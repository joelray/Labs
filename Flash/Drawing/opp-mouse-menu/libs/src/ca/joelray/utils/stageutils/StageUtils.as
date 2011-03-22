/**
 * StageUtils by Joel Ray. 2010
 *
 * Copyright (c) 2010 Joel Ray
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 **/
package ca.joelray.utils.stageutils
{
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	// TODO: documentation.

	/**
	 * The <code>StageUtils</code> Class
	 * 
	 * @copyright 		2010 Joel Ray
	 * @author			Joel Ray
	 * @version			1.1 - Jan 16, 2011
	 * @langversion		ActionScript 3.0 			
	 * @playerversion 	Flash 9.0.0
	 */
	public class StageUtils
	{	
		private static var __dispatcher         : EventDispatcher   = new EventDispatcher();
		private static var __isInit             : Boolean           = false;
		private static var __stage              : Stage;
		private static var __ideWidth           : int;
		private static var __ideHeight          : int;
		private static var __onResize           : Dictionary        = new Dictionary();
		
		private static var __utilities          : Array             = [];
		
		
		// ============================================================================================================
		// STATIC DISPATCHER interface --------------------------------------------------------------------------------
		
		public static function addEventListener($type:String, $listener:Function, $useCapture:Boolean = false, $priority:int = 0, $useWeakReference:Boolean = true):void {
			__dispatcher.addEventListener($type, $listener, $useCapture, $priority, $useWeakReference);
		}
		
		public static function removeEventListener($type:String, $listener:Function, $useCapture:Boolean = false):void {
			__dispatcher.removeEventListener($type, $listener, $useCapture);
		}
		
		public static function dispatchEvent($evt:Event):void {
			__dispatcher.dispatchEvent($evt);
		};
		
		
		// ============================================================================================================
		// PUBLIC STATIC interface ------------------------------------------------------------------------------------
		
		/**
		 * 
		 * @param $stage
		 * @param $width
		 * @param $height
		 * @param $listenForResize
		 * @param $align
		 * @param $scaleMode
		 * @param $quality
		 * @param $focus
		 */		
		public static function initialize($stage:Stage, $width:int, $height:int, $listenForResize:Array = null, $align:String = "", $scaleMode:String = "noScale", $focus:Boolean = false, $showDefaultMenu:Boolean = true, $quality:String = "HIGH"):void {
			if(!__isInit) {
				__stage = $stage;
				__stage.align = $align;
				__stage.scaleMode = $scaleMode;
				__stage.stageFocusRect = $focus;
				__stage.showDefaultContextMenu = $showDefaultMenu;
				__stage.quality = $quality;
				__ideWidth = $width;
				__ideHeight = $height;
				__isInit = true;
				
				if($listenForResize != null) {
					addResizeHandler($listenForResize[0], $listenForResize[1]);
					__stage.addEventListener(Event.RESIZE, _onStageResize);
				}
			}
		}
		
		
		/**
		 * Registers a stage utility by an id.
		 * 
		 * @param $id
		 * @param $utility    IStageUtils
		 */
		public static function registerUtility($id:String, $utility:*):void {
			__utilities[$id] = $utility;
		};
		
		
		
		/**
		 * Destroys a stage utility by an id.
		 * 
		 * @param $id
		 */
		public static function unregisterUtility($id:String):void {
			__utilities[$id].dispose();
			delete __utilities[$id];
		};
		
		
		/**
		 * The <code>addResizeHandler</code> method.
		 * <p>Ex: addResizeHandler([ $id:String, $callback:Function ]);</p>
		 * 
		 * @param $handler    A two peice input requiring 2 required parameters.
		 */
		public static function addResizeHandler($id:String, $callback:Function):void {
			__onResize[$id] = $callback;
		};
		
		
		/**
		 * The <code>removeResizeHandler</code> method. 
		 * <p>Ex: <code>removeResizeHandler("appHandler");</code></p>
		 * 
		 * @param $id    The handler id assigned when first added .
		 */		
		public static function removeResizeHandler($id:String):void {
			delete __onResize[$id];
		}

		
		/**
		 * 
		 * @return
		 */		
		public static function getLeftX():Number
		{
			switch(__stage.align)
			{
				case StageAlign.TOP_LEFT:
				case StageAlign.LEFT:
				case StageAlign.BOTTOM_LEFT:
					return 0;
					
				case StageAlign.TOP_RIGHT:
				case StageAlign.RIGHT:
				case StageAlign.BOTTOM_RIGHT:
					return Math.round(-(__stage.stageWidth - __ideWidth));
				
				default:
					return Math.round(-(__stage.stageWidth - __ideWidth) / 2);
			}
		}
		
		
		/**
		 * 
		 * @return
		 */		
		public static function getRightX():Number
		{
			switch(__stage.align)
			{
				case StageAlign.TOP_LEFT:
				case StageAlign.LEFT:
				case StageAlign.BOTTOM_LEFT:
					return __stage.stageWidth;
				
				case StageAlign.TOP_RIGHT:
				case StageAlign.RIGHT:
				case StageAlign.BOTTOM_RIGHT:
					return __ideWidth;
				
				default:
					return Math.round(__ideWidth + (__stage.stageWidth - __ideWidth) / 2);
			}
		}
		
		
		/**
		 * 
		 * @return
		 */		
		public static function getTopY():Number
		{
			switch(__stage.align)
			{
				case StageAlign.BOTTOM_LEFT:
				case StageAlign.BOTTOM:
				case StageAlign.BOTTOM_RIGHT:
					return Math.round(-(__stage.stageHeight - __ideHeight));
					
				case StageAlign.TOP_LEFT:
				case StageAlign.TOP:
				case StageAlign.TOP_RIGHT:
					return 0;
					
				default:
					return Math.round(-(__stage.stageHeight - __ideHeight) / 2);
			}
		}
		
		
		/**
		 * 
		 * @return
		 */		
		public static function getBottomY():Number
		{
			switch(__stage.align)
			{
				case StageAlign.BOTTOM_LEFT:
				case StageAlign.BOTTOM:
				case StageAlign.BOTTOM_RIGHT:
					return __ideHeight;
					
				case StageAlign.TOP_LEFT:
				case StageAlign.TOP:
				case StageAlign.TOP_RIGHT:
					return Math.round(__ideHeight + (__stage.stageHeight - __ideHeight));
				
				default:
					return Math.round(__ideHeight + (__stage.stageHeight - __ideHeight) / 2);
			}
		}
		
		
		/**
		 * 
		 * @return
		 */		
		public static function getCenterX():Number
		{
			switch(__stage.align)
			{
				case StageAlign.TOP_LEFT:
				case StageAlign.LEFT:
				case StageAlign.BOTTOM_LEFT:
					return Math.round(__stage.stageWidth / 2);
				
				case StageAlign.TOP_RIGHT:
				case StageAlign.RIGHT:
				case StageAlign.BOTTOM_RIGHT:
					return Math.round(__stage.stageWidth / 2 - (__stage.stageWidth - __ideWidth));
					
				default:
					return Math.round(__ideWidth / 2);
			}
		}
		
		
		/**
		 * 
		 * @return
		 */		
		public static function getCenterY():Number
		{
			switch(__stage.align)
			{
				case StageAlign.BOTTOM_LEFT:
				case StageAlign.BOTTOM:
				case StageAlign.BOTTOM_RIGHT:
					return Math.round(__stage.stageHeight / 2 - (__stage.stageHeight - __ideHeight));
					
				case StageAlign.TOP_LEFT:
				case StageAlign.TOP:
				case StageAlign.TOP_RIGHT:
					return Math.round(__stage.stageHeight / 2);
					
				default:
					return Math.round(__ideHeight / 2);
			}
		}
		
		public static function getTopLeftCorner():Point { return new Point(getLeftX(), getTopY()); }
		public static function getTopRightCorner():Point { return new Point(getRightX(), getTopY()); }
		public static function getBottomLeftCorner():Point { return new Point(getLeftX(), getBottomY()); }
		public static function getBottomRightCorner():Point { return new Point(getRightX(), getBottomY()); }
		
		public static function getCenterPoint():Point { return new Point(getCenterX(), getCenterY()); }
		
		public static function getStageWidth():Number { return __stage.stageWidth; }
		public static function getStageHeight():Number { return __stage.stageHeight; }
		public static function getStageRectangle():Rectangle { return new Rectangle(getLeftX(), getTopY(), getStageWidth(), getStageHeight()); }
		public static function getIDEHeight():int { return __ideHeight; }
		public static function getIDEWidth():int { return __ideWidth; }
		
		
		// ============================================================================================================
		// EVENT interface --------------------------------------------------------------------------------------------
		
		private static function _onStageResize($evt:Event):void {
			for each(var f:Function in __onResize) { f(); }
			__dispatcher.dispatchEvent(new Event(Event.RESIZE));
		}
		
		
		// ============================================================================================================
		// ACCESSOR interface -----------------------------------------------------------------------------------------
		
		public static function get stage():Stage { return __stage; }
		
	}
}