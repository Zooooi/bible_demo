package projectComponents.bible.vo
{
	import JsC.mvc.VO;
	
	public class BibleOB extends VO
	{
		
		/** tablename */
		[Bindable]public var ID:uint
		[Bindable]public var sn:uint;
		[Bindable]public var name:String;
		[Bindable]public var content:String;
		[Bindable]public var chapter:uint
		
		[Bindable]public var topic:String
		[Bindable]public var verse:uint;
		[Bindable]public var volume:uint
		[Bindable]public var testament:Boolean;
		[Bindable]public var short_name:String
		[Bindable]public var full_name:String

		
		/** 以下是變量 */
		[Bindable]public var id:uint
		[Bindable]public var volumeName:String
		[Bindable]public var sTitle:String
		[Bindable]public var nVolume:uint
		[Bindable]public var nChapter:uint
		[Bindable]public var nChapterLength:uint
		[Bindable]public var kind:String
		
		public function BibleOB(obj:Object = null)
		{
			super(obj);
		}
	}
}