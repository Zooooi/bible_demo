package projectComponents.bible.ctrl
{
	import JsA.data.SQLiteEvent;
	
	import JsC.action.ActFunc;
	import JsC.debug.CountTime;
	import JsC.events.JEvent;
	import JsC.mvc.Controller;
	
	import projectClass.vo.v.FilesVO;
	
	
	[Event(name="COMPLETE", type="JsC.events.JEvent")]
	[Event(name="ITEM_COMPLETE", type="JsC.events.JEvent")]
	
	
	public class DataLoader extends Controller
	{
		
		private const data_project:String = "project"
		private const data_bible:String = "bible"
		
		private var aFiles:Vector.<String> = Vector.<String>(["bible_sc_cuv.db"])
	
		private var bibleData:DataBibleController
		private var actFunc:ActFunc
		
		public function DataLoader()
		{
			CountTime.display("DataLoader")
			actFunc = new ActFunc([initProject,initBible,initComplete])
			actFunc.init()
		}
		
		private function initProject():void
		{
			CountTime.display("initProject")
			var projectData:DataProject = new DataProject
			projectData.$name = data_project
			projectData.addEventListener(SQLiteEvent.INIT_COMPLETE,function():void{actFunc.next()})
			projectData.init();
		}
		
		private function initBible():void
		{
			CountTime.display("initBible")
			bibleData = new DataBibleController
			bibleData.$name = data_bible
			bibleData.addEventListener(SQLiteEvent.INIT_COMPLETE,function():void{actFunc.next()})
			bibleData.load(FilesVO.file_bible,true)
		}
		
		private function initComplete():void
		{
			dispatchEvent(new JEvent(JEvent.COMPLETE))
		}
		
		public function getBibleSQL():DataBibleController
		{
			return bibleData
		}
		
	}
}