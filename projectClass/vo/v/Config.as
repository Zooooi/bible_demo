package projectClass.vo.v
{
	import JsC.mvc.VO;
	
	public class Config extends VO
	{
		
		[Bindable] public static var language:String = "TC"; //要大寫
		[Bindable] public static var instance:Config
		[Bindable] public static var name:String 
		[Bindable] public static var version:String
		[Bindable] public static var versionInfo:String = "Version: preview ";
		
		 public static const project:String = "project.db";
		 public static const user:String = "user.db";
		[Bindable] public static var Files:Config_1_files;
		
		public function Config()
		{
			super();
		}
		
		public function getInstance():Config
		{
			return instance
		}
	}
}