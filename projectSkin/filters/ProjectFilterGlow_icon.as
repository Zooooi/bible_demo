package projectSkin.filters
{
	import JsC.filters.FilterGlow;
	
	public class ProjectFilterGlow_icon extends FilterGlow
	{
		public function ProjectFilterGlow_icon(color:uint=0x000000, alpha:Number=1.0, blurX:Number=6.0, blurY:Number=6.0, strength:Number=5, quality:int=1, inner:Boolean=false, knockout:Boolean=false)
		{
			super(color, alpha, blurX, blurY, strength, quality, inner, knockout);
		}
	}
}