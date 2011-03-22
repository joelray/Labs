/**
 * MathBase by Joel Ray. 2010
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
package ca.joelray.math
{

	/**
	 * The <code>MathBase</code> Class
	 * 
	 * <p>NOTE: the random/round/ceil/floor methods are subject to float operation problems if roundTo contains decimals. 
	 * This means it should be precise enough to use for other math operations, but will not necesarily chop off decimals 
	 * properly, so they should not be used for aesthetic display since you might get results like 
	 * 2.32232999999999995 instead of 2.32233.</p> 
	 * 
	 * @copyright 		2010 Joel Ray
	 * @author			Joel Ray
	 * @version			1.0 
	 * @langversion		ActionScript 3.0 			
	 * @playerversion 	Flash 9.0.0
	 * 
	 * @reference http://bit.ly/eTu0XD  // kirupa.com/forum
	 * @reference http://bit.ly/fpx2qp  // adobe.com/selfservice
	 */
	public class MathBase
	{

		// ===========================================================================================================================
		// PUBLIC STATIC interface ---------------------------------------------------------------------------------------------------
		
		/**
		 * Rounds according to the following logic:
		 * 
		 * <ul>
		 *  <li>.01 to round 2 decimals</li>
		 *  <li>1 to nearest integer (default)</li>
		 *  <li>6 to nearest multiple of 6</li>
		 *  <li>0.5 to nearest multiple of 0.5</li>
		 * </ul>
		 * 
		 * @param $val
		 * @param $roundTo
		 * @return
		 */		
		public static function round($val:Number, $roundTo:Number = 1):Number {
			return Math.round($val / $roundTo) * $roundTo;
		}

		
		/**
		 * Floors according to the following logic:
		 * 
		 * <ul>
		 *  <li>.01 to round 2 decimals</li>
		 *  <li>1 to nearest integer (default)</li>
		 *  <li>6 to nearest multiple of 6</li>
		 * </ul>
		 * 
		 * @param $val
		 * @param $roundTo
		 * @return
		 * @reference Taken fom AS3 Cookbook
		 */		
		public static function floor($val:Number, $roundTo:Number = 1):Number {
			return Math.floor($val / $roundTo) * $roundTo;
		}

		
		/**
		 * Ceils according to the following logic:
		 * 
		 * <ul>
		 *  <li>.01 to round 2 decimals</li>
		 *  <li>1 to nearest integer (default)</li>
		 *  <li>6 to nearest multiple of 6</li>
		 * </ul>
		 * 
		 * @param $val
		 * @param $roundTo
		 * @return
		 * @reference Taken fom AS3 Cookbook 
		 */		
		public static function ceil($val:Number, $roundTo:Number = 1):Number {
			return Math.ceil($val / $roundTo) * $roundTo;
		}

		
		/**
		 * Random number generator with included rounding.
		 * 
		 * <ul>
		 *  <li>MathBase.random(0, 100, 10); //gives only multiples of 10 inside the 0 - 100 range (ex: 20, 100, 0, 30, etc)</li>
		 *  <li>MathBase.random(0, 100, .0001); //gives random numbers inside to 0 - 100 range with 4 digits precision (ex: 41.7069 )</li>
		 * </ul>
		 * 
		 * @param $min
		 * @param $max
		 * @param $roundTo
		 * @return
		 * @reference Taken fom AS3 Cookbook
		 */		
		public static function random($min:Number, $max:Number = 0, $roundTo:Number = 1):Number {
		
			//swap order if min is bigger than max
			if($min > $max) {
				var nTemp:Number = $min;
				$min = $max;
				$max = nTemp;
			}
			
			var val:Number = MathBase.lerp(Math.random(), $min, $max);
			return Math.round(val / $roundTo) * $roundTo;
		}

		
		/**
		 * Loose check for equality.
		 * 
		 * @param $number1
		 * @param $number2
		 * @param $precision
		 * @return
		 * @reference Taken from the Yahoo! astra framework.
		 */		
		public static function fuzzyEquals($number1:Number, $number2:Number, $precision:int = 5):Boolean {
			var difference:Number = $number1 - $number2;
			var range:Number = Math.pow(10, -$precision);
			
			//default precision checks the following:
			//0.00001 < difference > -0.00001
			return difference < range && difference > -range;
		}

		
		/**
		 * Returns a set of random numbers inside a specific range (unique numbers is optional).
		 * 
		 * @param $min
		 * @param $max
		 * @param $count
		 * @param $unique
		 * @return
		 */		
		public static function randomSets($min:Number, $max:Number, $count:Number, $unique:Boolean):Array {
			var rnds:Array = new Array();
			
			if ($unique && $count <= $max - $min + 1) {
				//unique
				// create num range array
				var nums:Array = new Array();
				
				for (var i:Number = $min;i <= $max; i++) nums.push(i);	
				
				for (i = 1;i <= $count; i++) {
					// random number
					var rn:Number = Math.floor(Math.random() * nums.length);
					rnds.push(nums[rn]);
					nums.splice(rn, 1);
				}
			} else {
				//non unique
				for (i = 1;i <= $count; i++) rnds.push(MathBase.random($min, $max));
			}
			
			return rnds;
		}

		
		/**
		 * 
		 * @param $val
		 * @return <ul>
		 *  <li>1 if the value is &gt;= 0.</li>
		 *  <li>-1 if the value is &lt; 0.</li>
		 * </ul>
		 */		
		public static function sign($val:Number):int {
			return ($val < 0) ? -1 : 1;
		}

		
		/**
		 * Checks if a number is even
		 * 
		 * @param $val
		 * @return
		 */		
		public static function isEven($val:Number):Boolean {
			return ($val % 2 == 0);
		}

		
		/**
		 * Checks if a number is odd
		 * 
		 * @param $val
		 * @return
		 */		
		public static function isOdd($val:Number):Boolean {
			return ($val % 2 != 0);
		}

		
		/**
		 * Returns <code>$n</code> clamped between min and max
		 * 
		 * @param $n
		 * @param $min
		 * @param $max
		 * @return
		 */		
		public static function clamp($n:Number, $min:Number, $max:Number):Number {
			if($min > $max) {
				var tmp:Number = $max;
				$max = $min;
				$min = tmp;
			}
			
			if($n < $min) return $min;
			if($n > $max) return $max;
			return $n;
		}

		
		/**
		 * Liner interpolation
		 * 
		 * <p>Interpolates a value within a range based on a normalized param</p>
		 * <p><code>$amt</code> argument should be a normalized (0 to 1) value</p>
		 * 
		 * <p>Ex.:
		 * <ul>
		 *  <li>lerp(0.5, 0, 200)   //returns 100</li>
		 *  <li>lerp(0.5, 400, 500) //returns 450</li>
		 * </ul></p>
		 * 
		 * @param $amt
		 * @param $low
		 * @param $high
		 * @param $clampResult
		 * @return
		 */		
		public static function lerp($amt:Number, $low:Number, $high:Number, $clampResult:Boolean = false):Number {
			var result:Number = ($high - $low) * $amt + $low;
			return ($clampResult) ? clamp(result, $low, $high) : result;
		}

		
		/**
		 * Normalizes a value in relation to a certain range ( return is a float between 0 and 1, but it can be different is <code>$val</code> is out of range )
		 * The normalized value can then be brought to another range by simple multiplications/additions
		 * 
		 * <p>Ex.:
		 * <ul>
		 *  <li>norm(50, 0, 100) and norm(150, 100, 200) will both return 0.5</li>
		 *  <li>norm(0.4, 0, 1) * 2 - 1;     //converts from a 0-1 range to a -1 to 1 range</li>
		 *  <li>norm(67, 0, 100) * 255;      //converts from 0-100 range to a 0-255 range (RGB)</li>
		 *  <li>norm(67, 0, 100) * 450 + 50; //converts from 0-100 range to a 50-500 range</li>
		 * </ul></p>
		 * 
		 * @param $val
		 * @param $low
		 * @param $high
		 * @param $clampResult
		 * @return
		 */		
		public static function norm($val:Number, $low:Number, $high:Number, $clampResult:Boolean = false):Number {
			var result:Number = ($val - $low) / ($high - $low);
			return ($clampResult) ? clamp(result, $low, $high) : result;
		}

		
		/**
		 * Like <code>norm</code>, but you specify the new range right away. More concise if you're remapping to a new range.
		 * 
		 * <ul><li>map(50, 0, 100, 500, 1000) //returns 750. The norm result is 0.5, and it's remapped to the 500-1000 range</li></ul>
		 * 
		 * @param $val
		 * @param $low
		 * @param $high
		 * @param $newLow
		 * @param $newHigh
		 * @param $clampResult
		 * @return
		 */		
		public static function map($val:Number, $low:Number, $high:Number, $newLow:Number, $newHigh:Number, $clampResult:Boolean = false):Number {
			var result:Number = lerp(norm($val, $low, $high), $newLow, $newHigh);
			return ($clampResult) ? clamp(result, $newLow, $newHigh) : result;
		}
		
		
		/**
		 * Random normal distribution.
		 * 
		 * @example <code><pre>
		 *	var particles:Number = 500;
		 *	for(var i:Number = 0; i &lt; particles; i++) {
		 *		var c:* = addChild( new Circle() );
		 *		c.alpha = 0.1;
		 *		c.x = MathBase.normalDistribution(5, 100, 700);
		 *		c.y = MathBase.normalDistribution(5, 100, 500);
		 *	}</pre></code>
		 * 
		 * @param $amplitude
		 * @param $low
		 * @param $high
		 * @return
		 */		
		public static function normalDistribution($amplitude:Number, $low:Number, $high:Number):Number {
			// TODO: better name
			// TODO: more research on random number generators
			// TODO: gaussian distribution, perlin noise, http://docs.python.org/lib/module-random.html
			var total:Number = 0;
			for(var i:Number = 0; i < $amplitude; i++) {
				total += (Math.random() * ($high - $low) / $amplitude );
			}
			return total + $low;
		}

		
		/**
		 * Returns the square value of a number
		 * 
		 * @param $val
		 * @return
		 */		
		public static function square($val:Number):Number {
			return $val * $val;
		}

		
		/**
		 * Simple toggle between values
		 * 
		 * @param $currentValue
		 * @param $value1
		 * @param $value2
		 * @return
		 * @example StageUtils.STAGE.displayState = MathBase.toggle(StageUtils.STAGE.displayState, StageDisplayState.NORMAL, StageDisplayState.FULL_SCREEN);
		 */		
		public static function toggle($currentValue:*, $value1:*, $value2:*):* {
			return ($currentValue == $value1) ? $value2 : $value1;
		}
	}
}
