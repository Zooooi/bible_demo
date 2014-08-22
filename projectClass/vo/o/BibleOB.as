package projectClass.vo.o
{
	import JsC.mvc.VO;
	
	public class BibleOB extends VO
	{
		
		public static const old_testament:String = "old_testament";
		public static const new_testament:String = "new_testament";
		
		[Bindable]public var ID:uint
		[Bindable]public var content:String;
		[Bindable]public var chapter:uint
		[Bindable]public var chapterLength:uint
		
		[Bindable]public var topic:String
		[Bindable]public var verse:uint;
		[Bindable]public var volume:uint
		
		[Bindable]public var testament:Boolean;
		
		[Bindable]public var short_name:String
		[Bindable]public var full_name:String
		
		[Bindable]public var volumeName:String
		[Bindable]public var contentTitle:String
		
		
		public function BibleOB()
		{
			super();
		}
	}
}