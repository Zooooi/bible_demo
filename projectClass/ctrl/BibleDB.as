package projectClass.ctrl
{
	import flash.data.SQLConnection;
	import flash.data.SQLResult;
	import flash.data.SQLStatement;
	import flash.errors.SQLError;
	import flash.events.SQLEvent;
	import flash.filesystem.File;
	import flash.net.Responder;
	
	import JsC.events.JEvent;
	import JsC.mvc.Model;
	
	import projectClass.vo.v.FilesVO;
	
	
	[Event(name="NEXT", type="JsC.events.JEvent")]
	[Event(name="PREV", type="JsC.events.JEvent")]
	
	public class BibleDB extends Model
	{
		
		public const $total:uint = 100;
		public const $length:uint = $total / 2
		
		private var con:SQLConnection;
		private var stmt:SQLStatement;
		private var responder:Responder
		
		private const aBibleTable:Vector.<String> = Vector.<String>(["volumes","bible"]);
		
		private var currentTable:String
		private var nCounter:uint
		private var nPage:uint
		
		
		private var aVolumes:Vector.<Object>
		private var aBible:Vector.<Object>
		
		private var bNext:Boolean;
		private var bPrev:Boolean;
		
		private const SQL_BIBLE:String = "select * from bible limit :page,:total ";
		
		public function BibleDB()
		{
			
		}
		
		
		public function load():void
		{
			responder= new Responder(result_init, errorHandler);
			var filedb:File = new File(FilesVO.file_bible);
			con = new SQLConnection
			con.addEventListener(SQLEvent.OPEN,onLoadSQLComplete)
			con.openAsync(filedb);
		}
		
		
		public function getVoumes():Vector.<Object>
		{
			return aVolumes;
		}
		
		
		public function getBible():Vector.<Object>
		{
			return aBible
		}
		
		
		protected function onLoadSQLComplete(event:SQLEvent):void
		{
			setTableName()
			queryVolume()
		}
		
		
		private function setTableName():void
		{
			currentTable = aBibleTable[nCounter]
			nCounter++
		}
		
		protected function queryVolume():void
		{
			stmt = new SQLStatement();
			stmt.sqlConnection = con; 
			stmt.text = "select * from volumes ";
			stmt.execute(-1,responder);  
		}
		
		/**
		 * 
		 * 第一次load bible
		 */		
		protected function queryBible():void
		{
			stmt = new SQLStatement();
			stmt.sqlConnection = con; 
			stmt.text = SQL_BIBLE
			stmt.parameters[":page"] = nPage;
			stmt.parameters[":total"] = $total;
			stmt.execute(-1,responder);  
			nPage = $length
		}
		
		
		protected function result_init(result:SQLResult):void
		{
			switch(currentTable)
			{
				case "volumes":
					aVolumes = Vector.<Object>(result.data)
					setTableName()
					queryBible()
					break;
				case "bible":
					aBible = Vector.<Object>(result.data)
					dispatchEvent(new JEvent(JEvent.COMPLETE));
					break;
			}
		}
		
		protected function result_bible(result:SQLResult):void
		{
			aBible = Vector.<Object>(result.data)
			if (bNext){
				bNext = false;
				dispatchEvent(new JEvent(JEvent.NEXT))
			}else if(bPrev){
				bPrev = false
				dispatchEvent(new JEvent(JEvent.PREV))
			}
		}
		
		
		protected function errorHandler(error:SQLError):void
		{
			trace(error.message);
			trace(error.details);
		}
		
		public function next():void
		{
			bNext = true;
			nPage += $length;
			bibleGetPage()
		}
		
		public function prev():void
		{
			if (nPage>0)
			{
				bPrev = true
				nPage -= $length;
				bibleGetPage()
			}
		}
		
		
		private function bibleGetPage():void
		{
			responder= new Responder(result_bible, errorHandler);
			stmt = new SQLStatement();
			stmt.sqlConnection = con; 
			stmt.text = SQL_BIBLE
			stmt.parameters[":page"] = nPage;
			stmt.parameters[":total"] = $length;
			stmt.execute(-1,responder); 
		}
		
	}
}

class SQL_Data2
{
	
}
