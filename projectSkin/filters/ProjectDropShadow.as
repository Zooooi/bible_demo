package projectSkin.filters
{
	import JsC.filters.FilterDropShadow;
	
	public class ProjectDropShadow extends FilterDropShadow
	{
		public function ProjectDropShadow(distance:Number=1.5, angle:Number=45, color:uint=0, alpha:Number=0.5, blurX:Number=5.0, blurY:Number=5.0, strength:Number=1.0, quality:int=2, inner:Boolean=false, knockout:Boolean=false, hideObject:Boolean=false)
		{
			super(distance, angle, color, alpha, blurX, blurY, strength, quality, inner, knockout, hideObject);
		}
	}
}