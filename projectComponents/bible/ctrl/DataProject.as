package projectComponents.bible.ctrl
{
	import JsA.data.SQLiteCtrl;
	import JsA.data.SQLiteEvent;
	
	import JsC.mvc.VO;
	
	import projectClass.vo.v.Config;
	import projectClass.vo.v.FilesVO;
	import projectClass.vo.v.LanVO;
	
	public class DataProject extends SQLiteCtrl
	{
		private var language:VO
		public function DataProject()
		{
			super()
			sFile = FilesVO.file_project
			addInitSQL("bible_langage","select name,sc from bible_langage")
			addInitSQL("bible_version","select * from bible_version")
		}
		
		override protected function onItemComplete(event:SQLiteEvent):void
		{
			switch(event.name)
			{
				case "bible_langage":
					language = new VO
					for (var i:int = 0; i < event.data.length; i++) 
					{
						var _name:String =  event.data[i].name
						var _value:String = event.data[i][Config.language]
						language[_name] = _value
					}
					new LanVO(language)
					break;
			}
			
		}
	}
}