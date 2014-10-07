package projectComponents.bible.vo
{
	import JsC.mvc.VO;
	
	public class VersionUpdateVO extends VO
	{
		
		[Bindable]public var version:String
		[Bindable]public var file:String
		[Bindable]public var icon:String
		[Bindable]public var old_version:String
		[Bindable]public var new_version:String
		[Bindable]public var id:String
		
		
		public function VersionUpdateVO(obj:Object=null)
		{
			super(obj);
		}
	}
}