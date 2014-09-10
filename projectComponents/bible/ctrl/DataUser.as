package projectComponents.bible.ctrl
{
	import JsA.data.SQLiteCtrl;
	
	import projectClass.vo.v.FilesVO;
	
	public class DataUser extends SQLiteCtrl
	{
		public function DataUser()
		{
			super();
			sFile = FilesVO.file_user
			aInitData.push("bible_langage","select name,sc from bible_langage")
			aInitData.push("bible_version","select * from bible_version")
		}
	}
}