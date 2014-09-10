package projectClass.vo.v
{
	import JsC.mvc.VO;

	public class LanVO 
	{
		//以下关键字名称，应用之后不能再修改，否则是灾难
		
		//xml文件的ID--------------------------------------------------------------------------------------
		private static var data:VO
		
		public static const all_testament:String = "all_volumes";
		public static const old_testament:String = "old_testament";
		public static const new_testament:String = "new_testament";
		
		
		public function LanVO(_vo:VO = null):void
		{
			if (_vo)data = _vo
		}
		
		public static function getKey(_name:String):String
		{
			return data[_name]
		}
	}

}