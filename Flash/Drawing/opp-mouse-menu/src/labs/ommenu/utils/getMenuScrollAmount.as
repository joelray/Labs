package labs.ommenu.utils
{
	import ca.joelray.math.MathBase;
	import ca.joelray.utils.stageutils.StageUtils;

	// =======================================================================================================
	// PUBLIC interface --------------------------------------------------------------------------------------
	
	public function getMenuScrollAmount():Number {
		var scrollOffset:Number = (StageUtils.getCenterX() - StageUtils.stage.mouseX) / (StageUtils.stage.stageWidth / 2);
		return MathBase.clamp(Math.abs(scrollOffset), 0, 1);
	};
};