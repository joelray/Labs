/**
 * OutEvent by Joel Ray. 2010
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
package ca.joelray.events{
	
	import flash.events.Event;
	
	public class OutEvent extends Event{
		
		public var output			: String;
		
		public static var ALL   	: String = "all";
		public static var INFO      : String = "info";
		public static var STATUS    : String = "status";
		public static var DEBUG     : String = "debug";
		public static var WARNING   : String = "warning";
		public static var ERROR     : String = "error";
		public static var FATAL     : String = "fatal";
		
		/**
		 * The <code>OutEvent</code> Class
		 * 
		 * 
		 * @copyright 		2010 Joel Ray
		 * @author			Joel Ray
		 * @version			1.0 
		 * @langversion		ActionScript 3.0 			
		 * @playerversion 	Flash 9.0.0
		 *
		 */

		public function OutEvent($str:String, $out:String){
			super($str);
			output = $out;
		};

		public override function clone():Event{
			return new OutEvent(type, output);
		};
	};
};