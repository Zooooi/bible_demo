package projectTest
{
	import flash.data.SQLConnection;
	import flash.data.SQLResult;
	import flash.data.SQLStatement;
	import flash.errors.SQLError;
	import flash.events.SQLErrorEvent;
	import flash.events.SQLEvent;
	import flash.filesystem.File;
	import flash.net.Responder;
	
	import projectClass.vo.v.FilesVO;
	
	public class LoadDB2
	{
		
		private var con:SQLConnection;
		private var stmt:SQLStatement;
		private var responder:Responder
		
		private var nPage:uint=0;
		
		public function LoadDB2()
		{
			
			var filedb:File = new File(FilesVO.file_bible);
			con = new SQLConnection
			
			con.addEventListener(SQLEvent.OPEN,onSQLEvent)
			con.addEventListener(SQLEvent.RESULT,onSQLEvent)
			con.addEventListener(SQLErrorEvent.ERROR,onSQLErrorEvent);
			con.openAsync(filedb);
		}
		
		public function querytop1():void
		{
			responder= new Responder(resultHandler, errorHandler);
			
			stmt = new SQLStatement();
			stmt.sqlConnection = con; 
			stmt.text = "select * from bible limit :page,:total ";
			stmt.parameters[":page"]=nPage;
			stmt.parameters[":total"]=50;
			stmt.execute(-1,responder);  
			
		}
		
		public function next():void
		{
			nPage+=50
			stmt.parameters[":page"]=nPage;
			stmt.execute(-1,responder);  	
		}
		
		public function prev():void
		{
			nPage-=50
			stmt.parameters[":page"]=nPage;
			stmt.execute(-1,responder);  
		}
		
		protected function resultHandler(result:SQLResult):void
		{
			
			if ( result.data!=null )
			{
				var numResults:int =result.data.length;
				
				for (var i:int = 0; i < numResults; i++) 
				{ 
					for (var j:String in result.data[i]) 
					{
						trace(j,result.data[i][j]);
					}
				} 
			}
		}
		
		protected function errorHandler(error:SQLError):void
		{
			trace(error.message);
			trace(error.details);
		}
		
		protected function onSQLEvent(event:SQLEvent):void
		{
			trace(event.type);
			switch(event.type)
			{
				case SQLEvent.OPEN:
					querytop1()
					break;
				
				case SQLEvent.RESULT:
					
					break;
				
			}
		}
		
		
		protected function onSQLErrorEvent(event:SQLErrorEvent):void
		{
			trace(event.type)
			switch(event.type)
			{
				case SQLErrorEvent.ERROR:
					
					break;
				
			}
		}
		
	}
}