package projectClass.ctrl
{
	import flash.data.SQLResult;
	import flash.net.Responder;
	
	import JsA.data.SQLite;
	
	import JsC.events.JEvent;
	
	import projectClass.vo.v.FilesVO;
	
	
	[Event(name="NEXT", type="JsC.events.JEvent")]
	[Event(name="PREV", type="JsC.events.JEvent")]
	
	public class BibleDB extends SQLite
	{
		
		public const $total:uint = 50;
		public const $length:uint = $total / 2
		
		
		private const aBibleTable:Vector.<String> = Vector.<String>(["volumes","bible"]);
		
		private var currentTable:String
		private var nCounter:uint
		
		
		private var aVolumes:Vector.<Object>
		private var aBible:Vector.<Object>
		
		private var bNext:Boolean;
		private var bPrev:Boolean;
		
		
		
		public function BibleDB()
		{
			sql_text = "select * from bible limit :page,:total ";
		}
		
		
		public function load():void
		{
			responder= new Responder(result_init, errorHandler);
			open(FilesVO.file_bible,function():void{
				setTableName()
				queryVolume()
			})
		}
		
		
		public function getVoumes():Vector.<Object>
		{
			return aVolumes;
		}
		
		
		public function getBible():Vector.<Object>
		{
			return aBible
		}
		
		
		
		
		
		private function setTableName():void
		{
			currentTable = aBibleTable[nCounter]
			nCounter++
		}
		
		protected function queryVolume():void
		{
			query("select * from volumes ",responder)
		}
		
		/**
		 * 
		 * 第一次load bible
		 */		
		protected function queryBible():void
		{
			query(sql_text,responder,nPage,$total)
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
		
		override protected function onResult(result:SQLResult):void
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
		
		
		public function next():void
		{
			bNext = true;
			nPage += $length;
			nLength = $length
			getCurrentResult()
		}
		
		public function prev():void
		{
			bPrev = true
			if (nPage==$total)
			{
				nPage = 0;
				nLength = $length
				getCurrentResult()
				nPage += $length
			}else if(nPage>$length){
				nPage -= $total;
				nLength = $length
				getCurrentResult()
				nPage += $length
			}
		}
	}
}

class SQL_Data2
{
	
}
