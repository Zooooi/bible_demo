package projectClass.vo.o
{
	import JsC.mvc.VO;
	
	public class BibleOB extends VO
	{
		[Bindable]public var ID:uint
		[Bindable]public var content:String;
		[Bindable]public var chapter:uint
		[Bindable]public var topic:String
		[Bindable]public var verse:uint;
		[Bindable]public var volume:uint
		
		public function BibleOB()
		{
			super();
		}
	}
}