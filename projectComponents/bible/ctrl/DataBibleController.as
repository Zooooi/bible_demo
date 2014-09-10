package projectComponents.bible.ctrl
{
	import JsC.events.JEvent;
	import JsA.data.SQLiteEvent;
	
	
	[Event(name="NEXT", type="JsC.events.JEvent")]
	[Event(name="PREV", type="JsC.events.JEvent")]
	
	
	public class DataBibleController extends DataBible
	{
		public const $total:uint = 50;
		public const $length:uint = $total / 2
		
		private var nPage:uint
		private var nLength:uint
		
		private var bNext:Boolean;
		private var bPrev:Boolean;
		
		public function DataBibleController()
		{
			super();
		}
		
		public function next():void
		{
			bNext = true;
			nPage += $length;
			nLength = $length
			queryBible()
		}
		
		public function prev():void
		{
			bPrev = true
			if (nPage==$total)
			{
				nPage = 0;
				nLength = $length
				queryBible()
				nPage += $length
			}else if(nPage>$length){
				nPage -= $total;
				nLength = $length
				queryBible()
				nPage += $length
			}
		}
		
		private function queryBible():void
		{
			runQuery(table_bible,{page:nPage,total:nLength})
		}
		
		override protected function onItemComplete(event:SQLiteEvent):void
		{
			super.onItemComplete(event);
			
			switch(event.name)
			{
				case table_bible:
					if (bNext){
						bNext = false
						dispatchEvent(new JEvent(JEvent.NEXT))
					}else if(bPrev){
						bPrev = false
						dispatchEvent(new JEvent(JEvent.PREV))
					}if (!bNext && !bPrev)
					{
						dispatchEvent(new JEvent(JEvent.COMPLETE));
					}
					break
			}
		}
		
	}
}