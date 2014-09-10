package projectSkin.filters
{
	import JsC.filters.FilterBlur;
	
	public class ProjectBlur extends FilterBlur
	{
		public function ProjectBlur(blurX:Number=2.0, blurY:Number=2.0, quality:int=1)
		{
			super(blurX, blurY, quality);
		}
	}
}