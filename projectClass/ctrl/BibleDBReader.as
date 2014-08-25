package projectClass.ctrl
{
	
	import projectClass.vo.o.BibleOB;

	public class BibleDBReader extends BibleDB
	{
		
		public function BibleDBReader()
		{
			super();
		}
		
		public function pageFlip(_vo:BibleOB):void
		{
			var sql:String =  'select * from bible where "volume"=:volume and "chapter"=:chapter limit :page,:total '
			query(sql,responder,0,200,{volume:_vo.volume,chapter:_vo.nChapter});
		}
	}
}