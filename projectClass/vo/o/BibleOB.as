package projectClass.vo.o
{
	import JsC.mvc.VO;
	
	public class BibleOB extends VO
	{
		
		[Bindable]public var ID:uint
		[Bindable]public var sn:uint;
		[Bindable]public var content:String;
		[Bindable]public var chapter:uint
		
		[Bindable]public var topic:String
		[Bindable]public var verse:uint;
		[Bindable]public var volume:uint
		
		[Bindable]public var testament:Boolean;
		
		[Bindable]public var short_name:String
		[Bindable]public var full_name:String
		
		[Bindable]public var volumeName:String
		
		
		[Bindable]public var sTitle:String
		
		[Bindable]public var nVolume:uint
		[Bindable]public var nChapter:uint
		[Bindable]public var nChapterLength:uint
		
		public function BibleOB()
		{
			super();
		}
	}
}