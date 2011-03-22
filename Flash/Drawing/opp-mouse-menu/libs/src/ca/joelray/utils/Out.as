/**
 * Out by Joel Ray. 2009
 *
 * Copyright (c) 2009 Joel Ray
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
package ca.joelray.utils
{
	import ca.joelray.events.OutEvent;
	
	import ca.joelray.debug.arthropod.Debug;
	
	import flash.events.EventDispatcher;
	import flash.external.ExternalInterface;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * The <code>Out</code> Class
	 * 
	 * @copyright 		2010 Joel Ray
	 * @author			Joel Ray
	 * @version			1.0 
	 * @langversion		ActionScript 3.0 			
	 * @playerversion 	Flash 9.0.0
	 */

	public class Out extends EventDispatcher
	{
		public  static const INFO          : Number = 0;
		public  static const STATUS        : Number = 1;
		public  static const DEBUG         : Number = 2;
		public  static const WARNING       : Number = 3;
		public  static const ERROR         : Number = 4;
		public  static const FATAL         : Number = 5;

		private static var __levels        : Array  = new Array();
		private static var __silenced      : Object = new Object();
		private static var __instance      : Out;
		
		private static var __usesArthropod  : Boolean;   // Arthropod: http://arthropod.stopp.se
		private static var __usesFirebug    : Boolean;   // Firebug:   http://getfirebug.com

		
		// ===========================================================================================================================
		// PUBLIC STATIC interface ---------------------------------------------------------------------------------------------------
		
		public static function enableLevel($level:Number):void {
			__levels[$level] = __output;
		};

		public static function disableLevel($level:Number):void {
			__levels[$level] = __foo; 
		};

		public static function enableAllLevels($arthropod:Boolean = false, $firebug:Boolean = false):void {
			__usesArthropod = $arthropod;
			__usesFirebug = $firebug;

			enableLevel(INFO   );
			enableLevel(STATUS );
			enableLevel(DEBUG  );
			enableLevel(WARNING);
			enableLevel(ERROR  );
			enableLevel(FATAL  );
		};

		public static function disableAllLevels():void {
			disableLevel(INFO   );
			disableLevel(STATUS );
			disableLevel(DEBUG  );
			disableLevel(WARNING);
			disableLevel(ERROR  );
			disableLevel(FATAL  );
		};

		public static function clear():void {
			if(__usesArthropod) Debug.clear();
			if(__usesFirebug) if(ExternalInterface.available) ExternalInterface.call("console.clear");
		};

		public static function isSilenced($o:*):Boolean {
			var s:String = __getClassName($o);

			return __silenced[s];
		};

		public static function silence($o:*):void {
			var s:String = __getClassName($o);

			__silenced[s] = true;
		};

		public static function unsilence($o:*):void {
			var s:String = __getClassName($o);

			__silenced[s] = false;
		};

		public static function info($origin:*, ...$args):void {
			if(isSilenced($origin)) return;
			
			if(__levels.hasOwnProperty(INFO) && __levels[INFO]!=null)
				__levels[INFO]("INFO", $origin, $args, OutEvent.INFO);
		};

		public static function status($origin:*, ...$args):void {
			if(isSilenced($origin)) return;
			
			if(__levels.hasOwnProperty(STATUS) && __levels[STATUS]!=null)
				__levels[STATUS]("STATUS", $origin, $args, OutEvent.STATUS);
		};

		public static function debug($origin:*, ...$args):void {
			if(isSilenced($origin)) return;

			if(__levels.hasOwnProperty(DEBUG) && __levels[DEBUG]!=null)
				__levels[DEBUG]("DEBUG", $origin, $args, OutEvent.DEBUG);
		};

		public static function warning($origin:*, ...$args):void {
			if(isSilenced($origin)) return;

			if(__levels.hasOwnProperty(WARNING) && __levels[WARNING]!=null)
				__levels[WARNING]("WARNING", $origin, $args, OutEvent.WARNING);
		};

		public static function error($origin:*, ...$args):void {
			if(isSilenced($origin)) return;

			if(__levels.hasOwnProperty(ERROR) && __levels[ERROR]!=null)
				__levels[ERROR]("ERROR", $origin, $args, OutEvent.ERROR);
		};

		public static function fatal($origin:*, ...$args):void {
			if(isSilenced($origin)) return;

			if(__levels.hasOwnProperty(FATAL) && __levels[FATAL]!=null)
				__levels[FATAL]("FATAL", $origin, $args, OutEvent.FATAL);
		};

		public static function traceObject($origin:*, $str:String, $obj:*):void{
			if(isSilenced($origin)) return;

			__output("OBJECT", $origin, $str, OutEvent.ALL);
			for(var p:* in $obj) __output("", null, $str + " :: " + p + " : " + $obj[p], OutEvent.ALL);
		};

		public static function addEventListener($type:String, $func:Function):void{
			__getInstance().addEventListener($type, $func);
		};

		public static function removeEventListener($type:String, $func:Function):void {
			__getInstance().removeEventListener($type, $func);
		};
		
		
		// ===========================================================================================================================
		// INTERNAL interface --------------------------------------------------------------------------------------------------------
		
		private static function __getInstance():Out{
			return (__instance ? __instance : (__instance = new Out()));
		};

		private static function __foo($level:String,$origin:*,$str:String,$type:String):void {};

		private static function __output($level:String, $origin:*, $str:String, $type:String):void {
			var l:String = $level;
			var s:String = $origin ? __getClassName($origin) : "";
			var i:Out    = __getInstance();

			while(l.length < 8) l += " ";
			var output:String = l != "" && s != "" ? l + ":::	" + s + "	::	" + $str : $str;

			if (__usesArthropod) {
				switch($level){
					case "ERROR" :
						Debug.error(output);
						break;
					case "WARNING" :
						Debug.warning(output);
						break;
					case "FATAL" :
						Debug.log(output, Debug.RED);
						break;
					case "DEBUG" :
						Debug.log(output, Debug.PINK);
						break;
					case "STATUS" :
						Debug.log(output, Debug.GREEN);
						break;
					case "INFO" :
						Debug.log(output);
						break;
					case "" :
					case "OBJECT" :
						Debug.log(output, Debug.YELLOW);
						break;
					default:
						break;
				};
			};
			
			if(__usesFirebug && ExternalInterface.available) {
				switch($level){
					case "ERROR" :
						ExternalInterface.call("console.error",output);
						break;
					case "WARNING" :
						ExternalInterface.call("console.warn",output);
						break;
					case "FATAL" :
						ExternalInterface.call("console.error",output);
						break;
					case "DEBUG" :
						ExternalInterface.call("console.debug",output);
						break;
					case "STATUS" :
						ExternalInterface.call("console.log",output);
						break;
					case "INFO" :
						ExternalInterface.call("console.info",output);
						break;
					default:
						ExternalInterface.call("console.log",output);
						break;
				};
			};

			trace(output);

			i.dispatchEvent(new OutEvent(OutEvent.ALL, output));
			i.dispatchEvent(new OutEvent($type, output));
		};



		private static function __getClassName($o:*):String {
			var c:String = flash.utils.getQualifiedClassName($o);
			var s:String = (c == "String" ? $o : c.split("::")[1] || c);

			return s;
		};

	};
};