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
	
	public class BibleDB extends Model
	{
		
		private var con:SQLConnection;
		private var stmt:SQLStatement;
		private var responder:Responder
		
		private const aBibleTable:Vector.<String> = Vector.<String>(["volumes","bible"]);
		private const cLength:uint = 70;
		
		private var currentTable:String
		private var nCounter:uint
		private var nPage:uint
		
		
		private var aVolumes:Vector.<Object>
		private var aBible:Vector.<Object>
		
		public function BibleDB()
		{
			
		}
		
		
		public function load():void
		{
			responder= new Responder(resultHandler, errorHandler);
			var filedb:File = new File(FilesVO.file_bible);
			con = new SQLConnection
			con.addEventListener(SQLEvent.OPEN,onSQLEvent)
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
		
		protected function onSQLEvent(event:SQLEvent):void
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
		
		
		protected function queryBible():void
		{
			stmt = new SQLStatement();
			stmt.sqlConnection = con; 
			stmt.text = "select * from bible limit :page,:total ";
			stmt.parameters[":page"]=nPage;
			stmt.parameters[":total"]=cLength;
			stmt.execute(-1,responder);  
		}
		
		
		protected function resultHandler(result:SQLResult):void
		{
			trace(currentTable);
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
		
		protected function errorHandler(error:SQLError):void
		{
			trace(error.message);
			trace(error.details);
		}
		
		public function next():void
		{
			nPage ++;
			stmt.parameters[":page"]=nPage;
			stmt.execute(-1,responder);  
		}
		
		public function prev():void
		{
			
		}
		
	}
}

class SQL_Data2
{
	
}
