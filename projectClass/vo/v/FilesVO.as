package projectClass.vo.v 
{
	
	public class FilesVO 
	{
		
		private static var bOnce:Boolean
		private static var $appPath:String=""
		private static var $userPath:String=""
		private static var $docPath:String=""
			
		private static var $asset:String="assets/"	
			
		
		public static function setAppPath(_path:String):void
		{
			$appPath = _path
		}
		
		public static function get path_app():String 
		{
			return $appPath
		}
		
		public static function setDocumentPath(_path:String):void
		{
			$docPath = _path
		}
		
		private static function get path_document():String 
		{
			return $docPath
		}
		
		
		public static function setUserPath(_path:String):void
		{
			$userPath = _path
		}
		private static function get userFolder():String
		{
			return $userPath
		}
		
		
		public static function get folder_assets():String {return  $appPath + $asset }
		public static function get folder_data():String {return  folder_assets + "data/" }
		public static function get folder_app_Data():String {return  $appPath + $asset + "data/" }
		public static function get file_bible():String {return  folder_data + Config.Files.bible_file}
		public static function get file_project():String {return  folder_data + Config.project}
		public static function get file_user():String {return  folder_data + Config.project}
		
	}

}