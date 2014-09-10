package projectComponents.bible.ctrl
{
	import JsA.data.SQLiteCtrl;
	import JsA.data.SQLiteEvent;
	
	import projectClass.vo.o.BibleOB;
	import projectClass.vo.v.BibleVA;
	import projectClass.vo.v.LanVO;
	
	public class DataBible extends SQLiteCtrl
	{
		protected const table_volumes:String = "volumes"
		protected const table_volumeKind:String = "volumeKind"
		protected const table_bible:String = "bible"
		
		private var aVolumes:Vector.<BibleOB>
		private var aKind:Vector.<BibleOB>
		protected var aBible:Vector.<Object>
		
		
		public function DataBible()
		{
			super();
			addInitSQL(table_volumes, "select * from " + table_volumes)
			addInitSQL(table_volumeKind, "select * from " + table_volumeKind)
			
			addRunSQL(table_bible, "select * from bible limit :page,:total ")
			addEventListener(SQLiteEvent.INIT_COMPLETE,onInitEvent)
		}
		
		protected function onInitEvent(event:SQLiteEvent):void
		{
			var _vect:Vector.<String> = new Vector.<String>
			_vect.push(LanVO.getKey(LanVO.new_testament))
			_vect.push(LanVO.getKey(LanVO.old_testament))
		}		
		
		override protected function onItemComplete(event:SQLiteEvent):void
		{
			
			switch(event.name)
			{
				case table_volumes:
					aVolumes = getData(Vector.<Object>(event.data))
					break;
				
				case table_volumeKind:
					aKind = new Vector.<BibleOB>
					aKind.push(new BibleOB({volume:0,name:LanVO.getKey(LanVO.all_testament)}))
					aKind.push(new BibleOB({volume:BibleVA.num_old,name:LanVO.getKey(LanVO.old_testament)}))
					aKind.push(new BibleOB({volume:BibleVA.num_new,name:LanVO.getKey(LanVO.new_testament)}))
					var _array:Vector.<BibleOB> = getData(Vector.<Object>(event.data))
					for (var i:int = 0; i < _array.length; i++) 
					{
						aKind.push(_array[i]);
					}
					break
				
				case table_bible:
					aBible = Vector.<Object>(event.data)
					break
			}
		}
		
		
		
		private function getData(_vect:Vector.<Object>):Vector.<BibleOB>
		{
			var _array:Vector.<Object> = _vect
			var _data:Vector.<BibleOB> = new Vector.<BibleOB>
			for (var i:int = 0; i < _array.length; i++) 
			{
				var _vo:BibleOB = new BibleOB
				_vo.fill(_array[i])
				_data.push(_vo)
			}
			return _data
		}
		
		
	
		
		public function load(_file:String,_main:Boolean):void
		{
			sFile = _file
			if (_main) init()
		}
		
		
		public function queryVO(_vo:BibleOB):void
		{
			var sql_text:String =  'select * from bible where "volume"=:volume and "chapter"=:chapter limit :page,:total '
			currentTable = table_bible
			sql.query(sql_text,currentResponder,{page:0,total:200,volume:_vo.sn,chapter:_vo.nChapter});
		}
		
		
		
		
		public function getVoumes():Vector.<BibleOB>
		{
			return aVolumes;
		}
		
		public function getBible():Vector.<Object>
		{
			return aBible
		}
		
		
		public function getKinds():Vector.<BibleOB>
		{
			return aKind
		}
		
		
		
	
		
		
	}
}